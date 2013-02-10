This is Info file as.info, produced by Makeinfo version 1.67 from the
input file ./as.texinfo.

START-INFO-DIR-ENTRY
* As: (as).                     The GNU assembler.
END-INFO-DIR-ENTRY

   This file documents the GNU Assembler "as".

   Copyright (C) 1991, 92, 93, 94, 95, 96, 1997 Free Software
Foundation, Inc.

   Permission is granted to make and distribute verbatim copies of this
manual provided the copyright notice and this permission notice are
preserved on all copies.

   Permission is granted to copy and distribute modified versions of
this manual under the conditions for verbatim copying, provided that
the entire resulting derived work is distributed under the terms of a
permission notice identical to this one.

   Permission is granted to copy and distribute translations of this
manual into another language, under the above conditions for modified
versions.


File: as.info,  Node: Nolist,  Next: Octa,  Prev: MRI,  Up: Pseudo Ops

`.nolist'
=========

   Control (in conjunction with the `.list' directive) whether or not
assembly listings are generated.  These two directives maintain an
internal counter (which is zero initially).   `.list' increments the
counter, and `.nolist' decrements it.  Assembly listings are generated
whenever the counter is greater than zero.


File: as.info,  Node: Octa,  Next: Org,  Prev: Nolist,  Up: Pseudo Ops

`.octa BIGNUMS'
===============

   This directive expects zero or more bignums, separated by commas.
For each bignum, it emits a 16-byte integer.

   The term "octa" comes from contexts in which a "word" is two bytes;
hence *octa*-word for 16 bytes.


File: as.info,  Node: Org,  Next: P2align,  Prev: Octa,  Up: Pseudo Ops

`.org NEW-LC , FILL'
====================

   Advance the location counter of the current section to NEW-LC.
NEW-LC is either an absolute expression or an expression with the same
section as the current subsection.  That is, you can't use `.org' to
cross sections: if NEW-LC has the wrong section, the `.org' directive
is ignored.  To be compatible with former assemblers, if the section of
NEW-LC is absolute, `as' issues a warning, then pretends the section of
NEW-LC is the same as the current subsection.

   `.org' may only increase the location counter, or leave it
unchanged; you cannot use `.org' to move the location counter backwards.

   Because `as' tries to assemble programs in one pass, NEW-LC may not
be undefined.  If you really detest this restriction we eagerly await a
chance to share your improved assembler.

   Beware that the origin is relative to the start of the section, not
to the start of the subsection.  This is compatible with other people's
assemblers.

   When the location counter (of the current subsection) is advanced,
the intervening bytes are filled with FILL which should be an absolute
expression.  If the comma and FILL are omitted, FILL defaults to zero.


File: as.info,  Node: P2align,  Next: Psize,  Prev: Org,  Up: Pseudo Ops

`.p2align[wl] ABS-EXPR, ABS-EXPR, ABS-EXPR'
===========================================

   Pad the location counter (in the current subsection) to a particular
storage boundary.  The first expression (which must be absolute) is the
number of low-order zero bits the location counter must have after
advancement.  For example `.p2align 3' advances the location counter
until it a multiple of 8.  If the location counter is already a
multiple of 8, no change is needed.

   The second expression (also absolute) gives the fill value to be
stored in the padding bytes.  It (and the comma) may be omitted.  If it
is omitted, the padding bytes are normally zero.  However, on some
systems, if the section is marked as containing code and the fill value
is omitted, the space is filled with no-op instructions.

   The third expression is also absolute, and is also optional.  If it
is present, it is the maximum number of bytes that should be skipped by
this alignment directive.  If doing the alignment would require
skipping more bytes than the specified maximum, then the alignment is
not done at all.  You can omit the fill value (the second argument)
entirely by simply using two commas after the required alignment; this
can be useful if you want the alignment to be filled with no-op
instructions when appropriate.

   The `.p2alignw' and `.p2alignl' directives are variants of the
`.p2align' directive.  The `.p2alignw' directive treats the fill
pattern as a two byte word value.  The `.p2alignl' directives treats the
fill pattern as a four byte longword value.  For example, `.p2alignw
2,0x368d' will align to a multiple of 4.  If it skips two bytes, they
will be filled in with the value 0x368d (the exact placement of the
bytes depends upon the endianness of the processor).  If it skips 1 or
3 bytes, the fill value is undefined.


File: as.info,  Node: Psize,  Next: Quad,  Prev: P2align,  Up: Pseudo Ops

`.psize LINES , COLUMNS'
========================

   Use this directive to declare the number of lines--and, optionally,
the number of columns--to use for each page, when generating listings.

   If you do not use `.psize', listings use a default line-count of 60.
You may omit the comma and COLUMNS specification; the default width is
200 columns.

   `as' generates formfeeds whenever the specified number of lines is
exceeded (or whenever you explicitly request one, using `.eject').

   If you specify LINES as `0', no formfeeds are generated save those
explicitly specified with `.eject'.


File: as.info,  Node: Quad,  Next: Rept,  Prev: Psize,  Up: Pseudo Ops

`.quad BIGNUMS'
===============

   `.quad' expects zero or more bignums, separated by commas.  For each
bignum, it emits an 8-byte integer.  If the bignum won't fit in 8
bytes, it prints a warning message; and just takes the lowest order 8
bytes of the bignum.

   The term "quad" comes from contexts in which a "word" is two bytes;
hence *quad*-word for 8 bytes.


File: as.info,  Node: Rept,  Next: Sbttl,  Prev: Quad,  Up: Pseudo Ops

`.rept COUNT'
=============

   Repeat the sequence of lines between the `.rept' directive and the
next `.endr' directive COUNT times.

   For example, assembling

             .rept   3
             .long   0
             .endr

   is equivalent to assembling

             .long   0
             .long   0
             .long   0


File: as.info,  Node: Sbttl,  Next: Scl,  Prev: Rept,  Up: Pseudo Ops

`.sbttl "SUBHEADING"'
=====================

   Use SUBHEADING as the title (third line, immediately after the title
line) when generating assembly listings.

   This directive affects subsequent pages, as well as the current page
if it appears within ten lines of the top of a page.


