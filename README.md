# smallp8
The Sprite Mounted Assembly-Like Language for Pico-8

Small is a table of about 600 tokens(there might be some optimizations) that can be used on it's own to read and process bytes directly from the spritesheet or any other place in memory 

It works with a table(a[0->3]) of 4 registers W,A,B and C and a stack(b[1->]) and a set of instructions, returning both of them when the function ends


#Instruction List
```
group name 
  AAAA - BB  BB NAME
 
End
  0000 - 00  00 end --Finishes the program

Move
  0001 - rg->rg mov --Move rg1 into rg2

Jump
  0010 - 00  00 jmp <- literal --jump to local position >LITERAL
  0010 - 01->rg jmp            --jump to local position >rg
  0010 - 10  00 cjm <- literal --conditional jump to local position >LITERAL
  0010 - 11->rg cjm            --conditional jump to local position >rg

If
  0011 - 00  rg if= <- W --compare rg==w
  0011 - 01  rg if> <- W --compare  rg>w
  0011 - 10  rg if< <- W --compare  rg<w
  0011 - 11  rg if0      --compare rg==0
  
Increment
  0100 - 00  rg inc --increment rg
  0100 - 01  rg dec --decrement rg

SUM
  0101 - rg  rg sum --add rg1+=rg2

SET
  0110 - 00  rg set <- literal --set rg to LITERAL
  0110 - 01  rg psh            --push rg to stack
  0110 - 10  rg clr            --clear rg
  0110 - 11  00 cst            --clear stack

Bitwise op
  0111 - 00  rg and <- W --Bitwise w and rg
  0111 - 01  rg or  <- W --Bitwise w or rg
  0111 - 10  rg xor <- W --Bitwise w xor rg
  0111 - 11  rg not      --Bitwise not rg

Rect
  1000 - 00  00 rct <- stack --rect with the top of the stack as {x0,y0,x1,y1} 
  1000 - 01  00 rcf <- stack --rectfill with the top of the stack as {x0,y0,x1,y1} 
 
Circ
  1001 - 00  00 crc <- stack --circ with the top of the stack as {x0,y0,r}
  1001 - 00  01 crf <- stack --circfill with the top of the stack as{x0,y0,r}

Print
 prt 1010 - 00  rg pnm --print rg as a number
 prt 1010 - 01  rg pch --print rg as a char as p8scii
 
 clp 1011 - 00  00 clp <- stack --clip with the top of the stack as {x0,y0,w,h}

 pok 1100 - rg  rg pok --poke address rg1 with rg2

 pek 1101 - rg  rg pek --peek address rg1 with rg2
 
 col 1111 - 00  rg col --set color to rg
```
