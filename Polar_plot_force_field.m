clc
clear all
close all

% Create polar data

t=(2*pi/360).*[0,32.72,65.45,98.16,130.88,163.6,196.32,229.04,261.76,294.48,327.7,360];
r=3.86.*[20,40,60,80,100,120,140,160,180,200,220,240,260,280,300,320,340,360,380];
z=xlsread('mat-par');

% Convert to Cartesian
for i=1:19
for j=1:12
 x(i,j) = r(i).*cos(t(j));
 y(i,j)= r(i).*sin(t(j));
end
end

h = polar(x,y);
hold on;
g=contourf(x,y,z);
hold on

m=[193,-41.8, -173.219,-464.298,-248.843,29.647,-112.315,-104.841,-187.737,-96.44,-153.72,95.692,159.543,40.331,-1.697,-56.209,91.916,-11.361,102.533,56.624];
n=[-72.48,-96.22,171.643,-25.491,-69.595,-37.571,-28.115,69.009,49.79,-41.944,-168.591,-11.014,-42.707,13.472,102.253,36.496,148.068,-80.841,-17.738,83.244];
i=polar(m,n,'.');
set(i,'markersize',15)
set(i,'color','BLack')
hold on
p=[-150.395,106.372,197.269,-232.126,-149.599,-0.51,19.504,-158.976,60.248,179.113,72.59,109.348,-45,-107.156,1.834,245.775,7.658,7.417,-30.229,-268.447,-199.661,-272.837,-287.808,14.88,-141.673,-203.147,-253.969,-545.513];
q=[215.155,263.362,276.206,-335.207,-413.3,250.773,11.557,-36.939,307.791,47.027,-191.485,239.733,97.155,-103.13,-170.51,-41.136,-271.833,118.917,-288.05,-266.807,-258.336,-11.542,48.735,231.038,325.877,273.04,181.834,30.258];

f=polar(p,q,'.');
set(f,'markersize',15)
set(f,'color','white')

ax.ThetaGrid = 'on'

colormap(jet)
% % Hide the POLAR function data and leave annotations
set(h,'Visible','off')
ax.RTick =[0 300 600 900 1200];
%  Turn off axes and set square aspect ratio
%axis off
%axis image
