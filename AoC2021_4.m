function AoC2021_4
% Squid Bingo
%
% Set up N bingo boards as 5*5*N grid

listIn = getNumbers;

fName = 'C:\git\nicholasprice\AoC2021\AoC2021_4_data.txt';
text = fileread(fName);

b = textscan(text, '%d');
boards = reshape(b{1},5,5,[]);

% Find first winner
for a = 1:length(listIn)
    [complete, score] = checkBoard(boards, listIn(1:a));
    if any(complete)
        scoreWinFirst = score(complete);
        break
    end
end
scoreWinFirst

% Find last winner
boards2 = boards;
for a = 1:length(listIn)
    [complete, score] = checkBoard(boards2, listIn(1:a));
    scoreWinLast = score;
    boards2(:,:,complete) = [];
    if isempty(boards2), break; end
end
scoreWinLast


function [complete, score] = checkBoard(boards, numbers)
% boards is 5x5xN
% numbers is 1xn list
% score is (sum of all unmarked numbers) * last number called

inGrid = ismember(boards, numbers);

% check rows / columns
complete = any(all(inGrid,2),1) | any(all(inGrid,1),2);

boardsZero = boards;
for a = 1:length(numbers)
    boardsZero(boardsZero==numbers(a)) = 0;
end
score = sum(sum(boardsZero,1),2) * numbers(end);


function listIn = getNumbers
listIn = [79,9,13,43,53,51,40,47,56,27,0,14,33,60,61,36,72,48,83,42,10,86,41,75,16,80,15,93,95,45,68,96,84,11,85,63,18,31,35,74,71,91,39,88,55,6,21,12,58,29,69,37,44,98,89,78,17,64,59,76,54,30,65,82,28,50,32,77,66,24,1,70,92,23,8,49,38,73,94,26,22,34,97,25,87,19,57,7,2,3,46,67,90,62,20,5,52,99,81,4];
