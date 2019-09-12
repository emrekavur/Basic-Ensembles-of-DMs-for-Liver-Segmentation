% Evaluation code of CHAOS challenge. For original code and more
% information: https://github.com/emrekavur/CHAOS-evaluation

function [DICE, AVD, ASSD, MSSD]=CHAOSMetrics(Vref,Vresult,parameters)

if ~isequal(size(Vref),size(Vresult))
    disp(['Dimension mismatch! Size Vref:' mat2str(size(Vref)) ' Size Vresult:' mat2str(size(Vresult))]);
    DICE=0;
    AVD=100;
    [ASSD, MSSD]=deal(dist(size(Vref),0));
    return
end

%%% Metric 1: Dice Similarity
DICE=dice(Vref,Vresult);

%%% Metric 2: Absolute Volume Difference
% V1=sum(Vref(:));
refVolume=sum(Vref(:));
segVolume=sum(Vresult(:));
AVD=(abs(refVolume-segVolume)/refVolume)*100;

%%% Metric 3: Average Symmetric Surface Distance
%%% Metric 4: Maximum Symmetric Surface Distance

% Extract border voxels
FVRef=Vref & ~imerode(Vref,strel('sphere',1));
[x1,y1,z1]=ind2sub(size(FVRef),find(FVRef==1));
BorderVoxelsRef=[x1,y1,z1];

FVResult=Vresult & ~imerode(Vresult,strel('sphere',1));
[x2,y2,z2]=ind2sub(size(FVResult),find(FVResult==1));
BorderVoxelsResult=[x2,y2,z2];

if ~isempty(BorderVoxelsRef) && ~isempty(BorderVoxelsResult)
    % convert Index to Real world points
    BorderVoxelsRefReal=transformToRealCoordinates(BorderVoxelsRef,parameters);
    BorderVoxelsResultReal=transformToRealCoordinates(BorderVoxelsResult,parameters);
    
    % Distance between border voxels
    MdlKDTResult = KDTreeSearcher(BorderVoxelsResultReal);
    [~,distIndex1] = knnsearch(MdlKDTResult,BorderVoxelsRefReal);
    distIndex1=distIndex1';
    
    MdlKDTRef = KDTreeSearcher(BorderVoxelsRefReal);
    [~,distIndex2] = knnsearch(MdlKDTRef,BorderVoxelsResultReal);
    distIndex2=distIndex2';
    
    ASSD=(sum(distIndex1)+sum(distIndex2))/(size(distIndex1,2)+size(distIndex2,2));
    MSSD=max([distIndex1,distIndex2]);
else
    [ASSD, MSSD]=deal(dist(size(Vref),0));
end


