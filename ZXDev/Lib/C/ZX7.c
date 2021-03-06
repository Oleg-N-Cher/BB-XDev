void ZX7_Standard (unsigned int src, unsigned int dst) __z88dk_callee;
void ZX7_Turbo (unsigned int src, unsigned int dst) __z88dk_callee;
void ZX7_Mega (unsigned int src, unsigned int dst) __z88dk_callee;
void ZX7_SmartRCS (unsigned int src, unsigned int dst) __z88dk_callee;
void ZX7_AgileRCS (unsigned int src, unsigned int dst) __z88dk_callee;
/*================================== Header ==================================*/

void ZX7_Standard (unsigned int src, unsigned int dst) __naked __z88dk_callee {
  __asm
        pop  bc         ; RET address
        pop  hl         ; HL=src
        pop  de         ; DE=dst
        push bc         ; restore RET address

; -----------------------------------------------------------------------------
; ZX7 decoder by Einar Saukas, Antonio Villena & Metalbrain
; "Standard" version (69 bytes only)
; -----------------------------------------------------------------------------
; Parameters:
;   HL: source address (compressed data)
;   DE: destination address (decompressing)
; -----------------------------------------------------------------------------

dzx7_standard:
        ld      a, #0x80
dzx7s_copy_byte_loop:
        ldi                             ; copy literal byte
dzx7s_main_loop:
        call    dzx7s_next_bit
        jr      nc, dzx7s_copy_byte_loop ; next bit indicates either literal or sequence

; determine number of bits used for length (Elias gamma coding)
        push    de
        ld      bc, #0
        ld      d, b
dzx7s_len_size_loop:
        inc     d
        call    dzx7s_next_bit
        jr      nc, dzx7s_len_size_loop

; determine length
dzx7s_len_value_loop:
        call    nc, dzx7s_next_bit
        rl      c
        rl      b
        jr      c, dzx7s_exit           ; check end marker
        dec     d
        jr      nz, dzx7s_len_value_loop
        inc     bc                      ; adjust length

; determine offset
        ld      e, (hl)                 ; load offset flag (1 bit) + offset value (7 bits)
        inc     hl
        .db     #0xcb, #0x33            ; opcode for undocumented instruction "SLL E" aka "SLS E"
        jr      nc, dzx7s_offset_end    ; if offset flag is set, load 4 extra bits
        ld      d, #0x10                ; bit marker to load 4 bits
dzx7s_rld_next_bit:
        call    dzx7s_next_bit
        rl      d                       ; insert next bit into D
        jr      nc, dzx7s_rld_next_bit  ; repeat 4 times, until bit marker is out
        inc     d                       ; add 128 to DE
        srl	d			; retrieve fourth bit from D
dzx7s_offset_end:
        rr      e                       ; insert fourth bit into E

; copy previous sequence
        ex      (sp), hl                ; store source, restore destination
        push    hl                      ; store destination
        sbc     hl, de                  ; HL = destination - offset - 1
        pop     de                      ; DE = destination
        ldir
dzx7s_exit:
        pop     hl                      ; restore source address (compressed data)
        jr      nc, dzx7s_main_loop
dzx7s_next_bit:
        add     a, a                    ; check next bit
        ret     nz                      ; no more bits left?
        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        ret

; -----------------------------------------------------------------------------
  __endasm;
} //ZX7_Standard

