% function AoC2021_10

fName = 'C:\git\nicholasprice\AoC2021\AoC2021_10_data.txt';
% text = fileread(fName);
text = readcell(fName);



% for each row, count opening and closing characters
% incomplete rows have mismatched numbers of each and can be ignored

% I guess we can sit in a while loop
% find first closing character, and then if there is an adjacent opening character, delete them both (otherwise, error)
% 
opening = '([{<';
closing = ')]}>';
pointsCorrupt = [3 57 1197 25137];
pointsIncomplete = [1 2 3 4];

nRow = length(text);
for a = 1:nRow
    seq = text{a};
    %     for b = 1:4
    %         nOpen(b) = sum(seq==opening(b));
    %         nClose(b) = sum(seq==closing(b));
    %     end
    %     complete(a) = all(nOpen==nClose);
    while 1
        indC=find(ismember(seq,closing),1); % first closing character
        if isempty(indC) % no closing brackets
            illegalPos(a) = 0;
            illegalChar{a} = '';
            break;
        end
        if seq(indC-1) ~= opening(closing==seq(indC))
            illegalPos(a) = indC;
            illegalChar{a} = seq(indC);
            break
        else
            % remove two chars
            seq(indC-1:indC) = [];
        end
    end
end

% sum points
illChar = cell2mat(illegalChar);
points1 = 0;
for a = 1:4
    points1 = points1 + pointsCorrupt(a)*sum(illChar==closing(a));
end

% Part 2 - don't code drunk 
points_Part2 = zeros(1,nRow);
p2 = cellfun('isempty',illegalChar);
for a = find(p2)
    seq = text{a};
    
    while ~isempty(seq)
        indC=find(ismember(seq,closing),1); % first closing character
        if isempty(indC) % no closing characters - we'll just remove the last opening char
            points_Part2(a) = points_Part2(a)*5 + pointsIncomplete(seq(end)==opening);
            seq(end) = [];
            continue
        end
        if seq(indC-1) == opening(closing==seq(indC)) % matching brackets
            % remove two chars
            seq(indC-1:indC) = [];
        elseif length(seq)==1
            points_Part2(a) = points_Part2(a)*5 + pointsIncomplete(seq==closing);
            seq(1) = [];
        else
            % remove closing bracket and log required closing bracket
            points_Part2(a) = points_Part2(a)*5 + pointsIncomplete(seq(indC)==closing);
            seq(indC) = [];
        end
    end
end

num2str(median(points_Part2(points_Part2>0)))
