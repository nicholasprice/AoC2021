function [out, out2] = AoC2021_3a

fName = 'C:\git\nicholasprice\AoC2021\AoC2021_3_data.txt';
text = fileread(fName);
% there's some crazy white-space formatting
% 12 bits, then 2 whitespace. 
% Also, the end of the file doesn't have the same whitespace :( 
% comms = textscan(text, '%d%d%d%d%d%d%d%d%d%d%d%d\b\b');
% struggling with automated 

% ack, should have just done textscan(text,'%d')
ind = 1;
pos = 0;
while ind<=length(text)
    k = str2num(text(ind));
    if ~isempty(k) && (k==0 || k==1)
        pos = pos+1;
        num(pos)=k;
    end    
    ind = ind+1;
end

dat = reshape(num,12,[])';
% get most-common bit
mu = mean(dat);
gammaBin = mu>0.5;
% convert to binary or decimal
gammaDec = bin2dec(num2str(gammaBin));
epsilonDec = bin2dec(num2str(~gammaBin));

out = gammaDec*epsilonDec;

% Part 2
dat2mcb = dat;
dat2lcb = dat;
for a = 1:12
    mcb = mean(dat2mcb(:,a))>=0.5; % find all rows that are the mcb and also return a 1 if there are equal 1s and 0s
    dat2mcb(dat2mcb(:,a)~=mcb,:) = [];
    size(dat2mcb)
    if size(dat2mcb,1)==1, break; end
end

for a = 1:12
    lcb = mean(dat2lcb(:,a))<0.5; % find all rows that are the lcb, but not rows where there are equal 1s and 0s
    dat2lcb(dat2lcb(:,a)~=lcb,:) = [];
    if size(dat2lcb,1)==1, break; end
end

oxy = bin2dec(num2str(dat2mcb));
co2 = bin2dec(num2str(dat2lcb));

out2 = oxy*co2

% 4786320 - % too low
% 4797452 - % too high
% 4790390