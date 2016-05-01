;RC4
jmp setup

key_length: db 03h
plaintext_length: db 09h


;function remainder a
;sets l to 0 if l = a
remainder_a: cmp l
jz remainder_a_2
ret
remainder_a_2: mvi l, 0h
ret

;function swap
;swaps the values at [hd] and [ha]
swap: mov l, d
mov b, m
mov l, a
mov c, m
mov m, b
mov l, d
mov m, c
ret

;store key
setup: mvi h, 0h
mvi h, 0h
mvi l, 0h
mvi m, 04bh
inr l
mvi m, 65h
inr l
mvi m, 79h
inr l

;store plaintext
mvi m, 50h
inr l
mvi m, 06ch
inr l
mvi m, 61h
inr l
mvi m, 69h
inr l
mvi m, 06eh
inr l
mvi m, 74h
inr l
mvi m, 65h
inr l
mvi m, 78h
inr l
mvi m, 74h 
inr l
mvi m, 0h 

;key setup
mvi a, 0h
mvi h, 01h
mvi l, 0h

key_setup_loop_1: mov m, l
inr l
cmp l
jnz key_setup_loop_1

mvi d, 0h
mov a, d
mvi b, 0h
mvi e, 0h

key_setup_loop_2: mov a, b
mov l, d
add m
mov b, a
mvi h, 0h
mov l, e
mvi a, key_length
call remainder_a
mov e, l
mov a, b
add m
mvi h, 01h
call swap
mov b, a
mvi a, 0h
inr d
inr e
cmp d
jnz key_setup_loop_2

;generate output
mvi d, 0
mvi e, 0

output_loop: mvi h, 01h
inr d
mov a, e
mov l, d
add m
mov e, a
mov l, d
call swap
mov a, m
mov l, e
add m
mov l, a
mov b, m
mvi h, 0h
mvi a, key_length
dcr a
add d
mov l, a
mov a, m
xra b
mov m, a
mvi a, 09h
cmp d
jnz output_loop

hlt