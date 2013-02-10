This is Info file gcc.info, produced by Makeinfo version 1.68 from the
input file gcc.texi.

   This file documents the use and the internals of the GNU compiler.

   Published by the Free Software Foundation 59 Temple Place - Suite 330
Boston, MA 02111-1307 USA

   Copyright (C) 1988, 1989, 1992, 1993, 1994, 1995, 1996, 1997, 1998
Free Software Foundation, Inc.

   Permission is granted to make and distribute verbatim copies of this
manual provided the copyright notice and this permission notice are
preserved on all copies.

   Permission is granted to copy and distribute modified versions of
this manual under the conditions for verbatim copying, provided also
that the sections entitled "GNU General Public License," "Funding for
Free Software," and "Protect Your Freedom--Fight `Look And Feel'" are
included exactly as in the original, and provided that the entire
resulting derived work is distributed under the terms of a permission
notice identical to this one.

   Permission is granted to copy and distribute translations of this
manual into another language, under the above conditions for modified
versions, except that the sections entitled "GNU General Public
License," "Funding for Free Software," and "Protect Your Freedom--Fight
`Look And Feel'", and this permission notice, may be included in
translations approved by the Free Software Foundation instead of in the
original English.


File: gcc.info,  Node: Preprocessor Options,  Next: Assembler Options,  Prev: Optimize Options,  Up: Invoking GCC

Options Controlling the Preprocessor
====================================

   These options control the C preprocessor, which is run on each C
source file before actual compilation.

   If you use the `-E' option, nothing is done except preprocessing.
Some of these options make sense only together with `-E' because they
cause the preprocessor output to be unsuitable for actual compilation.

`-include FILE'
     Process FILE as input before processing the regular input file.
     In effect, the contents of FILE are compiled first.  Any `-D' and
     `-U' options on the command line are always processed before
     `-include FILE', regardless of the order in which they are
     written.  All the `-include' and `-imacros' options are processed
     in the order in which they are written.

`-imacros FILE'
     Process FILE as input, discarding the resulting output, before
     processing the regular input file.  Because the output generated
     from FILE is discarded, the only effect of `-imacros FILE' is to
     make the macros defined in FILE available for use in the main
     input.

     Any `-D' and `-U' options on the command line are always processed
     before `-imacros FILE', regardless of the order in which they are
     written.  All the `-include' and `-imacros' options are processed
     in the order in which they are written.

`-idirafter DIR'
     Add the directory DIR to the second include path.  The directories
     on the second include path are searched when a header file is not
     found in any of the directories in the main include path (the one
     that `-I' adds to).

`-iprefix PREFIX'
     Specify PREFIX as the prefix for subsequent `-iwithprefix' options.

`-iwithprefix DIR'
     Add a directory to the second include path.  The directory's name
     is made by concatenating PREFIX and DIR, where PREFIX was
     specified previously with `-iprefix'.  If you have not specified a
     prefix yet, the directory containing the installed passes of the
     compiler is used as the default.

`-iwithprefixbefore DIR'
     Add a directory to the main include path.  The directory's name is
     made by concatenating PREFIX and DIR, as in the case of
     `-iwithprefix'.

`-isystem DIR'
     Add a directory to the beginning of the second include path,
     marking it as a system directory, so that it gets the same special
     treatment as is applied to the standard system directories.

`-nostdinc'
     Do not search the standard system directories for header files.
     Only the directories you have specified with `-I' options (and the
     current directory, if appropriate) are searched.  *Note Directory
     Options::, for information on `-I'.

     By using both `-nostdinc' and `-I-', you can limit the include-file
     search path to only those directories you specify explicitly.

`-undef'
     Do not predefine any nonstandard macros.  (Including architecture
     flags).

`-E'
     Run only the C preprocessor.  Preprocess all the C source files
     specified and output the results to standard output or to the
     specified output file.

`-C'
     Tell the preprocessor not to discard comments.  Used with the `-E'
     option.

`-P'
     Tell the preprocessor not to generate `#line' directives.  Used
     with the `-E' option.

`-M'
     Tell the preprocessor to output a rule suitable for `make'
     describing the dependencies of each object file.  For each source
     file, the preprocessor outputs one `make'-rule whose target is the
     object file name for that source file and whose dependencies are
     all the `#include' header files it uses.  This rule may be a
     single line or may be continued with `\'-newline if it is long.
     The list of rules is printed on standard output instead of the
     preprocessed C program.

     `-M' implies `-E'.

     Another way to specify output of a `make' rule is by setting the
     environment variable `DEPENDENCIES_OUTPUT' (*note Environment
     Variables::.).

`-MM'
     Like `-M' but the output mentions only the user header files
     included with `#include "FILE"'.  System header files included
     with `#include <FILE>' are omitted.

`-MD'
     Like `-M' but the dependency information is written to a file made
     by replacing ".c" with ".d" at the end of the input file names.
     This is in addition to compiling the file as specified--`-MD' does
     not inhibit ordinary compilation the way `-M' does.

     In Mach, you can use the utility `md' to merge multiple dependency
     files into a single dependency file suitable for using with the
     `make' command.

`-MMD'
     Like `-MD' except mention only user header files, not system
     header files.

`-MG'
     Treat missing header files as generated files and assume they live
     in the same directory as the source file.  If you specify `-MG',
     you must also specify either `-M' or `-MM'.  `-MG' is not
     supported with `-MD' or `-MMD'.

