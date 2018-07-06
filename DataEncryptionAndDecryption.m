clc;
clear all;
close all;
warning off;

db='1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*()_+|}{":?><`-=[]\;,./ '; %Database
d=input('Enter the data you want to encrypt: '); %data to be encrypted
ld=length(d);

for i=1:length(d)   
    for j=1:length(db)
        if d(i)==db(j)
            ev(i)=100+j;  %Encrypting data to mid gray level value %100 is for selecting mid level
        end
    end
end


%{
%Decryption logic
for i=1:length(ev)
fd(i)= db(ev(i)-100);
end
disp(fd);
%}
