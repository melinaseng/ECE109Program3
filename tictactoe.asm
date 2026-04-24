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
    add r0, r0, #9
    BRz QUIT

    ; illegal command return -1 in r0
    add r0, r0, #-1

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
    HALT

draw    st r0 d_r0
        st r1 d_r1
        st r2 d_r2
        st r3 d_r3
        ld r2 img_dim
d_row  brz d_done
        ld r3 img_dim
d_col  brz d_col_done
        ldr r5 r1 #0
        str r5 r0 #0
        add r1 r1 #1
        add r0 r0 #1
        add r3 r3 #-1
        br d_col
d_col_done
        ld r3 d_108
        add r0 r0 r3
        add r2 r2 #-1
        br d_row
d_done  ld r0 d_r0
        ld r1 d_r1
        ld r2 d_r2
        ld r3 d_r3
        ret
img_dim .fill #20
d_108   .fill #108
d_r0    .blkw #1
d_r1    .blkw #1
d_r2    .blkw #1
d_r3    .blkw #1


clear   st r0 cl_r0
        st r1 cl_r1
        st r2 cl_r2
        and r2 r2 #0
        ld r0 origin
        ld r1 num_px
cl_loop str r2 r0 #0
        add r0 r0 #1
        add r1 r1 #-1
        brp cl_loop
        ld r0 cl_r0
        ld r1 cl_r1
        ld r2 cl_r2
        ret
cl_r0   .blkw 1
cl_r1   .blkw 1
cl_r2   .blkw 1
origin  .fill xc000
num_px  .fill 15872

; --- required subroutines ---

getmov
        ; used to get the next move from a player
        getc 
        puts
        BR check 

drawh 
        ; draw a horizontal line starting at (0,y) where y is passed in r0

drawv
        ; draw a vertical line starting at (x,o) where x is passed in r0

drawb 
        ; draws a 20x20 block of pixels 


; variable instantiation 
white_horiz .fill x7FFF
newline .stringz "/n" 
xmove .stringz "X move: "
omove .stringz "O move: "

.END 