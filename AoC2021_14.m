function AoC2021_14

fName = 'C:\git\nicholasprice\AoC2021\AoC2021_14_data.txt';
text = fileread(fName);
mapping = textscan(text, '%s -> %s');

seq='NCOPHKVONVPNSKSHBNPF';

% Part 1
nRep = 10;
for a = 1:nRep
    a
    % we'll index backwards to make indexing simpler
    len = length(seq);
    for b=(len-1):-1:1
        thisPair = seq(b:b+1);
        ind = cellfun(@contains, mapping(1),{thisPair},'UniformOutput',false);
        insertMe = mapping{2}{ind{1}};
        seq = [seq(1:b) insertMe seq(b+1:end)];
    end
end

% find most and least common elements
uni = unique(seq);
N = histcounts(double(seq), max(uni)-min(uni)+1);
N(N==0)=[];
d_Part1 = max(N)-min(N)


% Part 2
% only got to rep16 with above approach and boredom set in
% I guess we need to keep track of things as we go!
% There are a limited number of pairs - we can just track them!
clear all
fName = 'C:\git\nicholasprice\AoC2021\AoC2021_14_data.txt';
text = fileread(fName);
mapping = textscan(text, '%s -> %s');

seq='NCOPHKVONVPNSKSHBNPF';
nRep = 40;
pairs = cell2mat(mapping{1});
newLetter = cell2mat(mapping{2});

% do first count of letter pairs
counts = zeros(1,length(pairs));
for a = 1:length(seq)-1
    ind = all(pairs==repmat(seq(a:a+1),length(pairs),1),2);
    counts(ind) = counts(ind)+1;
end

% loop it
for a = 1:nRep
    counts = nextStep(pairs, newLetter, counts);
end

% counts is number of each pairing. But we don't want to double-count
% letters.
% so we can take the first letter in each pair, and add 1 for the last
% letter in the original sequence
uniLetter = unique(pairs(:));
N2 = zeros(size(uniLetter));
for a = 1:length(uniLetter)
    N2(a) = sum(counts(pairs(:,1)==uniLetter(a)));
end
N2(seq(end)==uniLetter) = N2(seq(end)==uniLetter)+1;

d_Part2 = num2str(max(N2)-min(N2))
% 1418051568695 too low!?!
% 3541247715729 too low
keyboard

function countsOut = nextStep(pairs, newLetter, countsIn)
% pairs / newLetter contain pairing to new-letter rule
% counts contains number of pairings (either input or output)

countsOut = zeros(size(countsIn));

for a = 1:length(pairs)
    thisLetter = newLetter(a);
    newPairs = [pairs(a,1) thisLetter; thisLetter pairs(a,2)];
    ind = all(pairs==repmat(newPairs(1,:),length(pairs),1),2) | ...
        all(pairs==repmat(newPairs(2,:),length(pairs),1),2);
    
%     if sum(ind)~=2, keyboard, end
    
    countsOut(ind) = countsOut(ind) + countsIn(a);
end

