% function AoC2021_12

fName = 'C:\git\nicholasprice\AoC2021\AoC2021_13_data.txt';
text = fileread(fName);
dat = textscan(text,'%d,%d');
dotPos = double(cell2mat(dat))+1; % base 0
mx = fliplr(max(dotPos)); % Matlab row vs column funtimes

dots = zeros(mx);
ind = sub2ind(mx,dotPos(:,2), dotPos(:,1));
dots(ind) = 1;

% Folding data
foldOri = 'xyxyxyxyxyyy';
foldPos = [655 447 327 223 163 111 81 55 40 27 13 6];
nFold = length(foldPos);

for a = 1:nFold
    sz = size(dots);
    switch foldOri(a)
        case 'x'
            xMax = size(dots,2);
             len1 = foldPos(a);
            len2 = xMax-(foldPos(a)+2);
            pad = abs(len2-len1)-1;
            if foldPos(a)*2+1 == xMax % folding perfectly in half
                dotsA = dots(:,1:foldPos(a));
                dotsB = fliplr(dots(:, foldPos(a)+2:end));
            elseif foldPos(a)*2+1 < xMax % expand top of first segment
                dotsA = [zeros(sz(1), pad) dots(:, 1:foldPos(a))];
                dotsB = fliplr(dots(:, foldPos(a)+2:end));
            else % expand left of second segment (after folding)
                dotsA = dots(:, 1:foldPos(a));
                dotsB = [zeros(sz(1), pad) fliplr(dots(:, foldPos(a)+2:end))];
            end
            
        case 'y'

            yMax = size(dots,1);
            len1 = foldPos(a);
            len2 = yMax-(foldPos(a)+2);
            pad = abs(len2-len1)-1;
            if foldPos(a)*2+1 == yMax % folding perfectly in half
                dotsA = dots(1:foldPos(a), :);
                dotsB = flipud(dots(foldPos(a)+2:end, :));
            elseif foldPos(a)*2+1 < yMax % expand top of first segment
                dotsA = [zeros(pad, sz(2)); dots(1:foldPos(a), :)];
                dotsB = flipud(dots(foldPos(a)+2:end, :));
            else % expand top of second segment (after folding)
                dotsA = dots(1:foldPos(a), :);
                dotsB = [zeros(pad, sz(2)); flipud(dots(foldPos(a)+2:end, :))];
            end
            

    end
    % combine
    dots = dotsA | dotsB;
    sum(dots, 'all')
end


% 
% fold along x=655
% fold along y=447
% fold along x=327
% fold along y=223
% fold along x=163
% fold along y=111
% fold along x=81
% fold along y=55
% fold along x=40
% fold along y=27
% fold along y=13
% fold along y=6