File: as.info,  Node: Scl,  Next: Section,  Prev: Sbttl,  Up: Pseudo Ops

`.scl CLASS'
============

   Set the storage-class value for a symbol.  This directive may only be
used inside a `.def'/`.endef' pair.  Storage class may flag whether a
symbol is static or external, or it may record further symbolic
debugging information.

   The `.scl' directive is primarily associated with COFF output; when
configured to generate `b.out' output format, `as' accepts this
directive but ignores it.


File: as.info,  Node: Section,  Next: Set,  Prev: Scl,  Up: Pseudo Ops

`.section NAME'
===============

   Use the `.section' directive to assemble the following code into a
section named NAME.

   This directive is only supported for targets that actually support
arbitrarily named sections; on `a.out' targets, for example, it is not
accepted, even with a standard `a.out' section name.

   For COFF targets, the `.section' directive is used in one of the
following ways:
     .section NAME[, "FLAGS"]
     .section NAME[, SUBSEGMENT]

   If the optional argument is quoted, it is taken as flags to use for
the section.  Each flag is a single character.  The following flags are
recognized:
`b'
     bss section (uninitialized data)

`n'
     section is not loaded

`w'
     writable section

`d'
     data section

`r'
     read-only section

`x'
     executable section

   If no flags are specified, the default flags depend upon the section
name.  If the section name is not recognized, the default will be for
the section to be loaded and writable.

   If the optional argument to the `.section' directive is not quoted,
it is taken as a subsegment number (*note Sub-Sections::.).

   For ELF targets, the `.section' directive is used like this:
     .section NAME[, "FLAGS"[, @TYPE]]
   The optional FLAGS argument is a quoted string which may contain any
combintion of the following characters:
`a'
     section is allocatable

`w'
     section is writable

`x'
     section is executable

   The optional TYPE argument may contain one of the following
constants:
`@progbits'
     section contains data

`@nobits'
     section does not contain data (i.e., section only occupies space)

   If no flags are specified, the default flags depend upon the section
name.  If the section name is not recognized, the default will be for
the section to have none of the above flags: it will not be allocated
in memory, nor writable, nor executable.  The section will contain data.

   For ELF targets, the assembler supports another type of `.section'
directive for compatibility with the Solaris assembler:
     .section "NAME"[, FLAGS...]
   Note that the section name is quoted.  There may be a sequence of
comma separated flags:
`#alloc'
     section is allocatable

`#write'
     section is writable

`#execinstr'
     section is executable


File: as.info,  Node: Set,  Next: Short,  Prev: Section,  Up: Pseudo Ops

`.set SYMBOL, EXPRESSION'
=========================

   Set the value of SYMBOL to EXPRESSION.  This changes SYMBOL's value
and type to conform to EXPRESSION.  If SYMBOL was flagged as external,
it remains flagged (*note Symbol Attributes::.).

   You may `.set' a symbol many times in the same assembly.

   If you `.set' a global symbol, the value stored in the object file
is the last value stored into it.

   The syntax for `set' on the HPPA is `SYMBOL .set EXPRESSION'.


File: as.info,  Node: Short,  Next: Single,  Prev: Set,  Up: Pseudo Ops

`.short EXPRESSIONS'
====================

   `.short' is normally the same as `.word'.  *Note `.word': Word.

   In some configurations, however, `.short' and `.word' generate
numbers of different lengths; *note Machine Dependencies::..


File: as.info,  Node: Single,  Next: Size,  Prev: Short,  Up: Pseudo Ops

`.single FLONUMS'
=================

   This directive assembles zero or more flonums, separated by commas.
It has the same effect as `.float'.  The exact kind of floating point
numbers emitted depends on how `as' is configured.  *Note Machine
Dependencies::.


File: as.info,  Node: Size,  Next: Skip,  Prev: Single,  Up: Pseudo Ops

`.size'
=======

   This directive is generated by compilers to include auxiliary
debugging information in the symbol table.  It is only permitted inside
`.def'/`.endef' pairs.

   `.size' is only meaningful when generating COFF format output; when
`as' is generating `b.out', it accepts this directive but ignores it.


File: as.info,  Node: Skip,  Next: Space,  Prev: Size,  Up: Pseudo Ops

`.skip SIZE , FILL'
===================

   This directive emits SIZE bytes, each of value FILL.  Both SIZE and
FILL are absolute expressions.  If the comma and FILL are omitted, FILL
is assumed to be zero.  This is the same as `.space'.


File: as.info,  Node: Space,  Next: Stab,  Prev: Skip,  Up: Pseudo Ops

`.space SIZE , FILL'
====================

   This directive emits SIZE bytes, each of value FILL.  Both SIZE and
FILL are absolute expressions.  If the comma and FILL are omitted, FILL
is assumed to be zero.  This is the same as `.skip'.

     *Warning:* `.space' has a completely different meaning for HPPA
     targets; use `.block' as a substitute.  See `HP9000 Series 800
     Assembly Language Reference Manual' (HP 92432-90001) for the
     meaning of the `.space' directive.  *Note HPPA Assembler
     Directives: HPPA Directives, for a summary.

   On the AMD 29K, this directive is ignored; it is accepted for
compatibility with other AMD 29K assemblers.

     *Warning:* In most versions of the GNU assembler, the directive
     `.space' has the effect of `.block'  *Note Machine Dependencies::.


File: as.info,  Node: Stab,  Next: String,  Prev: Space,  Up: Pseudo Ops

`.stabd, .stabn, .stabs'
========================

   There are three directives that begin `.stab'.  All emit symbols
(*note Symbols::.), for use by symbolic debuggers.  The symbols are not
entered in the `as' hash table: they cannot be referenced elsewhere in
the source file.  Up to five fields are required:

STRING
     This is the symbol's name.  It may contain any character except
     `\000', so is more general than ordinary symbol names.  Some
     debuggers used to code arbitrarily complex structures into symbol
     names using this field.

