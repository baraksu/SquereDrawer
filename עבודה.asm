.MODEL small
.STACK 100h
.DATA 
msg1 db 13,10,'Hit any key to exit $'
msg2 db 13,10, 'Enter the length you want your Square to be (1-9): $'
msg3 db 13,10, 'Enter the width you want your Square to be (1-9): $'
msg4 db 13,10,'NUMBER CANT BE ZERO $'
msg5 db 13,10,'ILLEGAL CHARACTER! $'
msg6 db 13,10,'Enter the character for the square to be made of: $'
crlf db 13,10,'$'
len db 0
mone dw 0
counter dw 0        
maxLines dw 0
char db 0
       
.CODE

     mov ax, @data
     mov ds, ax

     lea dx, msg2
     mov ah, 09h
     int 21h
     
     mov ah, 01h
     int 21h
     cbw
     cmp al, '0'     
     jl illegalchr  
     CMP al, '9'
     Jg illegalchr
     sub al, '0'
     cmp al,0
     je IsZero
     mov maxLines,ax
     
     lea dx, msg3
     mov ah, 09h
     int 21h
     
     mov ah, 01h
     int 21h
     cbw
     cmp al, '0'     
     jl illegalchr  
     cmp al, '9'
     jg illegalchr
     sub al, '0'
     cmp al,0
     je IsZero
     mov mone,ax
     
     lea dx, msg6
     mov ah, 09h
     int 21h
     
     mov ah, 01h
     int 21h
     mov char,al
     
     jmp nextLine  

IsZero:
     lea dx, msg4
     mov ah, 09h
     int 21h
     jmp exit
     
illegalchr:
     lea dx, msg5
     mov ah, 09h
     int 21h
     jmp exit

     
nextLine: 
     mov bx, mone
     push bx
     call prtLine
     mov bx, mone
     
     mov mone, bx
     
     inc counter
     mov ax, maxLines
     cmp counter,ax  
     je exit       
     
     jmp nextLine
         
prtLine: 
     pop ax
     pop bx
     push ax
     mov len, bl
         
     lea dx, crlf
     mov ah, 09h
     int 21h
     
     mov ah, 2h
     mov dl, 09h
     int 21h
         
     mov dl, char
     mov ah, 02h

prtChar: 
     int 21h
     dec bl 
     jnz prtChar
     ret
     
exit:
     lea dx, msg1
     mov ah, 09h
     int 21h
     
     mov ah, 01h
     int 21h
     
     mov ah, 4Ch
     int 21h     
         
END
