% function AoC2021_5

fName = 'C:\git\nicholasprice\AoC2021\AoC2021_5_data.txt';
text = fileread(fName);
b = textscan(text, '%d,%d -> %d,%d');
% b = textread(fName, '%d,%d %c%c %d,%d');

x1 = b{1};
y1 = b{2};
x2 = b{3};
y2 = b{4};

useLine = x1==x2 | y1==y1;
nLine = length(x1);

grid = zeros(max([x1; x2]), max([y1; y2]));

for a = 1:nLine
    if ~useLine(a), continue; end
    thisX = unique(sort([x1(a) x2(a)]));
    thisY = unique(sort([y1(a) y2(a)]));

    if length(thisX)==1
        grid(thisX, thisY(1):thisY(2)) = grid(thisX, thisY(1):thisY(2)) + 1;
    end
    
    if length(thisY)==1
        grid(thisX(1):thisX(2), thisY) = grid(thisX(1):thisX(2), thisY) + 1;
    end
    
end

danger = sum(grid(:)>=2)

%% add in the diagonals
% I guess if I cared, I'd go back and use this approach for the previous
% question!
xStep = sign(x2-x1);
yStep = sign(y2-y1);
for a = 1:nLine
    if xStep(a)==0 || yStep(a)==0, continue; end

    xVec = x1(a):xStep(a):x2(a);
    yVec = y1(a):yStep(a):y2(a);
    
    ind = sub2ind(size(grid), xVec, yVec);
    grid(ind) = grid(ind)+1;
end
danger2 = sum(grid(:)>=2)

