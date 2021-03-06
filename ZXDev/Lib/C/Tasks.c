// Check the safety of adding a task (is this task not in the list?). HALT(25)
#define SAFE_SPAWN
// Check Run: is it called in "main" task? If not, HALT(22)
#define SAFE_RUN
// Is it possible to call Yield in "main" task? (to design universal procedures)
#define SAFE_YIELD

// ERRORS:
//   22 "Statement lost" - Run called in not "main" task
//   25 "Parameter error" - the task is already spawned
// http://www.worldofspectrum.org/ZXBasicManual/zxmanappb.html

typedef
  struct Tasks_Context {
    int SP, next;
    // char stack [N];
    // int IX, PC, _RETURN;
  } Tasks_Context;

int Tasks_myid; unsigned char Tasks_count; // Both must go together
int Tasks_current;

/*----------------------------------------------------------------------------*/
void Tasks_Spawn_Ex (Tasks_Context *ctx, unsigned int size, void (*proc)(void))
  __naked __z88dk_callee {

// Context = RECORD
//   SP, next: INTEGER;
//   stack: ARRAY N OF BYTE;
//   IX, PC, _RETURN: INTEGER;
// END;
/*
  // Find the last task in list
  if( Tasks_count == 0 ) {
    Tasks_current = (int)ctx; ctx->next = (int)ctx;
  } else { // Tasks_count >= 1
    int found = Tasks_current;
    for(;;) {
      if( found == (int)ctx ) HALT(25); // Already run
      if (((Tasks_Context*)found)->next == Tasks_current) break;
      found = ((Tasks_Context*)found)->next;
    }
    // Add new task into the list
    ((Tasks_Context*)found)->next = (int)ctx;
    ctx->next = (int)Tasks_current;
  }
  // Create stack for new task
  {
    int *stack = (int*)((int)ctx + size); // Top of stack
    stack--;                              // 2 bytes for RETURN
    *stack = (int)_Tasks_RETURN;          // RETURN entry point
    stack--;                              // 2 bytes for PC
    *stack = (int)proc;                   // task's entry point
    stack--;                              // 2 bytes for IX
    ctx->SP = (int)stack;                 // task's SP
    Tasks_count++;
  }
*/
  __asm
           LD   HL, #_Tasks_count
           LD   A, (HL)
           INC  (HL) // Tasks_count++;
    // void Tasks_Spawn_Ex (
    //   Tasks_Context *ctx, unsigned int size, void (*proc)(void))
    //     __z88dk_callee {
           POP  HL
           EX   (SP), HL             ; ctx
    // if( Tasks_count == 0 ) {
           OR   A
           JR   NZ, TASK_EXIST$
    //   Tasks_current = (int)ctx; ctx->next = (int)ctx;
           LD   (_Tasks_current), HL
           LD   E, L
           LD   D, H
           INC  HL
           INC  HL
           LD   (HL), E
           INC  HL
           LD   (HL), D
    // } else { // Tasks_count >= 1
           JR   CREATE_STK$
TASK_EXIST$:
    //   int found = Tasks_current;
           EX   DE, HL               ; DE = ctx
           LD   HL, (_Tasks_current) ; HL = found
           LD   C, L                 ;
           LD   B, H                 ; BC = current
    //   for(;;) {
FIND_TASK$:

#ifdef SAFE_SPAWN
    //     if( found == (int)ctx ) HALT(25);
           LD   A, L
           CP   E
           JR   NZ, NOT_EQUAL$
           LD   A, H
           CP   D
           JR   NZ, NOT_EQUAL$
           RST  8
           .DB  25
NOT_EQUAL$:
#endif

    //     if (((Tasks_Context*)found)->next == Tasks_current) break;
           INC  HL
           INC  HL
           LD   A, (HL)
           CP   C
           JR   NZ, FIND_NEXT$+1
           INC  HL
           LD   A, (HL)
           DEC  HL
           CP   B
           JR   Z, TASK_FOUND$
FIND_NEXT$:
           LD   A, (HL)
           INC  HL
           LD   H, (HL)
           LD   L, A
           JR   FIND_TASK$
TASK_FOUND$:
    //     found = ((Tasks_Context*)found)->next;
    //   }
    //   ((Tasks_Context*)found)->next = (int)ctx;
           LD   (HL), E
           INC  HL
           LD   (HL), D
    //   ctx->next = (int)Tasks_current;
           LD   L, E
           LD   H, D
           INC  HL
           INC  HL
           LD   (HL), C
           INC  HL
           LD   (HL), B
    // }
CREATE_STK$:                         ; DE = ctx
           POP  AF
           POP  HL                   ; HL = size
           POP  BC                   ; BC = proc
           PUSH AF
    // int *stack = (int*)((int)ctx + size); // Top of stack
           ADD  HL, DE               ; ctx + size
    // stack--;                              // 2 bytes for RETURN
    // *stack = (int)_Tasks_RETURN;          // RETURN entry point
           DEC  HL
           LD   (HL), #>__Tasks_RETURN
           DEC  HL
           LD   (HL), #<__Tasks_RETURN
    // stack--;                              // 2 bytes for PC
    // *stack = (int)proc;                   // task's entry point
           DEC  HL
           LD   (HL), B
           DEC  HL
           LD   (HL), C
    // stack--;                              // 2 bytes for IX
           DEC  HL
           DEC  HL
    // ctx->SP = (int)stack;                 // task's SP
           EX   DE, HL
           LD   (HL), E
           INC  HL
           LD   (HL), D
           RET
  __endasm;
} //Tasks_Spawn_Ex