/*--------------------------------- Cut here ---------------------------------*/
void ZX7_Turbo (unsigned int src, unsigned int dst) __naked __z88dk_callee {
  __asm
        pop  bc         ; RET address
        pop  hl         ; HL=src
        pop  de         ; DE=dst
        push bc         ; restore RET address

; -----------------------------------------------------------------------------
; ZX7 decoder by Einar Saukas & Urusergi
; "Turbo" version (88 bytes, 25% faster)
; -----------------------------------------------------------------------------
; Parameters:
;   HL: source address (compressed data)
;   DE: destination address (decompressing)
; -----------------------------------------------------------------------------

dzx7_turbo:
        ld      a, #0x80
dzx7t_copy_byte_loop:
        ldi                             ; copy literal byte
dzx7t_main_loop:
        add     a, a                    ; check next bit
        call    z, dzx7t_load_bits      ; no more bits left?
        jr      nc, dzx7t_copy_byte_loop ; next bit indicates either literal or sequence

; determine number of bits used for length (Elias gamma coding)
        push    de
        ld      bc, #1
        ld      d, b
dzx7t_len_size_loop:
        inc     d
        add     a, a                    ; check next bit
        call    z, dzx7t_load_bits      ; no more bits left?
        jr      nc, dzx7t_len_size_loop
        jp      dzx7t_len_value_start

; determine length
dzx7t_len_value_loop:
        add     a, a                    ; check next bit
        call    z, dzx7t_load_bits      ; no more bits left?
        rl      c
        rl      b
        jr      c, dzx7t_exit           ; check end marker
dzx7t_len_value_start:
        dec     d
        jr      nz, dzx7t_len_value_loop
        inc     bc                      ; adjust length

; determine offset
        ld      e, (hl)                 ; load offset flag (1 bit) + offset value (7 bits)
        inc     hl
        .db     #0xcb, #0x33            ; opcode for undocumented instruction "SLL E" aka "SLS E"
        jr      nc, dzx7t_offset_end    ; if offset flag is set, load 4 extra bits
        add     a, a                    ; check next bit
        call    z, dzx7t_load_bits      ; no more bits left?
        rl      d                       ; insert first bit into D
        add     a, a                    ; check next bit
        call    z, dzx7t_load_bits      ; no more bits left?
        rl      d                       ; insert second bit into D
        add     a, a                    ; check next bit
        call    z, dzx7t_load_bits      ; no more bits left?
        rl      d                       ; insert third bit into D
        add     a, a                    ; check next bit
        call    z, dzx7t_load_bits      ; no more bits left?
        ccf
        jr      c, dzx7t_offset_end
        inc     d                       ; equivalent to adding 128 to DE
dzx7t_offset_end:
        rr      e                       ; insert inverted fourth bit into E

; copy previous sequence
        ex      (sp), hl                ; store source, restore destination
        push    hl                      ; store destination
        sbc     hl, de                  ; HL = destination - offset - 1
        pop     de                      ; DE = destination
        ldir
dzx7t_exit:
        pop     hl                      ; restore source address (compressed data)
        jp      nc, dzx7t_main_loop

dzx7t_load_bits:
        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        ret

; -----------------------------------------------------------------------------
  __endasm;
} //ZX7_Turbo