TYPE
     An absolute expression.  The symbol's type is set to the low 8
     bits of this expression.  Any bit pattern is permitted, but `ld'
     and debuggers choke on silly bit patterns.

OTHER
     An absolute expression.  The symbol's "other" attribute is set to
     the low 8 bits of this expression.

DESC
     An absolute expression.  The symbol's descriptor is set to the low
     16 bits of this expression.

VALUE
     An absolute expression which becomes the symbol's value.

   If a warning is detected while reading a `.stabd', `.stabn', or
`.stabs' statement, the symbol has probably already been created; you
get a half-formed symbol in your object file.  This is compatible with
earlier assemblers!

`.stabd TYPE , OTHER , DESC'
     The "name" of the symbol generated is not even an empty string.
     It is a null pointer, for compatibility.  Older assemblers used a
     null pointer so they didn't waste space in object files with empty
     strings.

     The symbol's value is set to the location counter, relocatably.
     When your program is linked, the value of this symbol is the
     address of the location counter when the `.stabd' was assembled.

`.stabn TYPE , OTHER , DESC , VALUE'
     The name of the symbol is set to the empty string `""'.

`.stabs STRING ,  TYPE , OTHER , DESC , VALUE'
     All five fields are specified.


File: as.info,  Node: String,  Next: Symver,  Prev: Stab,  Up: Pseudo Ops

`.string' "STR"
===============

   Copy the characters in STR to the object file.  You may specify more
than one string to copy, separated by commas.  Unless otherwise
specified for a particular machine, the assembler marks the end of each
string with a 0 byte.  You can use any of the escape sequences
described in *Note Strings: Strings.


File: as.info,  Node: Symver,  Next: Tag,  Prev: String,  Up: Pseudo Ops

`.symver'
=========

   Use the `.symver' directive to bind symbols to specific version nodes
within a source file.  This is only supported on ELF platforms, and is
typically used when assembling files to be linked into a shared library.
There are cases where it may make sense to use this in objects to be
bound into an application itself so as to override a versioned symbol
from a shared library.

   For ELF targets, the `.symver' directive is used like this:
     .symver NAME, NAME2@NODENAME
   In this case, the symbol NAME must exist and be defined within the
file being assembled.  The `.versym' directive effectively creates a
symbol alias with the name NAME2@NODENAME, and in fact the main reason
that we just don't try and create a regular alias is that the @
character isn't permitted in symbol names.  The NAME2 part of the name
is the actual name of the symbol by which it will be externally
referenced.  The name NAME itself is merely a name of convenience that
is used so that it is possible to have definitions for multiple
versions of a function within a single source file, and so that the
compiler can unambiguously know which version of a function is being
mentioned.  The NODENAME portion of the alias should be the name of a
node specified in the version script supplied to the linker when
building a shared library.  If you are attempting to override a
versioned symbol from a shared library, then NODENAME should correspond
to the nodename of the symbol you are trying to override.


File: as.info,  Node: Tag,  Next: Text,  Prev: Symver,  Up: Pseudo Ops

`.tag STRUCTNAME'
=================

   This directive is generated by compilers to include auxiliary
debugging information in the symbol table.  It is only permitted inside
`.def'/`.endef' pairs.  Tags are used to link structure definitions in
the symbol table with instances of those structures.

   `.tag' is only used when generating COFF format output; when `as' is
generating `b.out', it accepts this directive but ignores it.


File: as.info,  Node: Text,  Next: Title,  Prev: Tag,  Up: Pseudo Ops

`.text SUBSECTION'
==================

   Tells `as' to assemble the following statements onto the end of the
text subsection numbered SUBSECTION, which is an absolute expression.
If SUBSECTION is omitted, subsection number zero is used.


File: as.info,  Node: Title,  Next: Type,  Prev: Text,  Up: Pseudo Ops

`.title "HEADING"'
==================

   Use HEADING as the title (second line, immediately after the source
file name and pagenumber) when generating assembly listings.

   This directive affects subsequent pages, as well as the current page
if it appears within ten lines of the top of a page.


File: as.info,  Node: Type,  Next: Val,  Prev: Title,  Up: Pseudo Ops

`.type INT'
===========

   This directive, permitted only within `.def'/`.endef' pairs, records
the integer INT as the type attribute of a symbol table entry.

   `.type' is associated only with COFF format output; when `as' is
configured for `b.out' output, it accepts this directive but ignores it.


File: as.info,  Node: Val,  Next: Word,  Prev: Type,  Up: Pseudo Ops

`.val ADDR'
===========

   This directive, permitted only within `.def'/`.endef' pairs, records
the address ADDR as the value attribute of a symbol table entry.

   `.val' is used only for COFF output; when `as' is configured for
`b.out', it accepts this directive but ignores it.


File: as.info,  Node: Word,  Next: Deprecated,  Prev: Val,  Up: Pseudo Ops

`.word EXPRESSIONS'
===================

   This directive expects zero or more EXPRESSIONS, of any section,
separated by commas.

   The size of the number emitted, and its byte order, depend on what
target computer the assembly is for.

     *Warning: Special Treatment to support Compilers*

   Machines with a 32-bit address space, but that do less than 32-bit
addressing, require the following special treatment.  If the machine of
interest to you does 32-bit addressing (or doesn't require it; *note
Machine Dependencies::.), you can ignore this issue.

   In order to assemble compiler output into something that works, `as'
occasionlly does strange things to `.word' directives.  Directives of
the form `.word sym1-sym2' are often emitted by compilers as part of
jump tables.  Therefore, when `as' assembles a directive of the form
`.word sym1-sym2', and the difference between `sym1' and `sym2' does
not fit in 16 bits, `as' creates a "secondary jump table", immediately
before the next label.  This secondary jump table is preceded by a
short-jump to the first byte after the secondary table.  This
short-jump prevents the flow of control from accidentally falling into
the new table.  Inside the table is a long-jump to `sym2'.  The
original `.word' contains `sym1' minus the address of the long-jump to
`sym2'.

   If there were several occurrences of `.word sym1-sym2' before the
secondary jump table, all of them are adjusted.  If there was a `.word
sym3-sym4', that also did not fit in sixteen bits, a long-jump to
`sym4' is included in the secondary jump table, and the `.word'
directives are adjusted to contain `sym3' minus the address of the
long-jump to `sym4'; and so on, for as many entries in the original
jump table as necessary.