/*----------------------------------------------------------------------------*/
void Tasks_Run (void) __naked { // Run MUST be started in "main" task
  __asm

#ifdef SAFE_RUN
           LD   A, (_Tasks_count)    ;
           OR   A                    ;
           RET  Z                    ; IF count = 0 THEN RETURN
           LD   A, (_Tasks_myid+1)   ;
           OR   A                    ;
           JR   NZ, HALT_22$         ; IF ~ (myid IN {0..255}) THEN HALT(22)
#endif

// Save IX, SP
           PUSH IX
           LD   (__Run_SP+1), SP
           
// Call one atom of the current task (until Yield or RETURN)
           LD   HL, (_Tasks_current) ; ADR(Context.SP)
           LD   (_Tasks_myid), HL
           LD   A, (HL) ; 7
           INC  HL      ; 6
           LD   H, (HL) ; 7
           LD   L, A    ; 4
           LD   SP, HL  ; 6 => 30    ; (Context.SP)
           POP  IX
           RET                       ; CALL current task

#ifdef SAFE_RUN
HALT_22$:  RST  8
           .DB  22                   ; "Statement lost"
#endif

  __endasm;
} //Tasks_Run

/*----------------------------------------------------------------------------*/
void Tasks_Yield (void) __naked { // Yield MUST NOT be started in "main" task
  __asm
.globl __Run_SP

#ifdef SAFE_YIELD
           LD   HL, #_Tasks_myid+1   ;
           XOR  A                    ;
           CP   (HL)                 ; IF myid IN {0..255} THEN RETURN
           RET  Z                    ;
           LD   (HL), A              ; myid := 0
           DEC  HL                   ;
           LD   (HL), A              ;
#else
           LD   HL, #0               ;
           LD   (_Tasks_myid), HL    ; myid := 0
#endif

// Save current context (IX, SP)
           PUSH IX
           LD   HL, (_Tasks_current) ; ADR(Context.SP)
           LD   (Temp_SP$+2), HL
Temp_SP$:  LD   (0), SP

// Load Run context (IX, SP)
__Run_SP:  LD   SP, #0
           POP  IX

// Go to next task
           INC  HL
           INC  HL                   ; ADR(Context.next)
           LD   A, (HL)
           INC  HL
           LD   H, (HL)
           LD   L, A
           LD   (_Tasks_current), HL ; (Context.next)

// Run RETURN
           RET
  __endasm;
} //Tasks_Yield

/*----------------------------------------------------------------------------*/
void _Tasks_RETURN (void) __naked {
  __asm
           XOR  A                    ;
           LD   HL, #_Tasks_myid     ;
           LD   (HL), A              ;
           INC  HL                   ; myid := 0
           LD   (HL), A              ;
           INC  HL                   ;
           DEC  (HL)                 ; DEC(count)
           LD   HL, (_Tasks_current) ; ADR(Context.SP)
           JR   Z, __Run_SP

// Remove completed task from list, update Context.next
/*
    int found = Tasks_current;
    for(;;) {
      if (((Tasks_Context*)found)->next == Tasks_current) break;
      found = ((Tasks_Context*)found)->next;
    }
    // Remove this task from the list
    ((Tasks_Context*)found)->next = (int)Tasks_current->next;
*/
    //   int found = Tasks_current;
                                     ; HL = found
           LD   C, L                 ;
           LD   B, H                 ; BC = current
    //   for(;;) {
FIND_LAST$:
    //     if (((Tasks_Context*)found)->next == Tasks_current) break;
           INC  HL
           INC  HL
           LD   A, (HL)
           CP   C
           JR   NZ, FIND_NXT$+1
           INC  HL
           LD   A, (HL)
           DEC  HL
           CP   B
           JR   Z, LAST_FOUND$
FIND_NXT$:
           LD   A, (HL)
           INC  HL
           LD   H, (HL)
           LD   L, A
           JR   FIND_LAST$
LAST_FOUND$:

    //     found = ((Tasks_Context*)found)->next;
    //   }
    //   ((Tasks_Context*)found)->next = (int)Tasks_current->next;
           INC  BC
           INC  BC
           LD   A, (BC)
           LD   (HL), A
           INC  BC
           INC  HL
           LD   A, (BC)
           LD   (HL), A

// Load Run context (IX, SP)
           LD   HL, (_Tasks_current)
           JR   __Run_SP
  __endasm;
} //_Tasks_RETURN

/*----------------------------------------------------------------------------*/
void Tasks__init (void) {
  __asm
           XOR  A                    ;
           LD   HL, #_Tasks_myid     ;
           LD   (HL), A              ;
           INC  HL                   ; myid := 0
           LD   (HL), A              ;
           INC  HL                   ;
           LD   (HL), A              ; count := 0
  __endasm;

} //Tasks__init
