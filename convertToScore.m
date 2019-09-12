% This function converts CHAOS metric outputs to scores with help of
% predefined thresholds.

function [DICEscore, AVDscore, ASSDscore, MSSDscore]=convertToScore(DICE, AVD, ASSD, MSSD)

DICEscore=0;
AVDscore=0;
ASSDscore=0;
MSSDscore=0;

thresholdDICE=0.8; % 80% overlap
thresholdAVD=5; % 5% error margin
thresholdASSD=15; % Max dist 15mm
thresholdMSSD=60; % Max dist 60mm

%DICE score calculation (higher is better) 0--1 --> 0--100
if DICE >= thresholdDICE
    DICEscore=DICE*100;
end

%Absolute Volume Diffrence score calculation(lower is better)
if AVD <= thresholdAVD
    AVDscore=((thresholdAVD-AVD)/thresholdAVD)*100;
end

%Average Symmetric Surcafe Difference score calculation (lower is better)
if ASSD <= thresholdASSD
    ASSDscore=((thresholdASSD-ASSD)/thresholdASSD)*100;
end

%Maximum Symmetric Surcafe Difference score calculation (lower is better)
if MSSD <= thresholdMSSD
    MSSDscore=((thresholdMSSD-MSSD)/thresholdMSSD)*100;
end