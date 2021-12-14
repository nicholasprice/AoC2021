function AoC2021_9

fName = 'C:\git\nicholasprice\AoC2021\AoC2021_9_data.txt';
text = fileread(fName);
for a=1:length(text)
    dat(a) = str2double(text(a));
end
dat(isnan(dat)) = []; % clear up whitespace
dat = reshape(dat,100,[]);

% find local changepoints
[nr,nc] = size(dat);
r1 = [dat(:,1:nc-1) < dat(:,2:nc) ones(nr,1)];
r2 = [ones(nr,1) dat(:,1:end-1) > dat(:,2:end)];
c1 = [dat(1:end-1,:) < dat(2:end,:); ones(1,nc)];
c2 = [ones(1,nc); dat(1:end-1,:) > dat(2:end,:)];

localmin = r1 & r2 & c1 & c2;
risk = sum(dat(localmin)+1,'all')

% Part 2
% numbers are irrelevant apart from the 9
bw = dat~=9;
for a = 1:3
    bw2 = bwareafilt(bw, a, 'largest', 4);
    arCum(a) = sum(bw2,'all');
end
ar = [arCum(1) diff(ar)];
prod(ar)
imshow(bw2)
% too high - 7179480
