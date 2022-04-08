small={
 [-1]= function(adr,a,b)
  A,B,PT=a or {[0]=1,2,3,4},b or {},0
  while 1 do
   local BY=@(adr+PT)
   local FUN,IA,IB=BY%16,(BY\16)\4,(BY\16)%4
   local U,=small[FUN](IA,IB,adr)
   if (U==nil) return A,B
   PT+=U
  end
 end,
 [0] = function(IA,IB) --end
  return nil,A[ib]
 end,
 function(IA,IB) --mov
  A[IB]=A[IA] return 1
 end,
 function(IA,IB,adr) --jmp
  if(IA==0) PT=peek(adr+PT+1) return 0
  PT=IB return 0
 end,
 function(IA,IB) --ifA
  if(IA==0 and A[IB]==A[0]) return 1
  if(IA==1 and A[IB]>A[0]) return 1
  if(IA==2 and A[IB]<A[0]) return 1
  if(IA==3 and A[IB]==0) return 1
  return 3
 end,
 function(IA,IB) --inc
  A[IB]+=1+(-2*IA) return 1
 end,
 function(IA,IB) --sum
  A[IA]+=A[IB] return 1
 end,
 function(IA,IB,adr) --set
  if(IA==0) A[IB]=peek(adr+PT+1) return 2
  if(IA==1) add(B,A[IB]) return 1
  if(IA==2) A[IB]=0 return 1
  if(IA==3) B={} return 1
 end,
 function(IA,IB) --bit
  if(IA==0) A[0]=band(A[0],A[IB]) return 1
  if(IA==1) A[0]=bor(A[0],A[IB]) return 1
  if(IA==2) A[0]=bxor(A[0],A[IB]) return 1
  if(IA==3) A[0]=bnot(A[IB]) return 1
 end,
 function(IA,IB) --rct
  if(IA==0) rect(A[0],A[1],A[2],A[3],A[5]) return 1
  if(IA==1) rectfill(A[0],A[1],A[2],A[3],A[5]) return 1
 end,
 function(IA,IB) --crc
  if(IA==0) circ(A[0],A[1],A[2],A[5]) return 1
  if(IA==1) circfill(A[0],A[1],A[2],A[5]) return 1
 end,
 function(IA,IB) --prt
  local S=""
  for O=1,#B do
   if IA==0 then S ..= chr(B[O])
   else S ..= B[O].." " end
  end
  print(S,A[0],A[1],A[5])return 1
 end,
 function(IA,IB) --clp
  local X,Y,W,H=nil
  if(IA==0) X,Y,W,H=A[1],A[2],A[3],A[4]
  clip(X,Y,W,H) return 1
 end,
 function(IA,IB) --pok
  poke(A[IA],A[IB]) return 1
 end,
 function(IA,IB) --pek
  A[IA]=peek(A[IB]) return 1
 end,
 function(IA,IB) --col
  A[5]=A[IB] return 1
 end,
 function(IA,IB) --col
  A[5]=A[IB] return 1
 end,
}