`-H'
     Print the name of each header file used, in addition to other
     normal activities.

`-AQUESTION(ANSWER)'
     Assert the answer ANSWER for QUESTION, in case it is tested with a
     preprocessing conditional such as `#if #QUESTION(ANSWER)'.  `-A-'
     disables the standard assertions that normally describe the target
     machine.

`-DMACRO'
     Define macro MACRO with the string `1' as its definition.

`-DMACRO=DEFN'
     Define macro MACRO as DEFN.  All instances of `-D' on the command
     line are processed before any `-U' options.

`-UMACRO'
     Undefine macro MACRO.  `-U' options are evaluated after all `-D'
     options, but before any `-include' and `-imacros' options.

`-dM'
     Tell the preprocessor to output only a list of the macro
     definitions that are in effect at the end of preprocessing.  Used
     with the `-E' option.

`-dD'
     Tell the preprocessing to pass all macro definitions into the
     output, in their proper sequence in the rest of the output.

`-dN'
     Like `-dD' except that the macro arguments and contents are
     omitted.  Only `#define NAME' is included in the output.

`-trigraphs'
     Support ANSI C trigraphs.  The `-ansi' option also has this effect.

`-Wp,OPTION'
     Pass OPTION as an option to the preprocessor.  If OPTION contains
     commas, it is split into multiple options at the commas.


File: gcc.info,  Node: Assembler Options,  Next: Link Options,  Prev: Preprocessor Options,  Up: Invoking GCC

Passing Options to the Assembler
================================

   You can pass options to the assembler.

`-Wa,OPTION'
     Pass OPTION as an option to the assembler.  If OPTION contains
     commas, it is split into multiple options at the commas.


File: gcc.info,  Node: Link Options,  Next: Directory Options,  Prev: Assembler Options,  Up: Invoking GCC

Options for Linking
===================

   These options come into play when the compiler links object files
into an executable output file.  They are meaningless if the compiler is
not doing a link step.

`OBJECT-FILE-NAME'
     A file name that does not end in a special recognized suffix is
     considered to name an object file or library.  (Object files are
     distinguished from libraries by the linker according to the file
     contents.)  If linking is done, these object files are used as
     input to the linker.

`-c'
`-S'
`-E'
     If any of these options is used, then the linker is not run, and
     object file names should not be used as arguments.  *Note Overall
     Options::.

`-lLIBRARY'
     Search the library named LIBRARY when linking.

     It makes a difference where in the command you write this option;
     the linker searches processes libraries and object files in the
     order they are specified.  Thus, `foo.o -lz bar.o' searches
     library `z' after file `foo.o' but before `bar.o'.  If `bar.o'
     refers to functions in `z', those functions may not be loaded.

     The linker searches a standard list of directories for the library,
     which is actually a file named `libLIBRARY.a'.  The linker then
     uses this file as if it had been specified precisely by name.

     The directories searched include several standard system
     directories plus any that you specify with `-L'.

     Normally the files found this way are library files--archive files
     whose members are object files.  The linker handles an archive
     file by scanning through it for members which define symbols that
     have so far been referenced but not defined.  But if the file that
     is found is an ordinary object file, it is linked in the usual
     fashion.  The only difference between using an `-l' option and
     specifying a file name is that `-l' surrounds LIBRARY with `lib'
     and `.a' and searches several directories.

`-lobjc'
     You need this special case of the `-l' option in order to link an
     Objective C program.

`-nostartfiles'
     Do not use the standard system startup files when linking.  The
     standard system libraries are used normally, unless `-nostdlib' or
     `-nodefaultlibs' is used.

`-nodefaultlibs'
     Do not use the standard system libraries when linking.  Only the
     libraries you specify will be passed to the linker.  The standard
     startup files are used normally, unless `-nostartfiles' is used.

