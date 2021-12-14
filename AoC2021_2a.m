function [out, out2] = AoC2021_2a

fName = 'C:\git\nicholasprice\AoC2021\AoC2021_2a_data.txt';
text = fileread(fName);
comms = textscan(text, '%s%d');

fInd = contains(comms{1},'forward');
dInd = contains(comms{1},'down');
uInd = contains(comms{1},'up');

pos = [sum(comms{2}(fInd)) sum(comms{2}(dInd)) - sum(comms{2}(uInd))];
out = pos(1)*pos(2);

%% Part 2

depth = 0; aim = 0; horiz = 0;
for a = 1:length(comms{1})
    switch comms{1}{a}
        case 'forward'
            horiz = horiz + comms{2}(a);
            depth = depth + aim*comms{2}(a);
        case 'down'
            aim = aim + comms{2}(a);
        case 'up'
            aim = aim - comms{2}(a);   
        otherwise
            error('You fucked up')
    end
end

out2 = horiz*depth;