/*--------------------------------- Cut here ---------------------------------*/
void ZX7_Mega (unsigned int src, unsigned int dst) __naked __z88dk_callee {
  __asm
        pop  bc         ; RET address
        pop  hl         ; HL=src
        pop  de         ; DE=dst
        push bc         ; restore RET address

; -----------------------------------------------------------------------------
; ZX7 decoder by Einar Saukas
; "Mega" version (244 bytes, 30% faster)
; -----------------------------------------------------------------------------
; Parameters:
;   HL: source address (compressed data)
;   DE: destination address (decompressing)
; -----------------------------------------------------------------------------

dzx7_mega:
        ld      a, #0x80
dzx7m_copy_byte_loop_ev:
        ldi                             ; copy literal byte
dzx7m_main_loop_ev:
        add     a, a                    ; check next bit
        jr      z, dzx7m_load_bits1     ; no more bits left?
        jr      c, dzx7m_len_size_start_od ; next bit indicates either literal or sequence

dzx7m_copy_byte_loop_od:
        ldi                             ; copy literal byte
dzx7m_main_loop_od:
        add     a, a                    ; check next bit
        jr      nc, dzx7m_copy_byte_loop_ev ; next bit indicates either literal or sequence

dzx7m_len_size_start_ev:
; determine number of bits used for length (Elias gamma coding)
        push    de
        ld      bc, #1
        ld      d, b
dzx7m_len_size_loop_ev:
        inc     d
        add     a, a                    ; check next bit
        jr      z, dzx7m_load_bits2_ev  ; no more bits left?
        jr      nc, dzx7m_len_size_loop_ev
        jp      dzx7m_len_value_start_ev

dzx7m_len_size_start_od:
; determine number of bits used for length (Elias gamma coding)
        push    de
        ld      bc, #1
        ld      d, b
dzx7m_len_size_loop_od:
        inc     d
        add     a, a                    ; check next bit
        jr      z, dzx7m_load_bits2_od  ; no more bits left?
        jr      nc, dzx7m_len_size_loop_od
        jp      dzx7m_len_value_start_od

; determine length
dzx7m_len_value_loop_ev:
        add     a, a                    ; check next bit
        jr      z, dzx7m_load_bits3_ev  ; no more bits left?
        rl      c
        rl      b
        jr      c, dzx7m_exit_ev        ; check end marker
dzx7m_len_value_start_ev:
        dec     d
        jr      nz, dzx7m_len_value_loop_ev
        inc     bc                      ; adjust length
dzx7m_offset_start_od:
; determine offset
        ld      e, (hl)                 ; load offset flag (1 bit) + offset value (7 bits)
        inc     hl
        .db     #0xcb, #0x33            ; opcode for undocumented instruction "SLL E" aka "SLS E"
        jr      nc, dzx7m_offset_end_od ; if offset flag is set, load 4 extra bits
        add     a, a                    ; check next bit
        rl      d                       ; insert first bit into D
        add     a, a                    ; check next bit
        jr      z, dzx7m_load_bits4     ; no more bits left?
        rl      d                       ; insert second bit into D
        add     a, a                    ; check next bit
        rl      d                       ; insert third bit into D
        add     a, a                    ; check next bit
        jr      z, dzx7m_load_bits5     ; no more bits left?
        ccf
        jr      c, dzx7m_offset_end_od
dzx7m_offset_inc_od:
        inc     d                       ; equivalent to adding 128 to DE
dzx7m_offset_end_od:
        rr      e                       ; insert inverted fourth bit into E
; copy previous sequence
        ex      (sp), hl                ; store source, restore destination
        push    hl                      ; store destination
        sbc     hl, de                  ; HL = destination - offset - 1
        pop     de                      ; DE = destination
        ldir
        pop     hl                      ; restore source address (compressed data)
        jp      dzx7m_main_loop_od

dzx7m_load_bits1:
        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        jr      c, dzx7m_len_size_start_od ; next bit indicates either literal or sequence
        jp      dzx7m_copy_byte_loop_od

dzx7m_load_bits2_ev:
        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        jr      nc, dzx7m_len_size_loop_ev
        jp      dzx7m_len_value_start_ev

dzx7m_load_bits2_od:
        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        jr      nc, dzx7m_len_size_loop_od
        jp      dzx7m_len_value_start_od

dzx7m_load_bits3_ev:
        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        rl      c
        rl      b
        jp      nc, dzx7m_len_value_start_ev ; check end marker
dzx7m_exit_ev:
        pop     de
        ret

dzx7m_load_bits4:
        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        rl      d                       ; insert second bit into D
        add     a, a                    ; check next bit
        rl      d                       ; insert third bit into D
        add     a, a                    ; check next bit
        ccf
        jr      c, dzx7m_offset_end_od
        jp      dzx7m_offset_inc_od

dzx7m_load_bits5:
        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        ccf
        jr      c, dzx7m_offset_end_od
        jp      dzx7m_offset_inc_od

; determine length
dzx7m_len_value_loop_od:
        add     a, a                    ; check next bit
        jr      z, dzx7m_load_bits3_od  ; no more bits left?
        rl      c
        rl      b
        jr      c, dzx7m_exit_od        ; check end marker
dzx7m_len_value_start_od:
        dec     d
        jr      nz, dzx7m_len_value_loop_od
        inc     bc                      ; adjust length
dzx7m_offset_start_ev:
; determine offset
        ld      e, (hl)                 ; load offset flag (1 bit) + offset value (7 bits)
        inc     hl
        .db     #0xcb, #0x33            ; opcode for undocumented instruction "SLL E" aka "SLS E"
        jr      nc, dzx7m_offset_end_ev ; if offset flag is set, load 4 extra bits
        add     a, a                    ; check next bit
        jr      z, dzx7m_load_bits6     ; no more bits left?
        rl      d                       ; insert first bit into D
        add     a, a                    ; check next bit
        rl      d                       ; insert second bit into D
        add     a, a                    ; check next bit
        jr      z, dzx7m_load_bits7     ; no more bits left?
        rl      d                       ; insert third bit into D
        add     a, a                    ; check next bit
        ccf
        jr      c, dzx7m_offset_end_ev
dzx7m_offset_inc_ev:
        inc     d                       ; equivalent to adding 128 to DE
dzx7m_offset_end_ev:
        rr      e                       ; insert inverted fourth bit into E
; copy previous sequence
        ex      (sp), hl                ; store source, restore destination
        push    hl                      ; store destination
        sbc     hl, de                  ; HL = destination - offset - 1
        pop     de                      ; DE = destination
        ldir
        pop     hl                      ; restore source address (compressed data)
        jp      dzx7m_main_loop_ev

dzx7m_load_bits3_od:
        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        rl      c
        rl      b
        jp      nc, dzx7m_len_value_start_od ; check end marker
dzx7m_exit_od:
        pop     de
        ret

dzx7m_load_bits6:
        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        rl      d                       ; insert first bit into D
        add     a, a                    ; check next bit
        rl      d                       ; insert second bit into D
        add     a, a                    ; check next bit
        rl      d                       ; insert third bit into D
        add     a, a                    ; check next bit
        ccf
        jr      c, dzx7m_offset_end_ev
        jp      dzx7m_offset_inc_ev

dzx7m_load_bits7:
        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        rl      d                       ; insert third bit into D
        add     a, a                    ; check next bit
        ccf
        jr      c, dzx7m_offset_end_ev
        jp      dzx7m_offset_inc_ev

; -----------------------------------------------------------------------------
  __endasm;
} //ZX7_Mega

