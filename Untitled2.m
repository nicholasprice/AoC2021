% function AoC2021_11

fName = 'C:\git\nicholasprice\AoC2021\AoC2021_11_data.txt';
text = fileread(fName);
dat = -1*ones(10);
ind = 1;
for a = 1:length(text)
    k = str2num(text(a));
    if ~isempty(k)
        dat(ind) = k;
        ind = ind+1;
    end
end
dat = dat';

nStep = 100;
nFlash = 0;
for a = 1:nStep
   % Add 1
   dat = dat+1;
   
   % Find 9s and convolve with ones(3)
   % repeat until all possible elements have flashed this round
   flash = dat==9;
   nFlashNew = sum(flash,'all');
   nFlash = nFlash + nFlashNew;
   while nFlashNew>0
        dat2 = dat + conv2(flash,ones(3),'same');
        flash = dat2==9 - flash; % identify any new flashes
        nFlashNew = sum(flash,'all');
        nFlash = nFlash + nFlashNew;
   end
   
   % Mod 10
   dat = mod(dat,10);
end
nFlash
