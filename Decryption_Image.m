clc;
clear all;
close all;
warning off;

%run('Encryption_Image.m');

db='1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*()_+|}{":?><`-=[]\;,./ '; %Database

I2=imread('EncryptedBase1.png'); %Select any image you want for encryption

K=input('Enter Key as a character string: '); %example key
K=uint64(K); %character to unsigned integer
l=K-48; %bringing them to integer 

xc = uint64(((l(1))*100)+((l(2))*10)+(l(3)));
yc = uint64(((l(4))*100)+((l(5))*10)+(l(6)));
xdis = uint64(((l(7))*100)+((l(8))*10)+(l(9)));
ydis = uint64(((l(10))*100)+((l(11))*10)+(l(12)));
gls = uint64(((l(13))*100)+((l(14))*10)+(l(15)));
ld = uint64(((l(16))*100)+((l(17))*10)+(l(18)));

% fd=zeros(1,ld);

xp = xc;
yp = yc;

for i=2:ld
    b = uint64((-1)^i);
    c = uint64(mod(i,3));
    d = uint64(mod(i,4));
    xp = [xp xc+((i-1)*xdis)];
    yp = [yp yc+(b*ydis)+(c*ydis)-(d*ydis)];
end

C(:,2) = xp(1,:);
C(:,1) = yp(1,:);

figure,
imshow(I2);
hold on
plot(C(:,2),C(:,1),'r+');
title('Decryption');

for i=1:ld
% C(i,2) = xp(1,i);
% C(i,1) = yp(1,i);
dv(i)= I2(C(i,2),C(i,1));
end

dv = uint64(dv);

for i=1:ld
fd(i)= db(dv(i)-gls);
end
disp(fd);

% disp(D);
% disp(' ');
% disp(' ');
% disp(' ');
% disp(C);
