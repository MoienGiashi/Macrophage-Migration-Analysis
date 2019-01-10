clc
clear all
close all
O='a2b1-20180529-2';
A=xlsread('For Directedness-Rev',O);
t=300;
MFX=A(:,1);
MFY=A(:,2);

[a b]=size(A);
B=zeros(a,b-2);
m=1;
for n=3:b
    if mod(n,2)==0
    B(:,m)=A(:,n); % gives the y of Mq  
      
     for j=2:a
    C(j-1,m)=abs(B(j-1,m)-B(j,m)); % gives the y traveled every step  
     end
  
   else
        B(:,m)=A(:,n); %gives the x of Mq
         for j=2:a
     C(j-1,m)=abs(B(j-1,m)-B(j,m)); % gives the x traveled every step
         end
    end
    m=m+1;
end
A(isnan(A))=0;
C(isnan(C))=0;
B(isnan(B))=0;
for n=1:b-2
   
c(n)=sum(C(:,n));
end

for n=1:b-2
for m=1:a
   if B(m,n)==0 & B(m-1,n)~0
   d(n)=abs(B(1,n)-B(m-1,n));
   end
   if m==a && B(m,n)~0
       d(n)=abs(B(1,n)-B(a,n));
   end
end
end



for j=1:(b-2)/2
i=2*j;
Acc(j)=sqrt(c(i)^2+c(i-1)^2);
Euc(j)=sqrt(d(i)^2+d(i-1)^2);
Dir(j)=Euc(j)./Acc(j);
end
nn=((b/2)-1);
for p=1:nn

    pp=p*2+2;
    
BB(1,p)=sqrt((A(1,pp-1)-A(1,1)).^2+(A(1,pp)-A(1,2)).^2);  % this gives the corrected initial point of each vector
end

for p=1:nn
for m=1:a
    pp=p*2+2;
   if A(m,pp)==0 & A(m-1,pp)~0
   CC(p)=sqrt((A(1,1)-A(m-1,pp-1)).^2+(A(1,2)-A(m-1,pp)).^2);
   end
   if m==a && A(m,pp)~0;
       CC(p)=sqrt((A(1,1)-A(m,pp-1)).^2+(A(1,2)-A(m,pp)).^2);  % goes and reads the last value of each column and then finds the corrected final value of vector
   end
end
end

z=(Euc.^2+BB.^2-CC.^2)./(2.*Euc.*BB)

alp=acosd(z)

for p=1:nn
for m=1:a
    pp=p*2+2;
         CCC(m,p)=sqrt((A(1,1)-A(m,pp-1)).^2+(A(1,2)-A(m,pp)).^2);  % each step reads the final value
   end
end

