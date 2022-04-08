# smallp8
The Sprite Mounted Assembly-Like Language for Pico-8

Small is a table of about 600 tokens(there might be some optimizations) that can be used on it's own to read and process bytes directly from the spritesheet or any other place in memory 

It works with a table(a[0->3]) of 4 registers w,a,b and c and a pile(b[1->]) and a set of instructions, returning both of them when the function ends


#Instruction List
```
 NAM AAAA - BB  BB NAME
 end 0000 - 00  00 end 

 mov 0001 - rg->rg mov 

 jmp 0010 - 00  00 jmp -> literal
 jmp 0010 - 01->rg jmp 

 ifA 0011 - 00  rg if= -> W
 ifA 0011 - 01  rg if> -> W
 ifA 0011 - 10  rg if< -> W
 ifA 0011 - 11  rg if0 
 
 inc 0100 - 00  rg inc 
 inc 0100 - 01  rg dec 

 sum 0101 - rg  rg sum 

 set 0110 - 00  rg set -> literal
 set 0110 - 01  rg top  
 set 0110 - 10  rg rst 
 set 0110 - 11  00 trs 

 bit 0111 - 00  rg and -> W
 bit 0111 - 01  rg or  -> W
 bit 0111 - 10  rg xor -> W
 bit 0111 - 11  rg not -> W

 rct 1000 - 00  00 rct -> {x0,y0,x1,y1} 
 rct 1000 - 01  00 rcf -> {x0,y0,x1,y1}
 
 crc 1001 - 00  00 crc -> {x0,y0,r}
 crc 1001 - 00  01 crf -> {x0,y0,r}

 prt 1010 - 00  rg pnm -> pile
 prt 1010 - 01  rg pst -> pile
 prt 1010 - 10  rg pcp -> pile
 
 clp 1011 - 00  00 clp -> {x0,y0,w,h}

 pok 1100 - rg  rg pok

 pek 1101 - rg  rg pek
 
 col 1111 - 00  rg col
```
