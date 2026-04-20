.ORIG x3000

START
    ; clear 

CHECK
    ; check for input to see if it is 0-8
    getc 

    ; zero check 
    ld r1, zero
    not r1, r1
    add r1, r1, #1
    add r1, r0, r1 
    BRz BLOCK0

    ; one check
    ld r1, one
    not r1, r1
    add r1, r1, #1
    add r1, r0, r1 
    BRz BLOCK1

    ; two check
    ld r1, two
    not r1, r1
    add r1, r1, #1
    add r1, r0, r1 
    BRz BLOCK2

    ; three check
    ld r1, three
    not r1, r1
    add r1, r1, #1
    add r1, r0, r1 
    BRz BLOCK3

    ; four check
    ld r1, four
    not r1, r1
    add r1, r1, #1
    add r1, r0, r1 
    BRz BLOCK4

    ; five check
    ld r1, five
    not r1, r1
    add r1, r1, #1
    add r1, r0, r1 
    BRz BLOCK5

    ; six check
    ld r1, six
    not r1, r1
    add r1, r1, #1
    add r1, r0, r1 
    BRz BLOCK6

    ; seven check
    ld r1, seven
    not r1, r1
    add r1, r1, #1
    add r1, r0, r1 
    BRz BLOCK7

    ; eight check
    ld r1, eight
    not r1, r1
    add r1, r1, #1
    add r1, r0, r1 
    BRz BLOCK8

    ; nine check
    ld r1, nine
    not r1, r1
    add r1, r1, #1
    add r1, r0, r1 
    BRz BLOCK9

    ; q check
    ld r1, qinput
    not r1, r1
    add r1, r1, #1
    add r1, r0, r1 
    BRz QUIT


    BR CHECK 

BLOCK1
    puts
    lea r2, newline
    puts 

BLOCK2

BLOCK3

BLOCK4

BLOCK5

BLOCK6

BLOCK7

BLOCK8

BLOCK9

QUIT
    halt


; variable instantiation 
white_horiz .fill x7FFF
newline .stringz "/n" 
xmove .stringz "X move: "
omove .stringz "O move: "

.END 