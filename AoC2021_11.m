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

nStep = 1000;
nFlash = 0;
for a = 1:nStep
   % Add 1
   dat = dat+1;
   
   % Find 9s and convolve with ones(3)
   % repeat until all possible elements have flashed this round
   flash = dat>9;
   allFlash = flash;
   nFlashNew = sum(flash,'all');
   nFlash = nFlash + nFlashNew;
   nFlashRound = nFlashNew;
   while nFlashNew>0
        dat = dat + conv2(flash,ones(3),'same');
        flash = (dat>9) & ~allFlash; % identify any new flashes
        allFlash = allFlash | flash; % keep track of all flashes on this round
        nFlashNew = sum(flash,'all');
        nFlash = nFlash + nFlashNew;
        nFlashRound = nFlashRound + nFlashNew;
        if nFlashRound==100
            fprintf('Sync on round %d\n', a);
        end
   end
   % Reset
   dat(dat>=10) = 0;
end
nFlash