`-nostdlib'
     Do not use the standard system startup files or libraries when
     linking.  No startup files and only the libraries you specify will
     be passed to the linker.

     One of the standard libraries bypassed by `-nostdlib' and
     `-nodefaultlibs' is `libgcc.a', a library of internal subroutines
     that GNU CC uses to overcome shortcomings of particular machines,
     or special needs for some languages.  (*Note Interfacing to GNU CC
     Output: Interface, for more discussion of `libgcc.a'.)  In most
     cases, you need `libgcc.a' even when you want to avoid other
     standard libraries.  In other words, when you specify `-nostdlib'
     or `-nodefaultlibs' you should usually specify `-lgcc' as well.
     This ensures that you have no unresolved references to internal
     GNU CC library subroutines.  (For example, `__main', used to
     ensure C++ constructors will be called; *note `collect2':
     Collect2..)

`-s'
     Remove all symbol table and relocation information from the
     executable.

`-static'
     On systems that support dynamic linking, this prevents linking
     with the shared libraries.  On other systems, this option has no
     effect.

`-shared'
     Produce a shared object which can then be linked with other
     objects to form an executable.  Not all systems support this
     option.  You must also specify `-fpic' or `-fPIC' on some systems
     when you specify this option.

`-symbolic'
     Bind references to global symbols when building a shared object.
     Warn about any unresolved references (unless overridden by the
     link editor option `-Xlinker -z -Xlinker defs').  Only a few
     systems support this option.

`-Xlinker OPTION'
     Pass OPTION as an option to the linker.  You can use this to
     supply system-specific linker options which GNU CC does not know
     how to recognize.

     If you want to pass an option that takes an argument, you must use
     `-Xlinker' twice, once for the option and once for the argument.
     For example, to pass `-assert definitions', you must write
     `-Xlinker -assert -Xlinker definitions'.  It does not work to write
     `-Xlinker "-assert definitions"', because this passes the entire
     string as a single argument, which is not what the linker expects.

`-Wl,OPTION'
     Pass OPTION as an option to the linker.  If OPTION contains
     commas, it is split into multiple options at the commas.

`-u SYMBOL'
     Pretend the symbol SYMBOL is undefined, to force linking of
     library modules to define it.  You can use `-u' multiple times with
     different symbols to force loading of additional library modules.


File: gcc.info,  Node: Directory Options,  Next: Target Options,  Prev: Link Options,  Up: Invoking GCC

Options for Directory Search
============================

   These options specify directories to search for header files, for
libraries and for parts of the compiler:

`-IDIR'
     Add the directory DIR to the head of the list of directories to be
     searched for header files.  This can be used to override a system
     header file, substituting your own version, since these
     directories are searched before the system header file
     directories.  If you use more than one `-I' option, the
     directories are scanned in left-to-right order; the standard
     system directories come after.

`-I-'
     Any directories you specify with `-I' options before the `-I-'
     option are searched only for the case of `#include "FILE"'; they
     are not searched for `#include <FILE>'.

     If additional directories are specified with `-I' options after
     the `-I-', these directories are searched for all `#include'
     directives.  (Ordinarily *all* `-I' directories are used this way.)

     In addition, the `-I-' option inhibits the use of the current
     directory (where the current input file came from) as the first
     search directory for `#include "FILE"'.  There is no way to
     override this effect of `-I-'.  With `-I.' you can specify
     searching the directory which was current when the compiler was
     invoked.  That is not exactly the same as what the preprocessor
     does by default, but it is often satisfactory.

     `-I-' does not inhibit the use of the standard system directories
     for header files.  Thus, `-I-' and `-nostdinc' are independent.

`-LDIR'
     Add directory DIR to the list of directories to be searched for
     `-l'.

`-BPREFIX'
     This option specifies where to find the executables, libraries,
     include files, and data files of the compiler itself.

     The compiler driver program runs one or more of the subprograms
     `cpp', `cc1', `as' and `ld'.  It tries PREFIX as a prefix for each
     program it tries to run, both with and without `MACHINE/VERSION/'
     (*note Target Options::.).

     For each subprogram to be run, the compiler driver first tries the
     `-B' prefix, if any.  If that name is not found, or if `-B' was
     not specified, the driver tries two standard prefixes, which are
     `/usr/lib/gcc/' and `/usr/local/lib/gcc-lib/'.  If neither of
     those results in a file name that is found, the unmodified program
     name is searched for using the directories specified in your
     `PATH' environment variable.

     `-B' prefixes that effectively specify directory names also apply
     to libraries in the linker, because the compiler translates these
     options into `-L' options for the linker.  They also apply to
     includes files in the preprocessor, because the compiler
     translates these options into `-isystem' options for the
     preprocessor.  In this case, the compiler appends `include' to the
     prefix.

     The run-time support file `libgcc.a' can also be searched for using
     the `-B' prefix, if needed.  If it is not found there, the two
     standard prefixes above are tried, and that is all.  The file is
     left out of the link if it is not found by those means.

     Another way to specify a prefix much like the `-B' prefix is to use
     the environment variable `GCC_EXEC_PREFIX'.  *Note Environment
     Variables::.

`-specs=FILE'
     Process FILE after the compiler reads in the standard `specs'
     file, in order to override the defaults that the `gcc' driver
     program uses when determining what switches to pass to `cc1',
     `cc1plus', `as', `ld', etc.  More than one `-specs='FILE can be
     specified on the command line, and they are processed in order,
     from left to right.


File: gcc.info,  Node: Target Options,  Next: Submodel Options,  Prev: Directory Options,  Up: Invoking GCC

Specifying Target Machine and Compiler Version
==============================================

   By default, GNU CC compiles code for the same type of machine that
you are using.  However, it can also be installed as a cross-compiler,
to compile for some other type of machine.  In fact, several different
configurations of GNU CC, for different target machines, can be
installed side by side.  Then you specify which one to use with the
`-b' option.

   In addition, older and newer versions of GNU CC can be installed side
by side.  One of them (probably the newest) will be the default, but
you may sometimes wish to use another.

`-b MACHINE'
     The argument MACHINE specifies the target machine for compilation.
     This is useful when you have installed GNU CC as a cross-compiler.

     The value to use for MACHINE is the same as was specified as the
     machine type when configuring GNU CC as a cross-compiler.  For
     example, if a cross-compiler was configured with `configure
     i386v', meaning to compile for an 80386 running System V, then you
     would specify `-b i386v' to run that cross compiler.

     When you do not specify `-b', it normally means to compile for the
     same type of machine that you are using.

`-V VERSION'
     The argument VERSION specifies which version of GNU CC to run.
     This is useful when multiple versions are installed.  For example,
     VERSION might be `2.0', meaning to run GNU CC version 2.0.

     The default version, when you do not specify `-V', is the last
     version of GNU CC that you installed.

   The `-b' and `-V' options actually work by controlling part of the
file name used for the executable files and libraries used for
compilation.  A given version of GNU CC, for a given target machine, is
normally kept in the directory `/usr/local/lib/gcc-lib/MACHINE/VERSION'.

   Thus, sites can customize the effect of `-b' or `-V' either by
changing the names of these directories or adding alternate names (or
symbolic links).  If in directory `/usr/local/lib/gcc-lib/' the file
`80386' is a link to the file `i386v', then `-b 80386' becomes an alias
for `-b i386v'.

   In one respect, the `-b' or `-V' do not completely change to a
different compiler: the top-level driver program `gcc' that you
originally invoked continues to run and invoke the other executables
(preprocessor, compiler per se, assembler and linker) that do the real
work.  However, since no real work is done in the driver program, it
usually does not matter that the driver program in use is not the one
for the specified target and version.

   The only way that the driver program depends on the target machine is
in the parsing and handling of special machine-specific options.
However, this is controlled by a file which is found, along with the
other executables, in the directory for the specified version and
target machine.  As a result, a single installed driver program adapts
to any specified target machine and compiler version.

   The driver program executable does control one significant thing,
however: the default version and target machine.  Therefore, you can
install different instances of the driver program, compiled for
different targets or versions, under different names.

   For example, if the driver for version 2.0 is installed as `ogcc'
and that for version 2.1 is installed as `gcc', then the command `gcc'
will use version 2.1 by default, while `ogcc' will use 2.0 by default.
However, you can choose either version with either command with the
`-V' option.


File: gcc.info,  Node: Submodel Options,  Next: Code Gen Options,  Prev: Target Options,  Up: Invoking GCC

Hardware Models and Configurations
==================================

   Earlier we discussed the standard option `-b' which chooses among
different installed compilers for completely different target machines,
such as Vax vs. 68000 vs. 80386.

   In addition, each of these target machine types can have its own
special options, starting with `-m', to choose among various hardware
models or configurations--for example, 68010 vs 68020, floating
coprocessor or none.  A single installed version of the compiler can
compile for any model or configuration, according to the options
specified.

   Some configurations of the compiler also support additional special
options, usually for compatibility with other compilers on the same
platform.

   These options are defined by the macro `TARGET_SWITCHES' in the
machine description.  The default for the options is also defined by
that macro, which enables you to change the defaults.

* Menu:

* M680x0 Options::
* VAX Options::
* SPARC Options::
* Convex Options::
* AMD29K Options::
* ARM Options::
* MN10300 Options::
* M32R/D Options::
* M88K Options::
* RS/6000 and PowerPC Options::
* RT Options::
* MIPS Options::
* i386 Options::
* HPPA Options::
* Intel 960 Options::
* DEC Alpha Options::
* Clipper Options::
* H8/300 Options::
* SH Options::
* System V Options::
* V850 Options::


File: gcc.info,  Node: M680x0 Options,  Next: VAX Options,  Up: Submodel Options

M680x0 Options
--------------

   These are the `-m' options defined for the 68000 series.  The default
values for these options depends on which style of 68000 was selected
when the compiler was configured; the defaults for the most common
choices are given below.

`-m68000'
`-mc68000'
     Generate output for a 68000.  This is the default when the
     compiler is configured for 68000-based systems.

`-m68020'
`-mc68020'
     Generate output for a 68020.  This is the default when the
     compiler is configured for 68020-based systems.

`-m68881'
     Generate output containing 68881 instructions for floating point.
     This is the default for most 68020 systems unless `-nfp' was
     specified when the compiler was configured.

`-m68030'
     Generate output for a 68030.  This is the default when the
     compiler is configured for 68030-based systems.

`-m68040'
     Generate output for a 68040.  This is the default when the
     compiler is configured for 68040-based systems.

     This option inhibits the use of 68881/68882 instructions that have
     to be emulated by software on the 68040.  If your 68040 does not
     have code to emulate those instructions, use `-m68040'.

`-m68060'
     Generate output for a 68060.  This is the default when the
     compiler is configured for 68060-based systems.

     This option inhibits the use of 68020 and 68881/68882 instructions
     that have to be emulated by software on the 68060.  If your 68060
     does not have code to emulate those instructions, use `-m68060'.

`-m5200'
     Generate output for a 520X "coldfire" family cpu.  This is the
     default when the compiler is configured for 520X-based systems.

`-m68020-40'
     Generate output for a 68040, without using any of the new
     instructions.  This results in code which can run relatively
     efficiently on either a 68020/68881 or a 68030 or a 68040.  The
     generated code does use the 68881 instructions that are emulated
     on the 68040.

`-m68020-60'
     Generate output for a 68060, without using any of the new
     instructions.  This results in code which can run relatively
     efficiently on either a 68020/68881 or a 68030 or a 68040.  The
     generated code does use the 68881 instructions that are emulated
     on the 68060.

`-mfpa'
     Generate output containing Sun FPA instructions for floating point.

`-msoft-float'
     Generate output containing library calls for floating point.
     *Warning:* the requisite libraries are not available for all m68k
     targets.  Normally the facilities of the machine's usual C
     compiler are used, but this can't be done directly in
     cross-compilation.  You must make your own arrangements to provide
     suitable library functions for cross-compilation.  The embedded
     targets `m68k-*-aout' and `m68k-*-coff' do provide software
     floating point support.

`-mshort'
     Consider type `int' to be 16 bits wide, like `short int'.

`-mnobitfield'
     Do not use the bit-field instructions.  The `-m68000' option
     implies `-mnobitfield'.

`-mbitfield'
     Do use the bit-field instructions.  The `-m68020' option implies
     `-mbitfield'.  This is the default if you use a configuration
     designed for a 68020.

`-mrtd'
     Use a different function-calling convention, in which functions
     that take a fixed number of arguments return with the `rtd'
     instruction, which pops their arguments while returning.  This
     saves one instruction in the caller since there is no need to pop
     the arguments there.

     This calling convention is incompatible with the one normally used
     on Unix, so you cannot use it if you need to call libraries
     compiled with the Unix compiler.

     Also, you must provide function prototypes for all functions that
     take variable numbers of arguments (including `printf'); otherwise
     incorrect code will be generated for calls to those functions.

     In addition, seriously incorrect code will result if you call a
     function with too many arguments.  (Normally, extra arguments are
     harmlessly ignored.)

     The `rtd' instruction is supported by the 68010, 68020, 68030,
     68040, and 68060 processors, but not by the 68000 or 5200.

`-malign-int'
`-mno-align-int'
     Control whether GNU CC aligns `int', `long', `long long', `float',
     `double', and `long double' variables on a 32-bit boundary
     (`-malign-int') or a 16-bit boundary (`-mno-align-int').  Aligning
     variables on 32-bit boundaries produces code that runs somewhat
     faster on processors with 32-bit busses at the expense of more
     memory.

     *Warning:* if you use the `-malign-int' switch, GNU CC will align
     structures containing the above types  differently than most
     published application binary interface specifications for the m68k.


File: gcc.info,  Node: VAX Options,  Next: SPARC Options,  Prev: M680x0 Options,  Up: Submodel Options

VAX Options
-----------

   These `-m' options are defined for the Vax:

`-munix'
     Do not output certain jump instructions (`aobleq' and so on) that
     the Unix assembler for the Vax cannot handle across long ranges.

`-mgnu'
     Do output those jump instructions, on the assumption that you will
     assemble with the GNU assembler.

`-mg'
     Output code for g-format floating point numbers instead of
     d-format.


File: gcc.info,  Node: SPARC Options,  Next: Convex Options,  Prev: VAX Options,  Up: Submodel Options

SPARC Options
-------------

   These `-m' switches are supported on the SPARC:

`-mno-app-regs'
`-mapp-regs'
     Specify `-mapp-regs' to generate output using the global registers
     2 through 4, which the SPARC SVR4 ABI reserves for applications.
     This is the default.

     To be fully SVR4 ABI compliant at the cost of some performance
     loss, specify `-mno-app-regs'.  You should compile libraries and
     system software with this option.

`-mfpu'
`-mhard-float'
     Generate output containing floating point instructions.  This is
     the default.

`-mno-fpu'
`-msoft-float'
     Generate output containing library calls for floating point.
     *Warning:* the requisite libraries are not available for all SPARC
     targets.  Normally the facilities of the machine's usual C
     compiler are used, but this cannot be done directly in
     cross-compilation.  You must make your own arrangements to provide
     suitable library functions for cross-compilation.  The embedded
     targets `sparc-*-aout' and `sparclite-*-*' do provide software
     floating point support.

     `-msoft-float' changes the calling convention in the output file;
     therefore, it is only useful if you compile *all* of a program with
     this option.  In particular, you need to compile `libgcc.a', the
     library that comes with GNU CC, with `-msoft-float' in order for
     this to work.

`-mhard-quad-float'
     Generate output containing quad-word (long double) floating point
     instructions.

`-msoft-quad-float'
     Generate output containing library calls for quad-word (long
     double) floating point instructions.  The functions called are
     those specified in the SPARC ABI.  This is the default.

     As of this writing, there are no sparc implementations that have
     hardware support for the quad-word floating point instructions.
     They all invoke a trap handler for one of these instructions, and
     then the trap handler emulates the effect of the instruction.
     Because of the trap handler overhead, this is much slower than
     calling the ABI library routines.  Thus the `-msoft-quad-float'
     option is the default.

`-mno-epilogue'
`-mepilogue'
     With `-mepilogue' (the default), the compiler always emits code for
     function exit at the end of each function.  Any function exit in
     the middle of the function (such as a return statement in C) will
     generate a jump to the exit code at the end of the function.

     With `-mno-epilogue', the compiler tries to emit exit code inline
     at every function exit.

`-mno-flat'
`-mflat'
     With `-mflat', the compiler does not generate save/restore
     instructions and will use a "flat" or single register window
     calling convention.  This model uses %i7 as the frame pointer and
     is compatible with the normal register window model.  Code from
     either may be intermixed.  The local registers and the input
     registers (0-5) are still treated as "call saved" registers and
     will be saved on the stack as necessary.

     With `-mno-flat' (the default), the compiler emits save/restore
     instructions (except for leaf functions) and is the normal mode of
     operation.

`-mno-unaligned-doubles'
`-munaligned-doubles'
     Assume that doubles have 8 byte alignment.  This is the default.

     With `-munaligned-doubles', GNU CC assumes that doubles have 8 byte
     alignment only if they are contained in another type, or if they
     have an absolute address.  Otherwise, it assumes they have 4 byte
     alignment.  Specifying this option avoids some rare compatibility
     problems with code generated by other compilers.  It is not the
     default because it results in a performance loss, especially for
     floating point code.

`-mv8'
`-msparclite'
     These two options select variations on the SPARC architecture.

     By default (unless specifically configured for the Fujitsu
     SPARClite), GCC generates code for the v7 variant of the SPARC
     architecture.

     `-mv8' will give you SPARC v8 code.  The only difference from v7
     code is that the compiler emits the integer multiply and integer
     divide instructions which exist in SPARC v8 but not in SPARC v7.

     `-msparclite' will give you SPARClite code.  This adds the integer
     multiply, integer divide step and scan (`ffs') instructions which
     exist in SPARClite but not in SPARC v7.

     These options are deprecated and will be deleted in GNU CC 2.9.
     They have been replaced with `-mcpu=xxx'.

`-mcypress'
`-msupersparc'
     These two options select the processor for which the code is
     optimised.

     With `-mcypress' (the default), the compiler optimizes code for the
     Cypress CY7C602 chip, as used in the SparcStation/SparcServer 3xx
     series.  This is also appropriate for the older SparcStation 1, 2,
     IPX etc.

     With `-msupersparc' the compiler optimizes code for the SuperSparc
     cpu, as used in the SparcStation 10, 1000 and 2000 series. This
     flag also enables use of the full SPARC v8 instruction set.

     These options are deprecated and will be deleted in GNU CC 2.9.
     They have been replaced with `-mcpu=xxx'.

`-mcpu=CPU_TYPE'
     Set the instruction set, register set, and instruction scheduling
     parameters for machine type CPU_TYPE.  Supported values for
     CPU_TYPE are `v7', `cypress', `v8', `supersparc', `sparclite',
     `f930', `f934', `sparclet', `tsc701', `v9', and `ultrasparc'.

     Default instruction scheduling parameters are used for values that
     select an architecture and not an implementation.  These are `v7',
     `v8', `sparclite', `sparclet', `v9'.

     Here is a list of each supported architecture and their supported
     implementations.

              v7:             cypress
              v8:             supersparc
              sparclite:      f930, f934
              sparclet:       tsc701
              v9:             ultrasparc

`-mtune=CPU_TYPE'
     Set the instruction scheduling parameters for machine type
     CPU_TYPE, but do not set the instruction set or register set that
     the option `-mcpu='CPU_TYPE would.

     The same values for `-mcpu='CPU_TYPE are used for
     `-mtune='CPU_TYPE, though the only useful values are those that
     select a particular cpu implementation: `cypress', `supersparc',
     `f930', `f934', `tsc701', `ultrasparc'.

`-malign-loops=NUM'
     Align loops to a 2 raised to a NUM byte boundary.  If
     `-malign-loops' is not specified, the default is 2.

`-malign-jumps=NUM'
     Align instructions that are only jumped to to a 2 raised to a NUM
     byte boundary.  If `-malign-jumps' is not specified, the default
     is 2.

`-malign-functions=NUM'
     Align the start of functions to a 2 raised to NUM byte boundary.
     If `-malign-functions' is not specified, the default is 2 if
     compiling for 32 bit sparc, and 5 if compiling for 64 bit sparc.

   These `-m' switches are supported in addition to the above on the
SPARCLET processor.

`-mlittle-endian'
     Generate code for a processor running in little-endian mode.

`-mlive-g0'
     Treat register `%g0' as a normal register.  GCC will continue to
     clobber it as necessary but will not assume it always reads as 0.

`-mbroken-saverestore'
     Generate code that does not use non-trivial forms of the `save' and
     `restore' instructions.  Early versions of the SPARCLET processor
     do not correctly handle `save' and `restore' instructions used with
     arguments.  They correctly handle them used without arguments.  A
     `save' instruction used without arguments increments the current
     window pointer but does not allocate a new stack frame.  It is
     assumed that the window overflow trap handler will properly handle
     this case as will interrupt handlers.

   These `-m' switches are supported in addition to the above on SPARC
V9 processors in 64 bit environments.

`-mlittle-endian'
     Generate code for a processor running in little-endian mode.

`-m32'
`-m64'
     Generate code for a 32 bit or 64 bit environment.  The 32 bit
     environment sets int, long and pointer to 32 bits.  The 64 bit
     environment sets int to 32 bits and long and pointer to 64 bits.

`-mcmodel=medlow'
     Generate code for the Medium/Low code model: the program must be
     linked in the low 32 bits of the address space.  Pointers are 64
     bits.  Programs can be statically or dynamically linked.

`-mcmodel=medmid'
     Generate code for the Medium/Middle code model: the program must
     be linked in the low 44 bits of the address space, the text
     segment must be less than 2G bytes, and data segment must be
     within 2G of the text segment.  Pointers are 64 bits.

`-mcmodel=medany'
     Generate code for the Medium/Anywhere code model: the program may
     be linked anywhere in the address space, the text segment must be
     less than 2G bytes, and data segment must be within 2G of the text
     segment.  Pointers are 64 bits.

`-mcmodel=embmedany'
     Generate code for the Medium/Anywhere code model for embedded
     systems: assume a 32 bit text and a 32 bit data segment, both
     starting anywhere (determined at link time).  Register %g4 points
     to the base of the data segment.  Pointers still 64 bits.
     Programs are statically linked, PIC is not supported.

`-mstack-bias'
`-mno-stack-bias'
     With `-mstack-bias', GNU CC assumes that the stack pointer, and
     frame pointer if present, are offset by -2047 which must be added
     back when making stack frame references.  Otherwise, assume no
     such offset is present.


File: gcc.info,  Node: Convex Options,  Next: AMD29K Options,  Prev: SPARC Options,  Up: Submodel Options

Convex Options
--------------

   These `-m' options are defined for Convex:

`-mc1'
     Generate output for C1.  The code will run on any Convex machine.
     The preprocessor symbol `__convex__c1__' is defined.

`-mc2'
     Generate output for C2.  Uses instructions not available on C1.
     Scheduling and other optimizations are chosen for max performance
     on C2.  The preprocessor symbol `__convex_c2__' is defined.

`-mc32'
     Generate output for C32xx.  Uses instructions not available on C1.
     Scheduling and other optimizations are chosen for max performance
     on C32.  The preprocessor symbol `__convex_c32__' is defined.

`-mc34'
     Generate output for C34xx.  Uses instructions not available on C1.
     Scheduling and other optimizations are chosen for max performance
     on C34.  The preprocessor symbol `__convex_c34__' is defined.

`-mc38'
     Generate output for C38xx.  Uses instructions not available on C1.
     Scheduling and other optimizations are chosen for max performance
     on C38.  The preprocessor symbol `__convex_c38__' is defined.

`-margcount'
     Generate code which puts an argument count in the word preceding
     each argument list.  This is compatible with regular CC, and a few
     programs may need the argument count word.  GDB and other
     source-level debuggers do not need it; this info is in the symbol
     table.

`-mnoargcount'
     Omit the argument count word.  This is the default.

`-mvolatile-cache'
     Allow volatile references to be cached.  This is the default.

`-mvolatile-nocache'
     Volatile references bypass the data cache, going all the way to
     memory.  This is only needed for multi-processor code that does
     not use standard synchronization instructions.  Making
     non-volatile references to volatile locations will not necessarily
     work.

`-mlong32'
     Type long is 32 bits, the same as type int.  This is the default.

`-mlong64'
     Type long is 64 bits, the same as type long long.  This option is
     useless, because no library support exists for it.


File: gcc.info,  Node: AMD29K Options,  Next: ARM Options,  Prev: Convex Options,  Up: Submodel Options

AMD29K Options
--------------

   These `-m' options are defined for the AMD Am29000:

`-mdw'
     Generate code that assumes the `DW' bit is set, i.e., that byte and
     halfword operations are directly supported by the hardware.  This
     is the default.

`-mndw'
     Generate code that assumes the `DW' bit is not set.

`-mbw'
     Generate code that assumes the system supports byte and halfword
     write operations.  This is the default.

`-mnbw'
     Generate code that assumes the systems does not support byte and
     halfword write operations.  `-mnbw' implies `-mndw'.

`-msmall'
     Use a small memory model that assumes that all function addresses
     are either within a single 256 KB segment or at an absolute
     address of less than 256k.  This allows the `call' instruction to
     be used instead of a `const', `consth', `calli' sequence.

`-mnormal'
     Use the normal memory model: Generate `call' instructions only when
     calling functions in the same file and `calli' instructions
     otherwise.  This works if each file occupies less than 256 KB but
     allows the entire executable to be larger than 256 KB.  This is
     the default.

`-mlarge'
     Always use `calli' instructions.  Specify this option if you expect
     a single file to compile into more than 256 KB of code.

`-m29050'
     Generate code for the Am29050.

`-m29000'
     Generate code for the Am29000.  This is the default.

`-mkernel-registers'
     Generate references to registers `gr64-gr95' instead of to
     registers `gr96-gr127'.  This option can be used when compiling
     kernel code that wants a set of global registers disjoint from
     that used by user-mode code.

     Note that when this option is used, register names in `-f' flags
     must use the normal, user-mode, names.

`-muser-registers'
     Use the normal set of global registers, `gr96-gr127'.  This is the
     default.

`-mstack-check'
`-mno-stack-check'
     Insert (or do not insert) a call to `__msp_check' after each stack
     adjustment.  This is often used for kernel code.

`-mstorem-bug'
`-mno-storem-bug'
     `-mstorem-bug' handles 29k processors which cannot handle the
     separation of a mtsrim insn and a storem instruction (most 29000
     chips to date, but not the 29050).

`-mno-reuse-arg-regs'
`-mreuse-arg-regs'
     `-mno-reuse-arg-regs' tells the compiler to only use incoming
     argument registers for copying out arguments.  This helps detect
     calling a function with fewer arguments than it was declared with.

`-mno-impure-text'
`-mimpure-text'
     `-mimpure-text', used in addition to `-shared', tells the compiler
     to not pass `-assert pure-text' to the linker when linking a
     shared object.

`-msoft-float'
     Generate output containing library calls for floating point.
     *Warning:* the requisite libraries are not part of GNU CC.
     Normally the facilities of the machine's usual C compiler are
     used, but this can't be done directly in cross-compilation.  You
     must make your own arrangements to provide suitable library
     functions for cross-compilation.


File: gcc.info,  Node: ARM Options,  Next: MN10300 Options,  Prev: AMD29K Options,  Up: Submodel Options

ARM Options
-----------

   These `-m' options are defined for Advanced RISC Machines (ARM)
architectures:

`-mapcs-frame'
     Generate a stack frame that is compliant with the ARM Procedure
     Call Standard for all functions, even if this is not strictly
     necessary for correct execution of the code.

`-mapcs-26'
     Generate code for a processor running with a 26-bit program
     counter, and conforming to the function calling standards for the
     APCS 26-bit option.  This option replaces the `-m2' and `-m3'
     options of previous releases of the compiler.

`-mapcs-32'
     Generate code for a processor running with a 32-bit program
     counter, and conforming to the function calling standards for the
     APCS 32-bit option.  This option replaces the `-m6' option of
     previous releases of the compiler.

`-mhard-float'
     Generate output containing floating point instructions.  This is
     the default.

`-msoft-float'
     Generate output containing library calls for floating point.
     *Warning:* the requisite libraries are not available for all ARM
     targets.  Normally the facilities of the machine's usual C
     compiler are used, but this cannot be done directly in
     cross-compilation.  You must make your own arrangements to provide
     suitable library functions for cross-compilation.

     `-msoft-float' changes the calling convention in the output file;
     therefore, it is only useful if you compile *all* of a program with
     this option.  In particular, you need to compile `libgcc.a', the
     library that comes with GNU CC, with `-msoft-float' in order for
     this to work.

`-mlittle-endian'
     Generate code for a processor running in little-endian mode.  This
     is the default for all standard configurations.

`-mbig-endian'
     Generate code for a processor running in big-endian mode; the
     default is to compile code for a little-endian processor.

`-mwords-little-endian'
     This option only applies when generating code for big-endian
     processors.  Generate code for a little-endian word order but a
     big-endian byte order.  That is, a byte order of the form
     `32107654'.  Note: this option should only be used if you require
     compatibility with code for big-endian ARM processors generated by
     versions of the compiler prior to 2.8.

`-mshort-load-bytes'
     Do not try to load half-words (eg `short's) by loading a word from
     an unaligned address.  For some targets the MMU is configured to
     trap unaligned loads; use this option to generate code that is
     safe in these environments.

`-mno-short-load-bytes'
     Use unaligned word loads to load half-words (eg `short's).  This
     option produces more efficient code, but the MMU is sometimes
     configured to trap these instructions.

`-mbsd'
     This option only applies to RISC iX.  Emulate the native BSD-mode
     compiler.  This is the default if `-ansi' is not specified.

`-mxopen'
     This option only applies to RISC iX.  Emulate the native
     X/Open-mode compiler.

`-mno-symrename'
     This option only applies to RISC iX.  Do not run the assembler
     post-processor, `symrename', after code has been assembled.
     Normally it is necessary to modify some of the standard symbols in
     preparation for linking with the RISC iX C library; this option
     suppresses this pass.  The post-processor is never run when the
     compiler is built for cross-compilation.


File: gcc.info,  Node: MN10300 Options,  Next: M32R/D Options,  Prev: ARM Options,  Up: Submodel Options

MN10300 Options
---------------

   These `-m' options are defined for Matsushita MN10300 architectures:

`-mmult-bug'
     Generate code to avoid bugs in the multiply instructions for the
     MN10300 processors.  This is the default.

`-mno-mult-bug'
     Do not generate code to avoid bugs in the multiply instructions
     for the MN10300 processors.


File: gcc.info,  Node: M32R/D Options,  Next: M88K Options,  Prev: MN10300 Options,  Up: Submodel Options

M32R/D Options
--------------

   These `-m' options are defined for Mitsubishi M32R/D architectures:

`-mcode-model=small'
     Assume all objects live in the lower 16MB of memory (so that their
     addresses can be loaded with the `ld24' instruction), and assume
     all subroutines are reachable with the `bl' instruction.  This is
     the default.

     The addressability of a particular object can be set with the
     `model' attribute.

`-mcode-model=medium'
     Assume objects may be anywhere in the 32 bit address space (the
     compiler will generate `seth/add3' instructions to load their
     addresses), and assume all subroutines are reachable with the `bl'
     instruction.

`-mcode-model=large'
     Assume objects may be anywhere in the 32 bit address space (the
     compiler will generate `seth/add3' instructions to load their
     addresses), and assume subroutines may not be reachable with the
     `bl' instruction (the compiler will generate the much slower
     `seth/add3/jl' instruction sequence).

`-msdata=none'
     Disable use of the small data area.  Variables will be put into
     one of `.data', `bss', or `.rodata' (unless the `section'
     attribute has been specified).  This is the default.

     The small data area consists of sections `.sdata' and `.sbss'.
     Objects may be explicitly put in the small data area with the
     `section' attribute using one of these sections.

`-msdata=sdata'
     Put small global and static data in the small data area, but do not
     generate special code to reference them.

`-msdata=use'
     Put small global and static data in the small data area, and
     generate special instructions to reference them.

`-G NUM'
     Put global and static objects less than or equal to NUM bytes into
     the small data or bss sections instead of the normal data or bss
     sections.  The default value of NUM is 8.  The `-msdata' option
     must be set to one of `sdata' or `use' for this option to have any
     effect.

     All modules should be compiled with the same `-G NUM' value.
     Compiling with different values of NUM may or may not work; if it
     doesn't the linker will give an error message - incorrect code
     will not be generated.

