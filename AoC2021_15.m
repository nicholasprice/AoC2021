% function AoC2021_15

clear all
fName = 'C:\git\nicholasprice\AoC2021\AoC2021_15_data.txt';
text = fileread(fName);
for a=1:length(text)
    dat(a) = str2double(text(a));
end
dat(isnan(dat)) = []; % clear up whitespace
nx = sqrt(length(dat));
dat = reshape(dat,nx,nx);


% % let's try only moving down and right, and accumulating values as we go
summed = zeros(size(dat));
% 
% for di = 2:nx % total steps if only down/right
for di = 2:2*nx-1 % total steps if only down/right
%     di
    % in each diagonal, the values sum to di+1
    % [e.g. second diagonal has subs [1 2] and [2 1]
    % third diagonal [1 3; 2 2; 3 1]
%     % in each diagonal, the values sum to di+1
%     % [e.g. 101st diagonal has subs [1 100] and [2 1]
%     % third diagonal [1 3; 2 2; 3 1]

    
    if di<=nx, rows = 1:di; else rows = (di-nx+1):nx; end
for row = rows
        col = di-row+1;
        if col>1 && row>1
            above = summed(row,col-1);
            left = summed(row-1, col);
            adder = min(above,left);
        elseif col>1 && row==1 % nothing above
            adder = summed(1,col-1);
        elseif col==1 && row>1 % nothing left
            adder = summed(row-1,1);
        else
            error('How did you get here?')
        end
        summed(row,col) = adder + dat(row,col);
    end
end
    
% for di = (nx+1):2*nx-1 % total steps if only down/right
% %     di
%  % since we're in the bottom-right half of the grid, there's always
%     % cells above and to the left.
%     %     for row = (di-nx+1):nx
% %         col = di-row+1;
% 
%     for row = (di-nx+1):nx
%         col = di-row+1;
%         above = summed(row,col-1);
%         left = summed(row-1, col);
%         adder = min(above,left);
%         summed(row,col) = adder + dat(row,col);
%     end
% end

out_part1=summed(end)


% % Part 2
% dat2 = zeros(nx*5);
% t = 1:nx;
% for a = 1:5
%     for b = 1:5
%         dat2(t+(a-1)*nx,t+(b-1)*nx) = modPos(dat +a+b-2,9);
%     end
% end
% 
% summed2 = zeros(size(dat2));
% nx2 = 5*nx;
% 
% 
% 
% for di = 2:nx2 % total steps if only down/right
% %     di
%     % in each diagonal, the values sum to di+1
%     % [e.g. second diagonal has subs [1 2] and [2 1]
%     % third diagonal [1 3; 2 2; 3 1]
%     for row = 1:di
%         col = di-row+1;
%         if col>1 && row>1
%             above = summed2(row,col-1);
%             left = summed2(row-1, col);
%             adder = min(above,left);
%         elseif col>1 && row==1 % nothing above
%             adder = summed2(1,col-1);
%         elseif col==1 && row>1 % nothing left
%             adder = summed2(row-1,1);
%         else
%             error('How did you get here?')
%         end
%         summed2(row,col) = adder + dat2(row,col);
%     end
% end
%     
% for di = (nx2+1):(2*nx2-1) % total steps if only down/right
%     % in each diagonal, the values sum to di+1
%     % [e.g. 101st diagonal has subs [1 100] and [2 1]
%     % third diagonal [1 3; 2 2; 3 1]
%     % since we're in the bottom-right half of the grid, there's always
%     % cells above and to the left.
%     for row = (di-nx2+1):nx2
%         col = di-row+1;
%         above = summed2(row,col-1);
%         left = summed2(row-1, col);
%         adder = min(above,left);
%         summed2(row,col) = adder + dat2(row,col);
%     end
% end
% 
% out_part2=summed2(end)
% % too high 2990
% 
% %% Hrmm, let's explore allowing left-and-up movement
% 
% 
