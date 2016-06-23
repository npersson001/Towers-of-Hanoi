

.data 0x0
#
# global variables here


.text 0x3000
.globl main

main:

ori     $sp, $0, 0x2ffc     # Initialize stack pointer to the top word below .text
                            # The first value on stack will actually go at 0x2ff8
                            #   because $sp is decremented first.
addi    $fp, $sp, -4        # Set $fp to the start of main's stack frame



# =============================================================
# Create room for temporaries to be protected
addi    $sp, $sp, -8        # Make room on stack for saving any of the following registers
                            #   whose values are precious, and must survive a
                            #   procedure call from main to another procedure (e.g., proc1).
                            # These registers are $t0-$t9, $a0-$a3, and $v0-$v1.
                            # We do not save their values yet; values are saved right
                            #   before calling the other procedure, and restore upon return.

                            # For example, say we need to protect $t0 and $t1
                            #   during a call to proc1.  So, we allocate 2 words on stack.
                            # From now on:
                            #    0($fp) --> $t0's saved value
                            #   -4($fp) --> $11's saved value
# =============================================================



# =============================================================
# Create local variables on stack
                            # Put local variables on the stack.
addi    $sp, $sp, -16       # e.g., int i, j, k, l
sw  $0, 12($sp)             # Set i=0, or skip initialization
sw  $0, 8($sp)              # j=0
sw  $0, 4($sp)              # k=0
sw  $0, 0($sp)              # l=0

                            # From now on:
                            #    -8($fp) --> i's value
                            #   -12($fp) --> j's value
                            #   -16($fp) --> k's value
                            #   -20($fp) --> l's value
# =============================================================



# =============================================================
# Make room for spillover arguments (beyond the first four),
# which are needed to call, say, proc1
                            # Make room for arg[4] and arg[5]
addi    $sp, $sp, -8        # e.g., main will call proc1 with 6 arguments
sw  $0, 4($sp)              # arg[5]=0, or skip initialization
sw  $0, 0($sp)              # arg[4]=0

                            # From now on:
                            #   -24($fp) --> arg[5]'s value
                            #   -28($fp) --> arg[4]'s value
                            # Alternatively:
                            #   4($sp) --> arg[5]'s value
                            #   0($sp) --> arg[4]'s value
                            #
                            # But, after proc1 adjusts $fp, it will access these as:
                            #   8($fp) --> arg[5]'s value
                            #   4($fp) --> arg[4]'s value
                            # etc.
# =============================================================



# =============================================================
# BODY OF main
# ...
# ...

        # ==============================================
        # For calling proc1, see the relevant part
        #   of proc_template
        # ==============================================

# ...
# ...
# put return values, if any, in $v0-$v1
# END OF BODY OF main
# =============================================================



exit_from_main:
ori     $v0, $0, 10     # System call code 10 for exit
syscall                 # Exit the program
end_of_main: