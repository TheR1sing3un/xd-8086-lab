assume cs:code, ds:data, ss:stack

stack segment
    db 100 dup(0)
stack ends

data segment
    info db 'lcy, 20009200174$'
    noticemsg1 db 'please input at most 5 numbers, input enter to print, and input q or Q to quit program$'
    noticemsg2 db 'you have input more than 5 numbers'
data ends

code segment
start:

    mov ax, stack
    mov ss, ax
    mox ax, data
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
    mov bx, 00h

input:

    ; input at most 5 number
    mov ah, 01h
    int 21h
    mov cl, al
    ; -30h
    sub cl, 30h
    cmp al, 'q'
    je finish
    cmp al, 'Q'
    je finish
    cmp al, 13h
    je printbinary
    ; pre * 10
    mov ax, bx
    mov bl, 10h
    mul bl
    add ax, cl
    mov bx, ax
    loop input

over5numbers:
    mov dx, offset noticemsg2
    mov ah, 09h
    int 21h
    jmp finish

printbinary:
    ; print binary value in bx
    mov cx, 8
    mov ah, 02h
print:
    mov dl, '1'
    test bl, 100000000h
    jne printone
    ; print 0
    mov dl, '0'
printone:
    int 21h
loopback:
    loop printbinary        
finish:
    mov ax, 4c00h 
    int 21h   
    

linebreak:
		mov dl, 0Ah
		mov ah, 02h
		int 21h	
		ret

    
code ends
ens start