File: as.info,  Node: Deprecated,  Prev: Word,  Up: Pseudo Ops

Deprecated Directives
=====================

   One day these directives won't work.  They are included for
compatibility with older assemblers.
.abort
.app-file
.line

File: as.info,  Node: Machine Dependencies,  Next: Reporting Bugs,  Prev: Pseudo Ops,  Up: Top

Machine Dependent Features
**************************

   The machine instruction sets are (almost by definition) different on
each machine where `as' runs.  Floating point representations vary as
well, and `as' often supports a few additional directives or
command-line options for compatibility with other assemblers on a
particular platform.  Finally, some versions of `as' support special
pseudo-instructions for branch optimization.

   This chapter discusses most of these differences, though it does not
include details on any machine's instruction set.  For details on that
subject, see the hardware manufacturer's manual.

* Menu:


* AMD29K-Dependent::            AMD 29K Dependent Features

* D10V-Dependent::              D10V Dependent Features

* H8/300-Dependent::            Hitachi H8/300 Dependent Features

* H8/500-Dependent::            Hitachi H8/500 Dependent Features

* HPPA-Dependent::              HPPA Dependent Features

* i386-Dependent::              Intel 80386 Dependent Features

* i960-Dependent::              Intel 80960 Dependent Features

* M68K-Dependent::              M680x0 Dependent Features

* MIPS-Dependent::              MIPS Dependent Features

* SH-Dependent::                Hitachi SH Dependent Features

* Sparc-Dependent::             SPARC Dependent Features

* Z8000-Dependent::             Z8000 Dependent Features

* Vax-Dependent::               VAX Dependent Features


File: as.info,  Node: AMD29K-Dependent,  Next: D10V-Dependent,  Up: Machine Dependencies

AMD 29K Dependent Features
==========================

* Menu:

* AMD29K Options::              Options
* AMD29K Syntax::               Syntax
* AMD29K Floating Point::       Floating Point
* AMD29K Directives::           AMD 29K Machine Directives
* AMD29K Opcodes::              Opcodes


File: as.info,  Node: AMD29K Options,  Next: AMD29K Syntax,  Up: AMD29K-Dependent

Options
-------

   `as' has no additional command-line options for the AMD 29K family.


File: as.info,  Node: AMD29K Syntax,  Next: AMD29K Floating Point,  Prev: AMD29K Options,  Up: AMD29K-Dependent

Syntax
------

* Menu:

* AMD29K-Macros::		Macros
* AMD29K-Chars::                Special Characters
* AMD29K-Regs::                 Register Names


File: as.info,  Node: AMD29K-Macros,  Next: AMD29K-Chars,  Up: AMD29K Syntax

Macros
......

   The macro syntax used on the AMD 29K is like that described in the
AMD 29K Family Macro Assembler Specification.  Normal `as' macros
should still work.


File: as.info,  Node: AMD29K-Chars,  Next: AMD29K-Regs,  Prev: AMD29K-Macros,  Up: AMD29K Syntax

Special Characters
..................

   `;' is the line comment character.

   The character `?' is permitted in identifiers (but may not begin an
identifier).


File: as.info,  Node: AMD29K-Regs,  Prev: AMD29K-Chars,  Up: AMD29K Syntax

Register Names
..............

   General-purpose registers are represented by predefined symbols of
the form `GRNNN' (for global registers) or `LRNNN' (for local
registers), where NNN represents a number between `0' and `127',
written with no leading zeros.  The leading letters may be in either
upper or lower case; for example, `gr13' and `LR7' are both valid
register names.

   You may also refer to general-purpose registers by specifying the
