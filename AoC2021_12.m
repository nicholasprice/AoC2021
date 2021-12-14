function AoC2021_12
tic
% Rule - max visits
doPart = 2; % which part of the problem (1 or 2)

fName = 'C:\git\nicholasprice\AoC2021\AoC2021_12_data.txt';
text = fileread(fName);
% text = readcell(fName);

out=regexp(text,'(?<LL>\w+)-(?<RR>\w+)','names');
from = [{out.LL} {out.RR}];
to = [{out.RR} {out.LL}];
removeMe = contains(from,"end") | contains(to,"start");
from(removeMe) = [];
to(removeMe) = [];
uni = ['start', setdiff(unique([from to]),["start","end"]),'end']; % get things in our preferred order
nEl = length(uni);
fromTo = zeros(nEl-1,nEl);
for a = 1:length(from)
   indFr = startsWith(uni, from{a});
   indTo = startsWith(uni, to{a});
   fromTo(indFr,indTo) = 1;
end


islower = cellfun(@isequal,lower(uni),uni);
islower([1 end]) = false;

pathList{1} = 1;
pathListEnd = {};
indEnd = 0;
while ~isempty(pathList) % keep going unless empty (i.e. all paths have ended or failed)
    indOut = 0;
    pathListOut = {};
    status = [];
    for a = 1:length(pathList) % loop through current paths ...
        nextCaves = nextCaveNum(fromTo,pathList{a}(end));
        for b = 1:length(nextCaves) % ... and check all possible next caves
            thisPath = [pathList{a} nextCaves(b)];
            status(b) = checkSeq(thisPath,uni,islower,doPart);
            if status(b)==1 % keep searching
                indOut = indOut+1;
                pathListOut{indOut} = thisPath;
            elseif status(b)==-1 % "end" - save it
                indEnd = indEnd+1;
                pathListEnd{indEnd} = thisPath;
            end     
            % status==0 - these are just abandoned. 
        end
    end
    pathList = pathListOut;
end
toc
keyboard

% pathList{1} = {'start'};
% hasEnd = 0;
% pathStore = {};
% tic
% while ~all(hasEnd) || ~isempty(pathList)
%     [length(pathList{1}) length(pathStore) length(pathList)]
%     [pathList,hasEnd] = nextCave(pathList, from, to);
%         pathStore = [pathStore pathList(hasEnd)];
%         pathList(hasEnd) = [];
% %     for a = 1:length(pathList)
% %         pathList{a}
% %     end
%     
% %     if length(pathList{1})>8
% %         keyboard
% %     end
%     
% end
% toc
% length(pathStore)
% keyboard

function nextCaves = nextCaveNum(fromto,currCave)
% find next possible caves
nextCaves = find(fromto(currCave,:));

function status = checkSeq(currSeq,uni,islower,doPart)
% check whether sequence is allowed
% currSeq is an array of caves
% status 
% - 0 - error
% - 1 - good - keep hunting
% - -1 - reached "end"

if doPart==1
    if currSeq(end)==length(uni) % "end"
        status = -1;
        return
    end
   N = histcounts(currSeq,1:length(uni)+1);
   if any(N(islower)>1)
       status = 0; % abandon
       return
   else
      status = 1;
        return
   end
    
elseif doPart==2
    if currSeq(end)==length(uni) % "end"
        status = -1;
        return
    end
   N = histcounts(currSeq,1:length(uni)+1);
   if any(N(islower)>2) || sum(N(islower)==2)>1
       status = 0; % abandon
       return
   else
      status = 1;
        return
   end
end






% function [pathListOut,hasEnd] = nextCave(pathListIn, from, to)
% % given the current list of paths, identify all next steps
% % Note that dead-ends naturally die here, because they don't propagate to
% % the output list. 
% 
% solvePart = 2; % which part of the puzzle are you doing?
% 
% 
% indOut = 0;
% nPath = length(pathListIn);
% for a = 1:nPath 
%     indNext = find(startsWith(from,pathListIn{a}{end})); % any extensions?   % was "contains"
%     for b = 1:length(indNext)
%         indOut = indOut+1;
%         pathListOut{indOut} = [pathListIn{a} to(indNext(b))]; % grow list of paths
%         if to{indNext(b)}=="end"
%             hasEnd(indOut) = true;
%         else
%             hasEnd(indOut) = false;
%         end
%     end
% end
% 
% % remove any disallowed paths
% islower = cellfun(@isequal,lower(to),to);
% noReturn = setdiff(unique(to(islower)),"end");
% ind  = 0;
% try
% fprintf('Current list length %d. Doing ', length(pathListOut))
% while ind<length(pathListOut)
%     ind = ind+1;
%     if mod(ind,200)==0, fprintf('%d ', ind); end 
%     % search for repeated visits to lower-case caves
%     if solvePart==1
%         for a = 1:length(noReturn)
%             if sum(startsWith(pathListOut{ind}, noReturn{a}))>1 % been to this cave twice % was "Contains"
%                 pathListOut(ind) = [];
%                 hasEnd(ind) = [];
%                 ind = ind-1; % compensate for deleted entry
%                 break; % break out of the for loop
%             end
%             
%         end
%     elseif solvePart==2
%         nVisit = zeros(1,length(noReturn));
%         for a = 1:length(noReturn)
%             nVisit(a) = sum(startsWith(pathListOut{ind}, noReturn{a})); % was contains
%         end
%         if sum(nVisit==2)>1 || any(nVisit==3) % only allow one double-visit
%             pathListOut(ind) = [];
%             hasEnd(ind) = [];
%             ind = ind-1; % compensate for deleted entry
%         end
%     end
% end
% catch
%     keyboard
% end