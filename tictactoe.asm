.ORIG x3000

START
    ; clear 

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
        st r1, saver1 
        st r2, saver2

        getc ; get input from keyboard 
        out ; echo 

        ; echo newline, save input, restore input 
        st r0, gm_input
        lea r0, newline
        puts
        ld r0, gm_input 

        ; check for 0 through 8
        ld r1, gm_ascii
        not r1, r1
        add r1, r1, #1
        add r2, r0, r1
        BRn gm_check_q

        add r1, r2, #-9
        BRzp gm_check_q

        add r0, r2, #0
        BR gm_done 

gm_check_q
        ld r0, gm_input
        ; check if the input is q
        ld r1, gm_q
        not r1, r1
        add r1, r1, #1
        add r1, r0, r1
        BRnp gm_invalid 

        add r0, r0, #0
        add r0, r0, #9
        BR gm_done

gm_illegal


        ret 

drawh 
        ; draw a horizontal line starting at (0,y) where y is passed in r0

drawv
        ; draw a vertical line starting at (x,o) where x is passed in r0

drawb 
        ; draws a 20x20 block of pixels 


; variable instantiation 
saver1 .blkw #1
saver2 .blkw #1
gm_input .blkw #1
gm_ascii .fill x0030 
gm_q .fill x0071
white_horiz .fill x7FFF
newline .stringz "\n" 
xmove .stringz "X move: "
omove .stringz "O move: "

.END 