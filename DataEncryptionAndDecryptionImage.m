clc;
clear all;
close all;
warning off;

%{
%decryption
% K = '100125050002010'; %example key
% K=uint64(K); %character to unsigned integer
% l=K-48; %bringing them to integer 
%}

I=imread('base.jpg');
%I=rgb2gray(I);
%imshow(I);

db='1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*()_+|}{":?><`-=[]\;,./ '; %Database
ldb=length(db);
d=input('Enter the data you want to encrypt: '); %data to be encrypted
ld=length(d);

for i=1:ld   
    for j=1:ldb
        if d(i)==db(j)
            ev(i)=100+j;  %Encrypting data to mid gray level value %100 is for selecting mid level
        end
    end
end

%ld = uint64(((l(7))*100)+((l(8))*10)+(l(9))) %%For decryption
tx = length(I(:,1))
ty = length(I(1,:))

xc = uint64((tx-ld)/4)
yc = uint64(ty/2)

xdis = uint64((tx-xc)/(ld*1.5))
ydis = uint64(ty/10)

xp = xc;
yp = yc;

for i=2:ld
    xp = [xp xc+(i*xdis)];
    yp = [yp yc+((-1)^i)*ydis];
end

C(:,1) = xp(1,:);
C(:,2) = yp(1,:);

for i=1:ld
I(C(i,1),C(i,2))= ev(i);
end

imshow(I);

hold on
plot(C(:,1),C(:,2),'r+');

folder = 'C:\Users\lenovo\Documents\MATLAB\' ;
newimagename = [folder 'EncyptedBase' '.jpg'];
imwrite(I,newimagename)


    
% KK(1:3) = xc;
% KK(4:6) = yc;
% KK(7:9) = ld;
% KK(10:12) = xdis;
% KK(13:15) = ydis;
% disp(KK);

