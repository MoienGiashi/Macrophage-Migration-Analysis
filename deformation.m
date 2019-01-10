clc
clear all
close all
% Define the poisiotn of MF
prompt = 'What is the MFx value? ';
X = input(prompt)
prompt1 = 'What is the MFy value? ';
Y = input(prompt1)
[x, y,ux, uy, mag, ang1, p1, ux2, uy2, mag2, ang2, p2, ux0,	uy0, mag0, flag] = textread('PIV_Stack-.txt','%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
quiver (x,y,ux,uy,0)

[a b]=size(x);
for i=1:a
R(i)=sqrt((x(i)-X).^2+(y(i)-Y).^2);
end
i=0;
for r=20:20:500  % in case the pixel/um is 2.032 other wise it is 20:20:500
i=i+1;
    R1(i)=r;
end

m=0;

for r=2:24
    m=m+1;
    n=0;
    mag1=0;
 for i=1:a
   if R(i)>=R1(r-1) && R(i)<=R1(r)
       n=n+1;
       mag1=mag(i)+mag1;
   end
 end
   F(m)=n;
   G(m)=mag1;
   H(m)=(mag1/n);
end
    
m=0;
j=0;
Y1=y-Y;
X1=x-X;
for i=1:a
tn(i)=atan2(X1(i),Y1(i));
tn(i)=tn(i)+(tn(i)<0)*2*pi;
end
i=0;
for r=1:13
i=i+1;
    tet(i)=(r-1)*(pi/6);
end
m=0;
for r=2:24
    m=m+1;
       j=0;
    for o=2:13;
        j=j+1;
         n=0;
    mag1=0;
    for i=1:a    
   if R(i)>=R1(r-1) && R(i)<=R1(r) && tn(i)<tet(o) && tn(i)>tet(o-1)
       
       n=n+1;
       mag1=mag(i)+mag1;
   end
    end
    
        I(m,j)=n;
   J(m,j)=mag1;
   K(m,j)=(mag1/n);
 end
  end