/*--------------------------------- Cut here ---------------------------------*/
void ZX7_SmartRCS (unsigned int src, unsigned int dst) __naked __z88dk_callee {
  __asm
        pop  bc         ; RET address
        pop  hl         ; HL=src
        pop  de         ; DE=dst
        push bc         ; restore RET address

; -----------------------------------------------------------------------------
; "Smart" integrated RCS+ZX7 decoder by Einar Saukas (110 bytes)
; -----------------------------------------------------------------------------
; Parameters:
;   HL: source address (compressed data)
;   DE: destination address (decompressing)
; -----------------------------------------------------------------------------

dzx7_smartrcs:
        ld      a, #0x80
dzx7r_copy_byte_loop:
        call    dzx7r_copy_byte         ; copy literal byte
dzx7r_main_loop:
        call    dzx7r_next_bit
        jr      nc, dzx7r_copy_byte_loop ; next bit indicates either literal or sequence

; determine number of bits used for length (Elias gamma coding)
        push    de
        ld      bc, #0
        ld      d, b
dzx7r_len_size_loop:
        inc     d
        call    dzx7r_next_bit
        jr      nc, dzx7r_len_size_loop

; determine length
dzx7r_len_value_loop:
        call    nc, dzx7r_next_bit
        rl      c
        rl      b
        jr      c, dzx7r_exit           ; check end marker
        dec     d
        jr      nz, dzx7r_len_value_loop
        inc     bc                      ; adjust length

; determine offset
        ld      e, (hl)                 ; load offset flag (1 bit) + offset value (7 bits)
        inc     hl
        .db     #0xcb, #0x33            ; opcode for undocumented instruction "SLL E" aka "SLS E"
        jr      nc, dzx7r_offset_end    ; if offset flag is set, load 4 extra bits
        ld      d, #0x10                ; bit marker to load 4 bits
dzx7r_rld_next_bit:
        call    dzx7r_next_bit
        rl      d                       ; insert next bit into D
        jr      nc, dzx7r_rld_next_bit  ; repeat 4 times, until bit marker is out
        inc     d                       ; add 128 to DE
        srl	d			; retrieve fourth bit from D
dzx7r_offset_end:
        rr      e                       ; insert fourth bit into E

; copy previous sequence
        ex      (sp), hl                ; store source, restore destination
        push    hl                      ; store destination
        sbc     hl, de                  ; HL = destination - offset - 1
        pop     de                      ; DE = destination
dzx7r_copy_bytes:
        push    hl
        ex      de, hl
        call    dzx7r_convert
        ex      de, hl
        call    dzx7r_copy_byte
        pop     hl
        inc     hl
        jp      pe, dzx7r_copy_bytes
        pop     hl                      ; restore source address (compressed data)
        jr      dzx7r_main_loop

dzx7r_next_bit:
        add     a, a                    ; check next bit
        ret     nz                      ; no more bits left?
        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        ret

dzx7r_copy_byte:
        push    de
        call    dzx7r_convert
        ldi
dzx7r_exit:
        pop     de
        inc     de
        ret

; Convert an RCS address 010RRccc ccrrrppp to screen address 010RRppp rrrccccc
; (note: replace both EX AF,AF' with PUSH AF/POP AF if you want to preserve AF')
dzx7r_convert:
        ex      af, af
        ld      a, d                    ; A = 010RRccc
        cp      #0x58
        jr      nc, dzx7r_skip
        xor     e
        and     #0xf8
        xor     e                       ; A = 010RRppp
        push    af
        xor     d
        xor     e                       ; A = ccrrrccc
        rlca
        rlca                            ; A = rrrccccc
        pop     de                      ; D = 010RRppp
        ld      e, a                    ; E = rrrccccc
dzx7r_skip:
        ex      af, af
        ret

; -----------------------------------------------------------------------------
  __endasm;
} //ZX7_SmartRCS

