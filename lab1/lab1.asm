assume cs:code, ds:data, ss:stack

stack segment
    ; 自定义栈段容量
    db 100 dup(0)
stack ends

data segment
		;declare my name and student id
		info db 'lcy,20009200174$'
		noticemsg1 db 'please input a char$'
		noticemsg2 db 'input q or Q to quit program$'
		chars db 'abcdef$'
data ends

code segment
start:  
    	; ss record stack segement begining address
		mov ax, stack
		mov ss, ax
		; ds record data segement beginint address
		mov ax, data
		mov ds, ax
		; print my info
		mov dx, offset info
		mov ah, 09h
		int 21h
		call linebreak
		; print notice message
		mov dx, offset noticemsg2
		mov ah, 09h
		int 21h
	    call linebreak
printchars:
		; print chars in global variables
		mov cx, 6h
		mov bx, offset chars
printchar: 
		; print a char		
		mov al, [bx]
		mov bl, al
		call dealnumber
		mov bx, offset chars
		add bx, 6h
		sub bx, cx
		loop printchar			
inputandprint:
		; input a char
		call input
		cmp bl, 'q'
		je finish
		cmp bl, 'Q'
		je finish
		call dealnumber
		jmp inputandprint
finish:
		mov ax, 4c00h 
		int 21h

input:
		; this function to input a number to bl
		; print msg
		mov dx, offset noticemsg1
		mov ah, 09h
		int 21h
		call linebreak
		; input a number
		mov ah, 01h
		int 21h
		
		mov bl, al
		call linebreak	
		ret

dealnumber:
		mov bh, bl
		; print hight 4bit
		mov dl, cl
		mov cl, 4
		shr bl, cl
		mov cl, dl
		call print4bit
		mov bl, bh
		; print low 4bit
		and bl, 0FH
		call print4bit
		; print H
		mov dl, 'H'
		mov ah, 02h
		int 21h
		call linebreak	
		ret

print4bit:
		; this function is to print 4bit with ASCII format
		cmp bl, 9h
		jbe add30H
		add bl, 7H
add30H:
		add bl, 30H
		mov dl, bl
		mov ah, 2h
		int 21h
		ret

linebreak:
		mov dl, 0Ah
		mov ah, 02h
		int 21h	
		ret

code ends
      
end start