clc
clear all
close all
O='sheet3';
A=xlsread('max random migration- 5min time step-no origin',O);
t=5;
MFX=A(:,1);
MFY=A(:,2);

[a b]=size(A);
B=zeros(a,b-2);
Velocity=B;
m=1;
ll=-1;
for n=3:b
    ll=ll+2;
    if mod(n,2)==0
    B(:,m)=A(:,n); % gives the y of Mq  
      
     for j=2:a
    B(j-1,m+2)=abs(B(j-1,m)-B(j,m)); % gives the y traveled every step  
     end
   B(:,m+3)=sqrt((B(:,m+2)).^2+(B(:,m+1)).^2)./t; % velocity to go one step
   Velocity(:,ll)=B(:,m+3);
   s=n-2;
   R(:,s)=B(:,m+3);
   M(:,s)=sqrt((B(:,m+2)).^2+(B(:,m+1)).^2);
   l=0;
   for j=1:a
        l=l+3;
        if l<a-1
    B(j,m+5)=abs(B(l-2,m)-B(l+1,m)); % gives the y traveled every 3 time step  
       end
   end
   B(:,m+6)=(sqrt((B(:,m+5)).^2+(B(:,m+4)).^2))./(t*3); % velocity to go three step
    m=m+10;
    else
        B(:,m)=A(:,n); %gives the x of Mq
         for j=2:a
     B(j-1,m+2)=abs(B(j-1,m)-B(j,m)); % gives the x traveled every step normalized to MF movement
         end
         r=0;
         for j=1:a
             r=r+3;
             if r<a-1
     B(j,m+5)=abs(B(r-2,m)-B(r+1,m)); % gives the x traveled every 3 step normalized to MF movement
        
             end
         end
    end
    m=m+1;
       end

% Corrected x,y

C=zeros(a,b-2);
K=1;
for n=3:b
   if mod(n,2)==0
    C(:,K)=A(:,n)-A(:,2); % gives the corrected y of Mq  
    K=K+1;
   else
    C(:,K)=A(:,n)-A(:,1); % gives the corrected x of Mq  
    K=K+1;
   end
end
[e f]=size(C);
g=f/2;
for q=1:g
for r=1:e   
k=2*q;   
    R(r,k-1)=sqrt(C(r,k)^2+C(r,k-1)^2)./t; % gives the distance vs velocity
end
   
end

for r=1:e
for q=1:g
k=2*q;   
    M(r,k-1)=sqrt(C(r,k)^2+C(r,k-1)^2); % gives the distance vs Travel(deformation)
end
   
end

ii=0;

for n=0:29
    ii=ii+1;
    mn(ii)=n*25;
end

for n=1:29
cnt=0;
sum=0;
for q=1:g
for r=1:e
    
k=2*q;
if M(r,k-1)>mn(n) && M(r,k-1)<mn(n+1)
cnt=cnt+1;
sum=M(r,k)+sum;
end
end
end
average(n+1)=sum/cnt;
end

for n=1:29
cnt=0;
sumsubt=0;
for q=1:g
for r=1:e
    
k=2*q;
if M(r,k-1)>mn(n) && M(r,k-1)<mn(n+1)
cnt=cnt+1;
sumsubt=(average(n+1)-M(r,k))^2+sumsubt;
end
end
end
stde(n+1)=sumsubt/cnt;
end

for n=1:29
cnt=0;
sum=0;
for q=1:g
for r=1:e
    
k=2*q;
if M(r,k-1)>mn(n) && M(r,k-1)<mn(n+1)
cnt=cnt+1;
sum=R(r,k)+sum;
end
end
end
averagevel(n+1)=sum/cnt;
end

for n=1:29
cnt=0;
sumsubt=0;
for q=1:g
for r=1:e
    
k=2*q;
if R(r,k-1)>mn(n) && R(r,k-1)<mn(n+1)
cnt=cnt+1;
sumsubt=(averagevel(n+1)-R(r,k))^2+sumsubt;
end
end
end
stdevel(n+1)=sqrt(sumsubt/(cnt-1));
end
% V=zeros(a-2,2);
% for g=3:b
% for h=1:a
%     if isnan(A(h,g))
%         V(g-2,2)= A(h-1,g);
%     end
%     if h==b
%             V(g-2,2)=A(h,g);
%         end
%         
% end
% end

%xlswrite('MF(ON)-MAC-T1process',B,O);
%xlswrite('MF(ON)-MAC-T1process-corrected',C,O);
%xlswrite('MF(ON)-MAC-T1Velocity',R,O)

%To do Angle measurement, gives the average position of MF 
nn=0;
for n=1:2 
    if mod(n,2)==0      
        for mm=2:a
        E(mm-1,nn)=((A(mm-1,n)+A(mm,n))./2); % gives the average y of MF         
        end
    else
        nn=nn+1;
       for mm=2:a
        E(mm-1,nn)=((A(mm-1,n)+A(mm,n))./2); % gives the average x of MF  
       end
        nn=nn+1;
   end  
end
% To find BB and CC to find the angle
nn=((b/2)-1);
for p=1:nn
for jj=2:a-1
    pp=p*2+2;
    
BB(jj-1,p)=sqrt((A(jj-1,pp-1)-E(jj-1,1)).^2+(A(jj-1,pp)-E(jj-1,2)).^2);
CC(jj-1,p)=sqrt((A(jj,pp-1)-E(jj-1,1)).^2+(A(jj-1,pp)-E(jj,2)).^2);
DD(jj-1,p)=BB(jj-1,p).^2-CC(jj-1,p).^2;
end
end


for aa=1:nn
     if nn==1
       AA(:,1)=(B(:,5)*t).^2;
     else
         aa=aa-1;
         bb=12*aa+5;
         AA(:,aa+1)=(B(:,bb)*t).^2;

     end
end
%AA has one extra point since we averaged were MF is
AA(a,:)=[];
AA(a-1,:)=[];

GG=(AA+DD);
Z=2.*((AA.^0.5).*BB);
ZZ=GG./Z;
alp=acosd(ZZ);

alpha=real(alp);
[e f]=size(alpha);
g=f;
for q=1:g
for r=1:e   
k=2*q;   
    Angel(r,k)=alpha(r,q); % gives the angles
    
end
   
end


for q=1:g
for r=1:e   
k=2*q;   
    angel(r,k-1)=sqrt(C(r,k)^2+C(r,k-1)^2); % gives the distance 
end
   
end

for n=1:29
cnt=0;
sum=0;
for q=1:g
for r=1:e
    
k=2*q;
if angel(r,k-1)>mn(n) && angel(r,k-1)<mn(n+1)
cnt=cnt+1;
sum=Angel(r,k)+sum;
end
end
end
Angelaverage(n+1)=sum/cnt;
end

