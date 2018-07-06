clc;
clear all;
close all;
warning off;

I=imread('base.jpg'); %Select any image you want for encryption
% I=rgb2gray(I);
h=histogram(I);

gls = round(h.BinLimits(1)); %gray level start

db='1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*()_+|}{":?><`-=[]\;,./ '; %Database
ldb=length(db);
d=input('Enter the data you want to encrypt: '); %data to be encrypted
ld=length(d);

for i=1:ld   
    for j=1:ldb
        if d(i)==db(j)
            ev(i)= gls +j;  %Encrypting data to mid gray level value %100 is for selecting mid level
        end
    end
end

tx = uint64(length(I(:,1)));
ty = uint64(length(I(1,:)));

xc = uint64((tx-ld)/4);
yc = uint64(ty/2);

xdis = uint64((tx-xc)/(ld*1.5));
ydis = uint64(ty/20);

xp = xc;
yp = yc;

for i=2:ld
    b = ((-1)^i);
    c = mod(i,3);
    d = mod(i,4);
    xp = [xp xc+((i-1)*xdis)];
    yp = [yp yc+(b*ydis)+(c*ydis)-(d*ydis)];
end

C(:,2) = xp(1,:);
C(:,1) = yp(1,:);

for i=1:ld
I(C(i,2),C(i,1))= ev(i);
end

D = C;

% figure,
imshow(I);
% hold on
% plot(C(:,2),C(:,1),'r+');
% title('Encryption');

% folder = 'C:\Users\lenovo\Documents\MATLAB\' ;
% newimagename = [folder 'EncryptedBase1' '.jpg'];
imwrite(I,'EncryptedBase1.png')

ks = [xc yc xdis ydis gls ld]; 

for i=1:6
a = num2str(ks(i));
al = length(a);
if al == 1
    a(3) = a(1);
    a(2) = '0';
    a(1) = '0';
elseif al == 2
    a(3) = a(2);
    a(2) = a(1);
    a(1) = '0';
elseif al == 3
    a = a;
end
K(((3*i)-2):(3*i)) = a;
end  

disp('The generated key: ')
disp(K);

% figure,
% I2=imread('EncryptedBase.jpg');
% imshow(I2);