/*--------------------------------- Cut here ---------------------------------*/
void ZX7_AgileRCS (unsigned int src, unsigned int dst) __naked __z88dk_callee {
  __asm
        pop  bc         ; RET address
        pop  hl         ; HL=src
        pop  de         ; DE=dst
        push bc         ; restore RET address

; -----------------------------------------------------------------------------
; "Agile" integrated RCS+ZX7 decoder by Einar Saukas (150 bytes)
; -----------------------------------------------------------------------------
; Parameters:
;   HL: source address (compressed data)
;   DE: destination address (decompressing)
; -----------------------------------------------------------------------------

dzx7_agilercs:
        ld      a, #0x80
dzx7a_copy_byte_loop1:
        ex      af, af
        call    dzx7a_copy_byte         ; copy literal byte
dzx7a_main_loop1:
        ex      af, af
        add     a, a                    ; check next bit
        call    z, dzx7a_load_bits      ; no more bits left?
        jr      nc, dzx7a_copy_byte_loop1 ; next bit indicates either literal or sequence
        jr      dzx7a_len_size_start

dzx7a_copy_byte_loop:
        ldi                             ; copy literal byte
dzx7a_main_loop:
        add     a, a                    ; check next bit
        call    z, dzx7a_load_bits      ; no more bits left?
        jr      nc, dzx7a_copy_byte_loop ; next bit indicates either literal or sequence

dzx7a_len_size_start:
; determine number of bits used for length (Elias gamma coding)
        push    de
        ld      bc, #1
        ld      d, b
dzx7a_len_size_loop:
        inc     d
        add     a, a                    ; check next bit
        call    z, dzx7a_load_bits      ; no more bits left?
        jr      nc, dzx7a_len_size_loop
        jp      dzx7a_len_value_start

; determine length
dzx7a_len_value_loop:
        add     a, a                    ; check next bit
        call    z, dzx7a_load_bits      ; no more bits left?
        rl      c
        rl      b
        jr      c, dzx7a_exit           ; check end marker
dzx7a_len_value_start:
        dec     d
        jr      nz, dzx7a_len_value_loop
        inc     bc                      ; adjust length

; determine offset
        ld      e, (hl)                 ; load offset flag (1 bit) + offset value (7 bits)
        inc     hl
        .db     #0xcb, #0x33            ; opcode for undocumented instruction "SLL E" aka "SLS E"
        jr      nc, dzx7a_offset_end    ; if offset flag is set, load 4 extra bits
        add     a, a                    ; check next bit
        call    z, dzx7a_load_bits      ; no more bits left?
        rl      d                       ; insert first bit into D
        add     a, a                    ; check next bit
        call    z, dzx7a_load_bits      ; no more bits left?
        rl      d                       ; insert second bit into D
        add     a, a                    ; check next bit
        call    z, dzx7a_load_bits      ; no more bits left?
        rl      d                       ; insert third bit into D
        add     a, a                    ; check next bit
        call    z, dzx7a_load_bits      ; no more bits left?
        ccf
        jr      c, dzx7a_offset_end
        inc     d                       ; equivalent to adding 128 to DE
dzx7a_offset_end:
        rr      e                       ; insert inverted fourth bit into E

; copy previous sequence
        ex      (sp), hl                ; store source, restore destination
        push    hl                      ; store destination
        sbc     hl, de                  ; HL = destination - offset - 1
        pop     de                      ; DE = destination
        ex      af, af
        ld      a, h                    ; A = 010RRccc
        cp      #0x58
        jr      c, dzx7a_copy_bytes
        ldir
        pop     hl                      ; restore source address (compressed data)
        ex      af, af
        jp      dzx7a_main_loop

dzx7a_copy_bytes:
        push    hl
        ex      de, hl
        call    dzx7a_convert
        ex      de, hl
        call    dzx7a_copy_byte
        pop     hl
        inc     hl
        jp      pe, dzx7a_copy_bytes
        pop     hl                      ; restore source address (compressed data)
        jr      dzx7a_main_loop1

dzx7a_load_bits:
        ld      a, (hl)                 ; load another group of 8 bits
        inc     hl
        rla
        ret

dzx7a_copy_byte:
        push    de
        call    dzx7a_convert
        ldi
dzx7a_exit:
        pop     de
        inc     de
        ret

; Convert an RCS address 010RRccc ccrrrppp to screen address 010RRppp rrrccccc
; (Note: replace both EX AF,AF' with PUSH AF/POP AF if you want to preserve AF')
dzx7a_convert:
        ld      a, d                    ; A = 010RRccc
        cp      #0x58
        ret     nc
        xor     e
        and     #0xf8
        xor     e                       ; A = 010RRppp
        push    af
        xor     d
        xor     e                       ; A = ccrrrccc
        rlca
        rlca                            ; A = rrrccccc
        pop     de                      ; D = 010RRppp
        ld      e, a                    ; E = rrrccccc
        ret

; -----------------------------------------------------------------------------
  __endasm;
} //ZX7_AgileRCS
