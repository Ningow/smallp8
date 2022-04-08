--smallp8 by ningow
--[[sPRITE
mOUNTED
aSSEMBLY-
lIKE
lANGUAGE--]]

--[[
 group name 
  AAAA - BB  BB NAME
 
end
  0000 - 00  00 end --Finishes the program

move
  0001 - rg->rg mov --Move rg1 into rg2

jump
  0010 - 00  00 jmp <- literal --jump to local position >LITERAL
  0010 - 01->rg jmp            --jump to local position >rg
  0010 - 10  00 cjm <- literal --conditional jump to local position >LITERAL
  0010 - 11->rg cjm            --conditional jump to local position >rg

if
  0011 - 00  rg if= <- W --compare rg==w
  0011 - 01  rg if> <- W --compare  rg>w
  0011 - 10  rg if< <- W --compare  rg<w
  0011 - 11  rg if0      --compare rg==0
  
increment
  0100 - 00  rg inc --increment rg
  0100 - 01  rg dec --decrement rg

sum
  0101 - rg  rg sum --add rg1+=rg2

set
  0110 - 00  rg set <- literal --set rg to LITERAL
  0110 - 01  rg psh            --push rg to stack
  0110 - 10  rg clr            --clear rg
  0110 - 11  00 cst            --clear stack

bitwise op
  0111 - 00  rg and <- W --Bitwise w and rg
  0111 - 01  rg or  <- W --Bitwise w or rg
  0111 - 10  rg xor <- W --Bitwise w xor rg
  0111 - 11  rg not      --Bitwise not rg

rect
  1000 - 00  00 rct <- stack --rect with the top of the stack as {x0,y0,x1,y1} 
  1000 - 01  00 rcf <- stack --rectfill with the top of the stack as {x0,y0,x1,y1} 
 
circ
  1001 - 00  00 crc <- stack --circ with the top of the stack as {x0,y0,r}
  1001 - 00  01 crf <- stack --circfill with the top of the stack as{x0,y0,r}

print
  prt 1010 - 00  rg pnm --print rg as a number
  prt 1010 - 01  rg pch --print rg as a char as p8scii

clip
  clp 1011 - 00  00 clp <- stack --clip with the top of the stack as {x0,y0,w,h}

poke
  pok 1100 - rg  rg pok --poke address rg1 with rg2

peek
  pek 1101 - rg  rg pek --peek address rg1 with rg2
 
color
  col 1111 - 00  rg col --set color to rg

 --]]

small={
 [-1]= function(addr,a,b)
  adr,R,ST,PT=addr,a or {[0]=1,2,3,4},b or {},0
  while 1 do
   local BY=@(adr+PT)
   FUN,IA,IB=BY%16,(BY\16)\4,(BY\16)%4
   local U=small[FUN]()
   if (U==nil) return R,ST
   PT+=U
  end
 end,
 [0] = function() --end
  return nil,R[ib]
 end,
 function() --mov
  R[IB]=R[IA] return 1
 end,
 function() --jmp
  if(IA==0) PT=@(adr+PT+1) return 0
  if(IA==1) PT=IB return 0
  if(IA==2 and R[4]) PT=@(adr+PT+1) return 0
  if(IA==3 and R[4]) PT=IB return 0
  return 1
 end,
 function() --ifA
  if(IA==0) R[4]=R[IB]==R[0] return 1
  if(IA==1) R[4]=R[IB]>R[0] return 1
  if(IA==2) R[4]=R[IB]<R[0] return 1
  if(IA==3) R[4]=R[IB]==0 return 1
 end,
 function() --inc
  R[IB]+=1+(-2*IA) return 1
 end,
 function() --sum
  R[IA]+=R[IB] return 1
 end,
 function() --set
  if(IA==0) R[IB]=@(adr+PT+1) return 2
  if(IA==1) add(ST,R[IB]) return 1
  if(IA==2) R[IB]=0 return 1
  if(IA==3) ST={} return 1
 end,
 function() --bit
  if(IA==0) R[0]&=R[IB] return 1
  if(IA==1) R[0]|=R[IB] return 1
  if(IA==2) R[0]=R[0]^^R[IB] return 1
  if(IA==3) R[0]=~R[IB] return 1
 end,
 function() --rct
  local L={}
  for T=1,4 do
   L[T],ST[#ST]=ST[#ST]
  end
  L[5]=R[5]
  if(IA==0) rect(L) return 1
  if(IA==1) rectfill(L) return 1
 end,
 function() --crc
  local L={}
  for T=1,3 do
   L[T],ST[#ST]=ST[#ST]
  end
  L[4]=R[5]
  if(IA==0) circ(L) return 1
  if(IA==1) circfill(L) return 1
 end,
 function() --prt
 	local L={}
  if(IA==0)then L={R[IB]}
  else L={chr(R[IB])} end
  for T=2,3 do
   L[T],ST[#ST]=ST[#ST]
  end
  L[4]=R[5]
  print(L)return 1
 end,
 function() --clp
  local X,Y,W,H=nil
  if(IA==0) X,Y,W,H=R[1],R[2],R[3],R[4]
  clip(X,Y,W,H) return 1
 end,
 function() --pok
  poke(R[IA],R[IB]) return 1
 end,
 function() --pek
  R[IB]=peek(R[IA]) return 1
 end,
 function() --col
  R[5]=R[IB] return 1
 end,
 function() --col
  R[5]=R[IB] return 1
 end,
}
