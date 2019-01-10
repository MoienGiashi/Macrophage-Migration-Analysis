clc
close all
clear all




[x, y,ux, uy, mag, ang1, p1, ux2, uy2, mag2, ang2, p2, ux0,	uy0, mag0, flag] = textread('starburn.txt','%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
quiver (x,y,ux,uy,0)
