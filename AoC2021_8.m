function AoC2021_8

fName = 'C:\git\nicholasprice\AoC2021\AoC2021_8_data.txt';
text = fileread(fName);
dat = textscan(text, '%s %s %s %s %s %s %s %s %s %s | %s %s %s %s');

% Find 1/4/7/8
% UNIQUE LENGTH
% 1 - length 2
% 7 - length 3
% 4 - length 4
% 8 - length 7

% length 5
%# 2 - overlaps 4 elements in "9"
%# 3 - includes all elements in "1"
%# 5 - remaining length 5 element

% length 6
% 0,6,9 - length 6
%# 6 - does not include elements in "7"
% 9 - overlaps all elements in "3" and "4"
% 0 - remaining length 6 element




for a = 1:14
    len(a,:) = cellfun('length',dat{a});
end

lenOut = len(11:14,:);
N=histc(lenOut(:),1:7); % count number of output elements with each length
out1 = sum(N([2 3 4 7])) % lengths corresponding to digits 1, 4, 7, 8


% Part 2
nRow = length(dat{1});

for a = 1:nRow
    for b = 1:10
        inStr{b} = dat{b}{a};
    end
    for b = 1:4
        outStr{b} = dat{10+b}{a};
    end
    
    outNumSing(a) = solveRow(inStr, outStr);
end

out2 = sum(outNumSing)
 keyboard
end

function outNumSing = solveRow(inStr, outStr)
% 1 - length 2; 7 - length 3; 4 - length 4; 8 - length 7



% length 6
% 0,6,9 - length 6
%# 6 - does not include all elements in "7"
%# 9 - overlaps all elements in "4"
% 0 - remaining length 6 element

% length 5
%# 3 - includes all elements in "1"
% 2 - overlaps 4 elements in "9"
% 5 - remaining length 5 element
inNum = nan(1,10);
inLen = cellfun('length',inStr);
inNum(inLen==2) = 1;
inNum(inLen==3) = 7;
inNum(inLen==4) = 4;
inNum(inLen==7) = 8;

% define the 6
for a = 1:10
    ok6(a) = length(intersect(inStr{inLen==3}, inStr{a}))==2 & inLen(a)==6;
end
inNum(ok6)=6;

% define the 3
for a = 1:10
    ok3(a) = length(intersect(inStr{inLen==2}, inStr{a}))==2 & inLen(a)==5;
end
inNum(ok3)=3;

% define the 9
for a = 1:10
    ok9(a) = length(intersect(inStr{inLen==4}, inStr{a}))==4 & inLen(a)==6;
end
inNum(ok9)=9;

% define the 2
for a = 1:10
    ok2(a) = length(intersect(inStr{ok9}, inStr{a}))==4 & inLen(a)==5;
end
inNum(ok2)=2;

% define the 5
inNum(isnan(inNum) & inLen==5) = 5;

% define the 0
inNum(isnan(inNum)) = 0;


for b = 1:4
    for a = 1:10
        inter(a) = isempty(setxor(outStr{b}, inStr{a}));
    end
    outNum(b) = inNum(inter);
end


outNumSing = outNum(1)*1000 + outNum(2)*100 + outNum(3)*10 + outNum(4);
end