register number as the result of an expression (prefixed with `%%' to
flag the expression as a register number):
     %%EXPRESSION

--where EXPRESSION must be an absolute expression evaluating to a
number between `0' and `255'.  The range [0, 127] refers to global
registers, and the range [128, 255] to local registers.

   In addition, `as' understands the following protected
special-purpose register names for the AMD 29K family:

       vab    chd    pc0
       ops    chc    pc1
       cps    rbp    pc2
       cfg    tmc    mmu
       cha    tmr    lru

   These unprotected special-purpose register names are also recognized:
       ipc    alu    fpe
       ipa    bp     inte
       ipb    fc     fps
       q      cr     exop


File: as.info,  Node: AMD29K Floating Point,  Next: AMD29K Directives,  Prev: AMD29K Syntax,  Up: AMD29K-Dependent

Floating Point
--------------

   The AMD 29K family uses IEEE floating-point numbers.


File: as.info,  Node: AMD29K Directives,  Next: AMD29K Opcodes,  Prev: AMD29K Floating Point,  Up: AMD29K-Dependent

AMD 29K Machine Directives
--------------------------

`.block SIZE , FILL'
     This directive emits SIZE bytes, each of value FILL.  Both SIZE
     and FILL are absolute expressions.  If the comma and FILL are
     omitted, FILL is assumed to be zero.

     In other versions of the GNU assembler, this directive is called
     `.space'.

`.cputype'
     This directive is ignored; it is accepted for compatibility with
     other AMD 29K assemblers.

`.file'
     This directive is ignored; it is accepted for compatibility with
     other AMD 29K assemblers.

          *Warning:* in other versions of the GNU assembler, `.file' is
          used for the directive called `.app-file' in the AMD 29K
          support.

`.line'
     This directive is ignored; it is accepted for compatibility with
     other AMD 29K assemblers.

`.sect'
     This directive is ignored; it is accepted for compatibility with
     other AMD 29K assemblers.

`.use SECTION NAME'
     Establishes the section and subsection for the following code;
     SECTION NAME may be one of `.text', `.data', `.data1', or `.lit'.
     With one of the first three SECTION NAME options, `.use' is
     equivalent to the machine directive SECTION NAME; the remaining
     case, `.use .lit', is the same as `.data 200'.


File: as.info,  Node: AMD29K Opcodes,  Prev: AMD29K Directives,  Up: AMD29K-Dependent

Opcodes
-------

   `as' implements all the standard AMD 29K opcodes.  No additional
pseudo-instructions are needed on this family.

   For information on the 29K machine instruction set, see `Am29000
User's Manual', Advanced Micro Devices, Inc.


File: as.info,  Node: D10V-Dependent,  Next: H8/300-Dependent,  Prev: AMD29K-Dependent,  Up: Machine Dependencies

D10V Dependent Features
=======================

* Menu:

* D10V-Opts::                   D10V Options
* D10V-Syntax::                 Syntax
* D10V-Float::                  Floating Point
* D10V-Opcodes::                Opcodes


File: as.info,  Node: D10V-Opts,  Next: D10V-Syntax,  Up: D10V-Dependent

D10V Options
------------

   The Mitsubishi D10V version of `as' has a few machine dependent
options.

`-O'
     The D10V can often execute two sub-instructions in parallel. When
     this option is used, `as' will attempt to optimize its output by
     detecting when instructions can be executed in parallel.


File: as.info,  Node: D10V-Syntax,  Next: D10V-Float,  Prev: D10V-Opts,  Up: D10V-Dependent

Syntax
------

   The D10V syntax is based on the syntax in Mitsubishi's D10V
architecture manual.  The differences are detailed below.

* Menu:

* D10V-Size::                 Size Modifiers
* D10V-Subs::                 Sub-Instructions
* D10V-Chars::                Special Characters
* D10V-Regs::                 Register Names
* D10V-Addressing::           Addressing Modes
* D10V-Word::                 @WORD Modifier


File: as.info,  Node: D10V-Size,  Next: D10V-Subs,  Up: D10V-Syntax

Size Modifiers
..............

   The D10V version of `as' uses the instruction names in the D10V
Architecture Manual.  However, the names in the manual are sometimes
ambiguous.  There are instruction names that can assemble to a short or
long form opcode.  How does the assembler pick the correct form?  `as'
will always pick the smallest form if it can.  When dealing with a
symbol that is not defined yet when a line is being assembled, it will
always use the long form.  If you need to force the assembler to use
either the short or long form of the instruction, you can append either
`.s' (short) or `.l' (long) to it.  For example, if you are writing an
assembly program and you want to do a branch to a symbol that is
defined later in your program, you can write `bra.s   foo'.  Objdump
and GDB will always append `.s' or `.l' to instructions which have both
short and long forms.


File: as.info,  Node: D10V-Subs,  Next: D10V-Chars,  Prev: D10V-Size,  Up: D10V-Syntax

Sub-Instructions
................

   The D10V assembler takes as input a series of instructions, either
one-per-line, or in the special two-per-line format described in the
next section.  Some of these instructions will be short-form or
sub-instructions.  These sub-instructions can be packed into a single
instruction.  The assembler will do this automatically.  It will also
detect when it should not pack instructions.  For example, when a label
is defined, the next instruction will never be packaged with the
previous one.  Whenever a branch and link instruction is called, it
will not be packaged with the next instruction so the return address
will be valid.  Nops are automatically inserted when necessary.

   If you do not want the assembler automatically making these
decisions, you can control the packaging and execution type (parallel
or sequential) with the special execution symbols described in the next
section.


File: as.info,  Node: D10V-Chars,  Next: D10V-Regs,  Prev: D10V-Subs,  Up: D10V-Syntax

Special Characters
..................

   `;' and `#' are the line comment characters.  Sub-instructions may
be executed in order, in reverse-order, or in parallel.  Instructions
listed in the standard one-per-line format will be executed
sequentially.  To specify the executing order, use the following
symbols:
`->'
     Sequential with instruction on the left first.

`<-'
     Sequential with instruction on the right first.

`||'
     Parallel The D10V syntax allows either one instruction per line,
one instruction per line with the execution symbol, or two instructions
per line.  For example
`abs       a1      ->      abs     r0'
     Execute these sequentially.  The instruction on the right is in
     the right container and is executed second.

`abs       r0      <-      abs     a1'
     Execute these reverse-sequentially.  The instruction on the right
     is in the right container, and is executed first.

`ld2w    r2,@r8+         ||      mac     a0,r0,r7'
     Execute these in parallel.

`ld2w    r2,@r8+         ||'
`mac     a0,r0,r7'
     Two-line format. Execute these in parallel.

`ld2w    r2,@r8+'
`mac     a0,r0,r7'
     Two-line format. Execute these sequentially.  Assembler will put
     them in the proper containers.

`ld2w    r2,@r8+         ->'
`mac     a0,r0,r7'
     Two-line format. Execute these sequentially.  Same as above but
     second instruction will always go into right container.  Since `$'
has no special meaning, you may use it in symbol names.


File: as.info,  Node: D10V-Regs,  Next: D10V-Addressing,  Prev: D10V-Chars,  Up: D10V-Syntax

Register Names
..............

   You can use the predefined symbols `r0' through `r15' to refer to
the D10V registers.  You can also use `sp' as an alias for `r15'.  The
accumulators are `a0' and `a1'.  There are special register-pair names
that may optionally be used in opcodes that require even-numbered
registers. Register names are not case sensitive.

   Register Pairs
`r0-r1'
`r2-r3'
`r4-r5'
`r6-r7'
`r8-r9'
`r10-r11'
`r12-r13'
`r14-r15'
   The D10V also has predefined symbols for these control registers and
status bits:
`psw'
     Processor Status Word

`bpsw'
     Backup Processor Status Word

`pc'
     Program Counter

`bpc'
     Backup Program Counter

`rpt_c'
     Repeat Count

`rpt_s'
     Repeat Start address

`rpt_e'
     Repeat End address

`mod_s'
     Modulo Start address

`mod_e'
     Modulo End address

`iba'
     Instruction Break Address

`f0'
     Flag 0

`f1'
     Flag 1

`c'
     Carry flag


File: as.info,  Node: D10V-Addressing,  Next: D10V-Word,  Prev: D10V-Regs,  Up: D10V-Syntax

Addressing Modes
................

   `as' understands the following addressing modes for the D10V.  `RN'
in the following refers to any of the numbered registers, but *not* the
control registers.
`RN'
     Register direct

`@RN'
     Register indirect

`@RN+'
     Register indirect with post-increment

`@RN-'
     Register indirect with post-decrement

`@-SP'
     Register indirect with pre-decrement

`@(DISP, RN)'
     Register indirect with displacement

`ADDR'
     PC relative address (for branch or rep).

`#IMM'
     Immediate data (the `#' is optional and ignored)


File: as.info,  Node: D10V-Word,  Prev: D10V-Addressing,  Up: D10V-Syntax

@WORD Modifier
..............

   Any symbol followed by `@word' will be replaced by the symbol's value
shifted right by 2.  This is used in situations such as loading a
register with the address of a function (or any other code fragment).
For example, if you want to load a register with the location of the
function `main' then jump to that function, you could do it as follws:
     ldi     r2, main@word
     jmp     r2


File: as.info,  Node: D10V-Float,  Next: D10V-Opcodes,  Prev: D10V-Syntax,  Up: D10V-Dependent

Floating Point
--------------

   The D10V has no hardware floating point, but the `.float' and
`.double' directives generates IEEE floating-point numbers for
compatibility with other development tools.


File: as.info,  Node: D10V-Opcodes,  Prev: D10V-Float,  Up: D10V-Dependent

Opcodes
-------

   For detailed information on the D10V machine instruction set, see
`D10V Architecture: A VLIW Microprocessor for Multimedia Applications'
(Mitsubishi Electric Corp.).  `as' implements all the standard D10V
opcodes.  The only changes are those described in the section on size
modifiers


File: as.info,  Node: H8/300-Dependent,  Next: H8/500-Dependent,  Prev: D10V-Dependent,  Up: Machine Dependencies

H8/300 Dependent Features
=========================

* Menu:

* H8/300 Options::              Options
* H8/300 Syntax::               Syntax
* H8/300 Floating Point::       Floating Point
* H8/300 Directives::           H8/300 Machine Directives
* H8/300 Opcodes::              Opcodes


File: as.info,  Node: H8/300 Options,  Next: H8/300 Syntax,  Up: H8/300-Dependent

Options
-------

   `as' has no additional command-line options for the Hitachi H8/300
family.


File: as.info,  Node: H8/300 Syntax,  Next: H8/300 Floating Point,  Prev: H8/300 Options,  Up: H8/300-Dependent

Syntax
------

* Menu:

* H8/300-Chars::                Special Characters
* H8/300-Regs::                 Register Names
* H8/300-Addressing::           Addressing Modes


File: as.info,  Node: H8/300-Chars,  Next: H8/300-Regs,  Up: H8/300 Syntax

Special Characters
..................

   `;' is the line comment character.

   `$' can be used instead of a newline to separate statements.
Therefore *you may not use `$' in symbol names* on the H8/300.


File: as.info,  Node: H8/300-Regs,  Next: H8/300-Addressing,  Prev: H8/300-Chars,  Up: H8/300 Syntax

Register Names
..............

   You can use predefined symbols of the form `rNh' and `rNl' to refer
to the H8/300 registers as sixteen 8-bit general-purpose registers.  N
is a digit from `0' to `7'); for instance, both `r0h' and `r7l' are
valid register names.

   You can also use the eight predefined symbols `rN' to refer to the
H8/300 registers as 16-bit registers (you must use this form for
addressing).

   On the H8/300H, you can also use the eight predefined symbols `erN'
(`er0' ... `er7') to refer to the 32-bit general purpose registers.

   The two control registers are called `pc' (program counter; a 16-bit
register, except on the H8/300H where it is 24 bits) and `ccr'
(condition code register; an 8-bit register).  `r7' is used as the
stack pointer, and can also be called `sp'.


File: as.info,  Node: H8/300-Addressing,  Prev: H8/300-Regs,  Up: H8/300 Syntax

Addressing Modes
................

   as understands the following addressing modes for the H8/300:
`rN'
     Register direct

`@rN'
     Register indirect

`@(D, rN)'
`@(D:16, rN)'
`@(D:24, rN)'
     Register indirect: 16-bit or 24-bit displacement D from register
     N.  (24-bit displacements are only meaningful on the H8/300H.)

`@rN+'
     Register indirect with post-increment

`@-rN'
     Register indirect with pre-decrement

``@'AA'
``@'AA:8'
``@'AA:16'
``@'AA:24'
     Absolute address `aa'.  (The address size `:24' only makes sense
     on the H8/300H.)

