.MODEL small
.STACK 100h
.DATA 
msg1 db 13,10,'Hit any key to exit $'
msg2 db 13,10, 'Enter the length you want your Square to be (1-9): $'
msg3 db 13,10, 'Enter the width you want your Square to be (1-9): $'
msg4 db 13,10,'NUMBER CANT BE ZERO $'
msg5 db 13,10,'ILLEGAL CHARACTER! $'
msg6 db 13,10,'Enter the character for the square to be made of: $'
crlf db 13,10,'$'  ;Used to go to the next line
len db 0           ;Uesd to store the length of each line
mone dw 0          ;Use to store the width the user put
counter dw 0       ;use to store the amount of time a line have been draw 
maxLines dw 0      ;Use to store the length thhe user put
char db 0          ;Used to store the char the square is made of
       
.CODE

     mov ax, @data  ; asking for length, width and a char
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
     Jg illegalchr   ;check if the char is a num
     sub al, '0'
     cmp al,0        ;check if the num is zero
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

IsZero:         ;if the number is zero IsZero print msg4 and exit the program
     lea dx, msg4
     mov ah, 09h
     int 21h
     jmp exit                                                  
     
illegalchr:     ;if the char isnt a number illegalchr print msg5 and exit the program
     lea dx, msg5
     mov ah, 09h
     int 21h
     jmp exit

     
nextLine:  ;takes mone and put it in bx, call prtLine and incris the counter
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
         
prtLine:      ;print an enter at the start of each line and put a space
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

prtChar:   ;print a series of the chars
     int 21h
     dec bl 
     jnz prtChar
     ret
     
exit:     ;exit the program
     lea dx, msg1
     mov ah, 09h
     int 21h
     
     mov ah, 01h
     int 21h
     
     mov ah, 4Ch
     int 21h     
         
END
