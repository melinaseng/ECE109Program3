.ORIG x3000

START
    ; clear 
    jsr clear

    ; draw the vertical lines 
    ld r0, thirty
    jsr drawv

    ld r0, sixty
    jsr drawv

    ; draw the horizontal lines
    ld r0, thirty
    jsr drawh

    ld r0, sixty
    jsr drawh

    ; cell stuff
    ld r0, cell
    and r1, r1, #0
    and r2, r2, #0
    add r2, r2, #9 ; loop it 9 times 
clear_cells
    str r1, r0, #0
    add r0, r0, #1
    add r2, r2, #-1
    BRp clear_cells

x_player
    lea r0, xmove
    puts
    jsr getmov

    BRn x_player

    st r0, saver 
    add r1, r0, #0
    ld r2, nine
    not r2, r2
    add r2, r2, #1
    add r2, r1, r2
    BRz quit 
    ld r0, saver 

    add r1, r1, #0
    add r1, r1, #1
    jsr drawb

o_player
    lea r0, omove
    puts
    jsr getmov

    BRn o_player
    add r1, r0, #0
    ld r2, nine
    not r2, r2
    add r2, r2, #1
    add r2, r1, r2
    BRz quit 

    add r1, r1, #0
    add r1, r1, #2
    jsr drawb

    BR x_player 

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
        st r7, saver7

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

gm_invalid
        and r0, r0, #0
        add r0, r0, #-1

gm_done
        ld r1, saver1
        ld r2, saver2
        ld r7, saver7
        ret 

drawh 
        ; draw a horizontal line starting at (0,y) where y is passed in r0
        st r0, drawh0
        st r1, drawh1
        st r2, drawh2
        st r3, drawh3
        st r7, drawh7

        and r3, r3, #0
        add r3, r3, #7
drawhmove
        add r0, r0, r0
        add r3, r3, #-1
        BRp drawhmove 

        ld r1, drawh_start
        add r0, r0, r1

        ld r1, drawh_white
        and r2, r2, #0
        ld r2, ninety 
drawh_loop
        str r1, r0, #0
        add r0, r0, #1
        add r2, r2, #-1
        BRp drawh_loop

        ld r0, drawh0
        ld r1, drawh1
        ld r2, drawh2
        ld r3, drawh3
        ld r7, drawh7
        ret


drawh0 .blkw #1
drawh1 .blkw #1
drawh2 .blkw #1
drawh3 .blkw #1
drawh7 .blkw #1
drawh_start .fill xc000
drawh_white .fill x7FFF
ninety .fill #90


drawv
        ; draw a vertical line starting at (x,o) where x is passed in r0
        st r0, drawh0
        st r1, drawh1
        st r2, drawh2
        st r3, drawh3
        st r7, drawh7

        ld r1, drawh_start
        add r0, r0, r1
        ld r1, drawh_white
        ld r2, ninety
drawv_loop
        str r1, r0, #0
        ld r3, onetate 
        add r0, r0, r3
        add r2, r2, #-1
        BRp drawv_loop

        ld r0, drawh0
        ld r1, drawh1
        ld r2, drawh2
        ld r3, drawh3
        ld r7, drawh7
        ret

drawb 
        ; draws a 20x20 block of pixels 
        st r0, drawh0
        st r1, drawh1
        st r2, drawh2
        st r3, drawh3
        st r7, drawh7

        ld r2, cell
        add r2, r2, r0
        ldr r3, r2, #0
        BRp drawb_done

        and r3, r3, #0
        add r3, r3, #1
        str r3, r2, #0

        lea r2, drawb_address
        add r2, r2, r0
        ldr r0, r2, #0

        ld r2, drawb_xaddress
        add r3, r1, #-1
        BRz drawb_draw
        ld r2, drawb_oaddress
drawb_draw
        add r1, r2, #0
        jsr draw

drawb_done
        ld r0, drawh0
        ld r1, drawh1
        ld r2, drawh2
        ld r3, drawh3
        ld r7, drawh7
        ret

        


; variable instantiation 
drawb_xaddress .fill xA000
drawb_oaddress .fill xA200
drawb_address
    .fill xC285
    .fill xC2A3
    .fill xC2C1
    .fill xD185
    .fill xD1A3
    .fill xD1C1
    .fill xE085
    .fill xE0A3
    .fill xE0C1
sixty .fill #60
thirty .fill #30
nine .fill #9
onetate .fill #128
cell .fill x4010
saver .blkw #1 
saver1 .blkw #1
saver2 .blkw #1
saver7 .blkw #1 
gm_input .blkw #1
gm_ascii .fill x0030 ; 0 value 
gm_q .fill x0071
white_horiz .fill x7FFF
newline .stringz "\n" 
xmove .stringz "X move: "
omove .stringz "O move: "

.END 