`#XX'
`#XX:8'
`#XX:16'
`#XX:32'
     Immediate data XX.  You may specify the `:8', `:16', or `:32' for
     clarity, if you wish; but `as' neither requires this nor uses
     it--the data size required is taken from context.

``@'`@'AA'
``@'`@'AA:8'
     Memory indirect.  You may specify the `:8' for clarity, if you
     wish; but `as' neither requires this nor uses it.


File: as.info,  Node: H8/300 Floating Point,  Next: H8/300 Directives,  Prev: H8/300 Syntax,  Up: H8/300-Dependent

Floating Point
--------------

   The H8/300 family has no hardware floating point, but the `.float'
directive generates IEEE floating-point numbers for compatibility with
other development tools.


File: as.info,  Node: H8/300 Directives,  Next: H8/300 Opcodes,  Prev: H8/300 Floating Point,  Up: H8/300-Dependent

H8/300 Machine Directives
-------------------------

   `as' has only one machine-dependent directive for the H8/300:

`.h8300h'
     Recognize and emit additional instructions for the H8/300H
     variant, and also make `.int' emit 32-bit numbers rather than the
     usual (16-bit) for the H8/300 family.

   On the H8/300 family (including the H8/300H) `.word' directives
generate 16-bit numbers.


File: as.info,  Node: H8/300 Opcodes,  Prev: H8/300 Directives,  Up: H8/300-Dependent

Opcodes
-------

   For detailed information on the H8/300 machine instruction set, see
`H8/300 Series Programming Manual' (Hitachi ADE-602-025).  For
information specific to the H8/300H, see `H8/300H Series Programming
Manual' (Hitachi).

   `as' implements all the standard H8/300 opcodes.  No additional
pseudo-instructions are needed on this family.

   The following table summarizes the H8/300 opcodes, and their
