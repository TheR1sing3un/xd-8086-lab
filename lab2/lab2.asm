assume cs:code, ds:data, ss:stack

stack segment
    db 100 dup(0)
stack ends

data segment
    info db 'lcy, 20009200174$'
    noticemsg1 db 'please input at most 5 numbers, input enter to print, and input q or Q to quit program$'
    noticemsg2 db 'you have input more than 5 numbers$'
    noticemsg3 db 'please input number, not letter!$'
data ends

code segment
start:

    mov ax, stack
    mov ss, ax
    mov ax, data
    mov ds, ax
    ; print my info
    mov dx, offset info
    mov ah, 09h
    int 21h
    call linebreak
    ; print notice message
    mov dx, offset noticemsg1
    mov ah, 09h
    int 21h
    call linebreak
    mov bl, 00h
    mov cx, 06h
input:

    ; input at most 5 number
    mov ah, 01h
    int 21h
    mov dl, al
    ; -30h
    sub dl, 30h 
    cmp al, 'q'
    je finish
    cmp al, 'Q'
    je finish
    cmp al, 13
    je printbinary
    cmp al, 48
    jl wronginput
    cmp al, 57
    jg wronginput
    ; pre * 10
    mov al, bl
    mov bl, 10
    mul bl
    mov dh, 0
    add al, dl
    mov bl, al
    loop input

over5numbers:
    mov dx, offset noticemsg2
    mov ah, 09h
    int 21h
    jmp finish

wronginput:
    call linebreak
    mov dx, offset noticemsg3
    mov ah, 09h
    int 21h
    call linebreak
    jmp input

printbinary:
    ; print binary value in bx
    mov cx, 8
    mov ah, 02h
print:
    mov dl, '1'
    test bl, 10000000b
    jne printone
    ; print 0
    mov dl, '0'
printone:
    shl bl, 1 
    int 21h
loopback:
    loop print        
finish:
    mov ax, 4c00h 
    int 21h   
    

linebreak:
		mov dl, 0Ah
		mov ah, 02h
		int 21h	
		ret
    
code ends
end start