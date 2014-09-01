	;; Generic crt0.s for a Z80
	.globl	_main

	.area _HEADER (ABS)
	;; Reset vector
        .org    0x4000
        .db     0x41
        .db     0x42
        .dw     init
        .dw     0x0000
        .dw     0x0000
        .dw     0x0000
        .dw     0x0000
        .dw     0x0000
        .dw     0x0000

init:
	;; Stack at the top of memory.
        ld      sp,(0xfc4a)        

        ;; Initialise global variables
	call	_main

	;; Ordering of segments for the linker.
	.area	_CODE
        .area   _GSINIT
        .area   _GSFINAL
        
	.area	_DATA
        .area   _BSS

        .area   _CODE

        ;; Special RLE decoder used for initing global data

__initrleblock::
        ;; Pull the destination address out
        ld      c,l
        ld      b,h
        
        ;; Pop the return address
        pop     hl
1$:
        ;; Fetch the run
        ld      e,(hl)
        inc     hl
        ;; Negative means a run
        bit     7,e
        jp      z,2$
        ;; Code for expanding a run
        ld      a,(hl)
        inc     hl
3$:
        ld      (bc),a
        inc     bc
        inc     e
        jp      nz,3$
        jp      1$
2$:
        ;; Zero means end of a block
        xor     a
        or      e
        jp      z,4$
        ;; Code for expanding a block
5$:     
        ld      a,(hl)        
        inc     hl
        ld      (bc),a
        inc     bc
        dec     e
        jp      nz,5$
        jp      1$
4$:     
        ;; Push the return address back onto the stack
        push    hl
        ret

        .area   _GSINIT
gsinit::	

        .area   _GSFINAL
        ret