arguments.  Entries marked `*' are opcodes used only on the H8/300H.

              Legend:
                 Rs   source register
                 Rd   destination register
                 abs  absolute address
                 imm  immediate data
              disp:N  N-bit displacement from a register
             pcrel:N  N-bit displacement relative to program counter
     
        add.b #imm,rd              *  andc #imm,ccr
        add.b rs,rd                   band #imm,rd
        add.w rs,rd                   band #imm,@rd
     *  add.w #imm,rd                 band #imm,@abs:8
     *  add.l rs,rd                   bra  pcrel:8
     *  add.l #imm,rd              *  bra  pcrel:16
        adds #imm,rd                  bt   pcrel:8
        addx #imm,rd               *  bt   pcrel:16
        addx rs,rd                    brn  pcrel:8
        and.b #imm,rd              *  brn  pcrel:16
        and.b rs,rd                   bf   pcrel:8
     *  and.w rs,rd                *  bf   pcrel:16
     *  and.w #imm,rd                 bhi  pcrel:8
     *  and.l #imm,rd              *  bhi  pcrel:16
     *  and.l rs,rd                   bls  pcrel:8
     
     *  bls  pcrel:16                 bld  #imm,rd
        bcc  pcrel:8                  bld  #imm,@rd
     *  bcc  pcrel:16                 bld  #imm,@abs:8
        bhs  pcrel:8                  bnot #imm,rd
     *  bhs  pcrel:16                 bnot #imm,@rd
        bcs  pcrel:8                  bnot #imm,@abs:8
     *  bcs  pcrel:16                 bnot rs,rd
        blo  pcrel:8                  bnot rs,@rd
     *  blo  pcrel:16                 bnot rs,@abs:8
        bne  pcrel:8                  bor  #imm,rd
     *  bne  pcrel:16                 bor  #imm,@rd
        beq  pcrel:8                  bor  #imm,@abs:8
     *  beq  pcrel:16                 bset #imm,rd
        bvc  pcrel:8                  bset #imm,@rd
     *  bvc  pcrel:16                 bset #imm,@abs:8
        bvs  pcrel:8                  bset rs,rd
     *  bvs  pcrel:16                 bset rs,@rd
        bpl  pcrel:8                  bset rs,@abs:8
     *  bpl  pcrel:16                 bsr  pcrel:8
        bmi  pcrel:8                  bsr  pcrel:16
     *  bmi  pcrel:16                 bst  #imm,rd
        bge  pcrel:8                  bst  #imm,@rd
     *  bge  pcrel:16                 bst  #imm,@abs:8
        blt  pcrel:8                  btst #imm,rd
     *  blt  pcrel:16                 btst #imm,@rd
        bgt  pcrel:8                  btst #imm,@abs:8
     *  bgt  pcrel:16                 btst rs,rd
        ble  pcrel:8                  btst rs,@rd
     *  ble  pcrel:16                 btst rs,@abs:8
        bclr #imm,rd                  bxor #imm,rd
        bclr #imm,@rd                 bxor #imm,@rd
        bclr #imm,@abs:8              bxor #imm,@abs:8
        bclr rs,rd                    cmp.b #imm,rd
        bclr rs,@rd                   cmp.b rs,rd
        bclr rs,@abs:8                cmp.w rs,rd
        biand #imm,rd                 cmp.w rs,rd
        biand #imm,@rd             *  cmp.w #imm,rd
        biand #imm,@abs:8          *  cmp.l #imm,rd
        bild #imm,rd               *  cmp.l rs,rd
        bild #imm,@rd                 daa  rs
        bild #imm,@abs:8              das  rs
        bior #imm,rd                  dec.b rs
        bior #imm,@rd              *  dec.w #imm,rd
        bior #imm,@abs:8           *  dec.l #imm,rd
        bist #imm,rd                  divxu.b rs,rd
        bist #imm,@rd              *  divxu.w rs,rd
        bist #imm,@abs:8           *  divxs.b rs,rd
        bixor #imm,rd              *  divxs.w rs,rd
        bixor #imm,@rd                eepmov
        bixor #imm,@abs:8          *  eepmovw
     
     *  exts.w rd                     mov.w rs,@abs:16
     *  exts.l rd                  *  mov.l #imm,rd
     *  extu.w rd                  *  mov.l rs,rd
     *  extu.l rd                  *  mov.l @rs,rd
        inc  rs                    *  mov.l @(disp:16,rs),rd
     *  inc.w #imm,rd              *  mov.l @(disp:24,rs),rd
     *  inc.l #imm,rd              *  mov.l @rs+,rd
        jmp  @rs                   *  mov.l @abs:16,rd
        jmp  abs                   *  mov.l @abs:24,rd
        jmp  @@abs:8               *  mov.l rs,@rd
        jsr  @rs                   *  mov.l rs,@(disp:16,rd)
        jsr  abs                   *  mov.l rs,@(disp:24,rd)
        jsr  @@abs:8               *  mov.l rs,@-rd
        ldc  #imm,ccr              *  mov.l rs,@abs:16
        ldc  rs,ccr                *  mov.l rs,@abs:24
     *  ldc  @abs:16,ccr              movfpe @abs:16,rd
     *  ldc  @abs:24,ccr              movtpe rs,@abs:16
     *  ldc  @(disp:16,rs),ccr        mulxu.b rs,rd
     *  ldc  @(disp:24,rs),ccr     *  mulxu.w rs,rd
     *  ldc  @rs+,ccr              *  mulxs.b rs,rd
     *  ldc  @rs,ccr               *  mulxs.w rs,rd
     *  mov.b @(disp:24,rs),rd        neg.b rs
     *  mov.b rs,@(disp:24,rd)     *  neg.w rs
        mov.b @abs:16,rd           *  neg.l rs
        mov.b rs,rd                   nop
        mov.b @abs:8,rd               not.b rs
        mov.b rs,@abs:8            *  not.w rs
        mov.b rs,rd                *  not.l rs
        mov.b #imm,rd                 or.b #imm,rd
        mov.b @rs,rd                  or.b rs,rd
        mov.b @(disp:16,rs),rd     *  or.w #imm,rd
        mov.b @rs+,rd              *  or.w rs,rd
        mov.b @abs:8,rd            *  or.l #imm,rd
        mov.b rs,@rd               *  or.l rs,rd
        mov.b rs,@(disp:16,rd)        orc  #imm,ccr
        mov.b rs,@-rd                 pop.w rs
        mov.b rs,@abs:8            *  pop.l rs
        mov.w rs,@rd                  push.w rs
     *  mov.w @(disp:24,rs),rd     *  push.l rs
     *  mov.w rs,@(disp:24,rd)        rotl.b rs
     *  mov.w @abs:24,rd           *  rotl.w rs
     *  mov.w rs,@abs:24           *  rotl.l rs
        mov.w rs,rd                   rotr.b rs
        mov.w #imm,rd              *  rotr.w rs
        mov.w @rs,rd               *  rotr.l rs
        mov.w @(disp:16,rs),rd        rotxl.b rs
        mov.w @rs+,rd              *  rotxl.w rs
        mov.w @abs:16,rd           *  rotxl.l rs
        mov.w rs,@(disp:16,rd)        rotxr.b rs
        mov.w rs,@-rd              *  rotxr.w rs
     
     *  rotxr.l rs                 *  stc  ccr,@(disp:24,rd)
        bpt                        *  stc  ccr,@-rd
        rte                        *  stc  ccr,@abs:16
        rts                        *  stc  ccr,@abs:24
        shal.b rs                     sub.b rs,rd
     *  shal.w rs                     sub.w rs,rd
     *  shal.l rs                  *  sub.w #imm,rd
        shar.b rs                  *  sub.l rs,rd
     *  shar.w rs                  *  sub.l #imm,rd
     *  shar.l rs                     subs #imm,rd
        shll.b rs                     subx #imm,rd
     *  shll.w rs                     subx rs,rd
     *  shll.l rs                  *  trapa #imm
        shlr.b rs                     xor  #imm,rd
     *  shlr.w rs                     xor  rs,rd
     *  shlr.l rs                  *  xor.w #imm,rd
        sleep                      *  xor.w rs,rd
        stc  ccr,rd                *  xor.l #imm,rd
     *  stc  ccr,@rs               *  xor.l rs,rd
     *  stc  ccr,@(disp:16,rd)        xorc #imm,ccr

   Four H8/300 instructions (`add', `cmp', `mov', `sub') are defined
