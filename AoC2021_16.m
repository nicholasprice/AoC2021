function AoC2021_16

fName = 'C:\git\nicholasprice\AoC2021\AoC2021_16_data.txt';
text = fileread(fName);

% text = '8A004A801A8002F478'; % 16 correct.
% text ='620080001611562C8802118E34'; % Should be 12. 
% text = 'C0015000016115A2E0802F182340'; % wrong. 
% text = 'A0016C880162017C3686B18A3D4780'; % 31 correct
dat = hexToBinaryVector(text,4*length(text));

% dat = [1   0   1   1   0   0   0   0   1   0   0   0   1   0   1   0   1   0   1   1   0   0   0   1   0   1   1   0   0 1   0   0   0   1   0   0   0   0   0   0   0   0   0   1   0   0   0   0   1   0   0   0   1   1   0   0   0   1   1   1   0   0   0   1   1   0   1   0   0];
% packet structure
% 3 bits - version
% 3 bits - type ID
%
% Type ID 4 (bx100) - multiples of 5 bits, with prefixes of 0 (last 5-bit group) or 1
% Type ID ~4 - operator performing calculations on its sub-packets
% 1 bit - Length Type ID
%       - 0 = 15 bits representing total length of sub-packets in bits
%       - 1 = 11 bits represent number of sub-packets



packets = extractPackets(dat);
out_part1 = getVerNums(packets) % 860
out_part2 = num2str(evalPackets(packets)) % 470949537659
% keyboard


function sumVerNums = getVerNums(packets)

sumVerNums = 0;
for ind=1:length(packets)
    parentNum = sum(2.^(find(fliplr(packets{ind}.ver))-1));
    sumVerNums = sumVerNums + parentNum;
    
    if isfield(packets{ind}, 'subPackets')
        for ind2 = 1:length(packets{ind}.subPackets)
            verNumsSub = getVerNums(packets{ind}.subPackets(ind2));
            sumVerNums = sumVerNums + verNumsSub;
        end
    end
end

function out = evalPackets(packets)
% evaluate value of each packet

for ind = 1:length(packets)
    typeID = sum(2.^(find(fliplr(packets{ind}.typeID))-1));
    switch typeID
        case 0 % sum packet
                out(ind) = sum(evalPackets(packets{ind}.subPackets));
            
        case 1 % product packet
                out(ind) = prod(evalPackets(packets{ind}.subPackets));
            
        case 2 % minimum
                out(ind) = min(evalPackets(packets{ind}.subPackets));
            
        case 3 %max
                out(ind) = max(evalPackets(packets{ind}.subPackets));

        case 4
            out(ind) = packets{ind}.litValDec;

        case 5 % gt
            if evalPackets(packets{ind}.subPackets(1)) > evalPackets(packets{ind}.subPackets(2))
                out(ind) = 1;
            else
                out(ind) = 0;
            end                
            
        case 6 % lt
            if evalPackets(packets{ind}.subPackets(1)) < evalPackets(packets{ind}.subPackets(2))
                out(ind) = 1;
            else
                out(ind) = 0;
            end                
            
        case 7 %==
            if evalPackets(packets{ind}.subPackets(1)) == evalPackets(packets{ind}.subPackets(2))
                out(ind) = 1;
            else
                out(ind) = 0;
            end              
            
        otherwise
            disp('Not this time')
            keyboard
    end
end


function [packets,dat] = extractPackets(dat,findNpackets)
% returns subPackets and remainder of dat (if appropriate)
%

if nargin==1 || isempty(findNpackets)
    findNpackets = inf;
end

ind = 1;
while ~isempty(dat) && ~all(dat==0) && ind<=findNpackets
    % process next packet
    packets{ind}.datRemain = dat; %#ok<*AGROW>
    packets{ind}.ver = dat(1:3); dat(1:3) = []; % packet version
    packets{ind}.typeID = dat(1:3); dat(1:3) = []; % packet typeID
    
    if all(packets{ind}.typeID==[1 0 0]) % 4 => literal value
%         disp('Found literal value')
        % extract groups of 5
        firstBit = 1;
        packets{ind}.litValBin = [];
        while firstBit % grab next 5
            next5 = dat(1:5); dat(1:5) = [];
            firstBit = next5(1);
            packets{ind}.litValBin = [packets{ind}.litValBin next5(2:end)];
        end
        packets{ind}.litValDec = sum(2.^(find(fliplr(packets{ind}.litValBin))-1));
        
    else % operator
        packets{ind}.lengthID = dat(1); dat(1) = [];
        if packets{ind}.lengthID==0 % next 15 bits represent total length in bits of sub-packets
            tmp=dat(1:15); dat(1:15) = [];
            packets{ind}.lengthSub = sum(2.^(find(fliplr(tmp))-1));
%             fprintf('Operator ID 0. nSubPackBits %d\n', packets{ind}.lengthSub)
            packets{ind}.subPacketsBits = dat(1:packets{ind}.lengthSub); dat(1:packets{ind}.lengthSub) = [];
            [packets{ind}.subPackets] = extractPackets(packets{ind}.subPacketsBits); % recursive call
            %  we don't update dat here because it receives exact number of bits
        
        else % next 11 bits represent number of sub-packets
            tmp = dat(1:11); dat(1:11) = [];
            packets{ind}.nSub = sum(2.^(find(fliplr(tmp))-1));
%             fprintf('Operator ID 1. nSubPack %d\n', packets{ind}.nSub)
            [packets{ind}.subPackets,dat] = extractPackets(dat,packets{ind}.nSub); % recursive call
        end
    end
    ind  = ind+1;
    
end