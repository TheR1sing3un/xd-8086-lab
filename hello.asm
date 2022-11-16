assume cs:code, ds:data, ss:stack

stack segment
    ; 自定义栈段容量
    db 100 dup(0)
stack ends

data segment
		;declare a string with 'hello,world', which is located in begining of data segment
    string db 'hello,world$'
data ends

code segment
start:  
    mov ax, stack
    mov ss, ax

    mov ax, data
    mov ds, ax

    mov ax, 1122h
    push ax  
    pop bx  
		; move string's offset to dx 
    mov dx, offset string
		; 09h in dos means print string
		mov ah, 09h
		; interrupt
		int 21h
		
		; finish
    mov ax, 4c00h 
    int 21h
code ends
      
end start