with variants using the suffixes `.b', `.w', and `.l' to specify the
size of a memory operand.  `as' supports these suffixes, but does not
require them; since one of the operands is always a register, `as' can
deduce the correct size.

   For example, since `r0' refers to a 16-bit register,
     mov    r0,@foo
is equivalent to
     mov.w  r0,@foo

   If you use the size suffixes, `as' issues a warning when the suffix
and the register size do not match.


File: as.info,  Node: H8/500-Dependent,  Next: HPPA-Dependent,  Prev: H8/300-Dependent,  Up: Machine Dependencies

H8/500 Dependent Features
=========================

* Menu:

* H8/500 Options::              Options
* H8/500 Syntax::               Syntax
* H8/500 Floating Point::       Floating Point
* H8/500 Directives::           H8/500 Machine Directives
* H8/500 Opcodes::              Opcodes


File: as.info,  Node: H8/500 Options,  Next: H8/500 Syntax,  Up: H8/500-Dependent

Options
-------

   `as' has no additional command-line options for the Hitachi H8/500
family.


File: as.info,  Node: H8/500 Syntax,  Next: H8/500 Floating Point,  Prev: H8/500 Options,  Up: H8/500-Dependent

Syntax
------

* Menu:

* H8/500-Chars::                Special Characters
* H8/500-Regs::                 Register Names
* H8/500-Addressing::           Addressing Modes


File: as.info,  Node: H8/500-Chars,  Next: H8/500-Regs,  Up: H8/500 Syntax

Special Characters
..................

   `!' is the line comment character.

   `;' can be used instead of a newline to separate statements.

   Since `$' has no special meaning, you may use it in symbol names.


File: as.info,  Node: H8/500-Regs,  Next: H8/500-Addressing,  Prev: H8/500-Chars,  Up: H8/500 Syntax

Register Names
..............

   You can use the predefined symbols `r0', `r1', `r2', `r3', `r4',
`r5', `r6', and `r7' to refer to the H8/500 registers.

   The H8/500 also has these control registers:

`cp'
     code pointer

`dp'
     data pointer

`bp'
     base pointer

`tp'
     stack top pointer

`ep'
     extra pointer

`sr'
     status register

`ccr'
     condition code register

   All registers are 16 bits long.  To represent 32 bit numbers, use two
adjacent registers; for distant memory addresses, use one of the segment
pointers (`cp' for the program counter; `dp' for `r0'-`r3'; `ep' for
`r4' and `r5'; and `tp' for `r6' and `r7'.


File: as.info,  Node: H8/500-Addressing,  Prev: H8/500-Regs,  Up: H8/500 Syntax

Addressing Modes
................

   as understands the following addressing modes for the H8/500:
`RN'
     Register direct

`@RN'
     Register indirect

`@(d:8, RN)'
     Register indirect with 8 bit signed displacement

`@(d:16, RN)'
     Register indirect with 16 bit signed displacement

`@-RN'
     Register indirect with pre-decrement

`@RN+'
     Register indirect with post-increment

`@AA:8'
     8 bit absolute address

`@AA:16'
     16 bit absolute address

`#XX:8'
     8 bit immediate

`#XX:16'
     16 bit immediate


File: as.info,  Node: H8/500 Floating Point,  Next: H8/500 Directives,  Prev: H8/500 Syntax,  Up: H8/500-Dependent

Floating Point
--------------

   The H8/500 family has no hardware floating point, but the `.float'
directive generates IEEE floating-point numbers for compatibility with
other development tools.


File: as.info,  Node: H8/500 Directives,  Next: H8/500 Opcodes,  Prev: H8/500 Floating Point,  Up: H8/500-Dependent

H8/500 Machine Directives
-------------------------

   `as' has no machine-dependent directives for the H8/500.  However,
on this platform the `.int' and `.word' directives generate 16-bit
numbers.

