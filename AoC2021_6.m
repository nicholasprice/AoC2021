function AoC2021_6

dEnd = 256;
t = getDat;
% 
% for d = 1:dEnd
%    t = t-1;
%    nNeg = sum(t<0);
%    t(t==-1) = 6;
%    if nNeg>0
%         t = [t 8*ones(1,nNeg)];
%    end
%    [d length(t)]
% end
% length(t)

% Bugger, this is a poor solution. Need to do some thinking.
% Each initial 6 is associated with:
% at day t
% - itself
% - mod ?? new fish
% - floor((t-9),7)

% 1 fish for 7 days
% 2 fish for 14 days
% 3 fish for 


% Testing 
% dEnd = 256;
% t = 6;
% for d = 1:dEnd
%    t = t-1;
%    nNeg = sum(t<0);
%    t(t==-1) = 6;
%    if nNeg>0
%         t = [t 8*ones(1,nNeg)];
%    end
%    leng(d) = length(t);
% end
% leng

% New approach
% number of fish with each number of days left
dLeft = histc(t,0:8); % initial
for d = 1:dEnd
    dLeft = circshift(dLeft,-1);
    dLeft(7) = dLeft(7) + dLeft(9); % respawn 
end
nTot = sum(dLeft)
keyboard

% For each fish starting on 6
% ind = 1:dEnd;
% k0 = ones(1,dEnd);
% k1 = floor(ind /7);
% k2 = max(floor((ind-9)/7),0);
% k3 = max(floor((ind-9*2)/7),0);
% k4 = max(floor((ind-9*3)/7),0);
% k5 = max(floor((ind-9*4)/7),0);
% k6 = max(floor((ind-9*5)/7),0);
% sum([k0; k1; k2; k3; k4; k5; k6])
% 
% a = 0;
% ll = ones(1,dEnd);
% while dEnd-9*a > 0
%     incLoop = max(floor((ind-9*a)/7),0);
%     ll = ll + incLoop;
%     a = a+1;
% end



function t = getDat
t = [3,3,2,1,4,1,1,2,3,1,1,2,1,2,1,1,1,1,1,1,4,1,1,5,2,1,1,2,1,1,1,3,5,1,5,5,1,1,1,1,3,1,1,3,2,1,1,1,1,1,1,4,1,1,1,1,1,1,1,4,1,3,3,1,1,3,1,3,1,2,1,3,1,1,4,1,2,4,4,5,1,1,1,1,1,1,4,1,5,1,1,5,1,1,3,3,1,3,2,5,2,4,1,4,1,2,4,5,1,1,5,1,1,1,4,1,1,5,2,1,1,5,1,1,1,5,1,1,1,1,1,3,1,5,3,2,1,1,2,2,1,2,1,1,5,1,1,4,5,1,4,3,1,1,1,1,1,1,5,1,1,1,5,2,1,1,1,5,1,1,1,4,4,2,1,1,1,1,1,1,1,3,1,1,4,4,1,4,1,1,5,3,1,1,1,5,2,2,4,2,1,1,3,1,5,5,1,1,1,4,1,5,1,1,1,4,3,3,3,1,3,1,5,1,4,2,1,1,5,1,1,1,5,5,1,1,2,1,1,1,3,1,1,1,2,3,1,2,2,3,1,3,1,1,4,1,1,2,1,1,1,1,3,5,1,1,2,1,1,1,4,1,1,1,1,1,2,4,1,1,5,3,1,1,1,2,2,2,1,5,1,3,5,3,1,1,4,1,1,4];