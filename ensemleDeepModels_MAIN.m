% This script contains the codes for evaluation of four individual deep 
% models and their ensembles. Data is taken from CHAOS challenge, CT Set 2
% The individual DMs are:
%
%[1] K. Kamnitsas, E. Ferrante, S. Parisot, C. Ledig, A. V. Nori,
%A. Criminisi et al., "DeepMedic for brain tumor segmentation," in
%Lecture Notes in Computer Science (including subseries Lecture Notes
%in Artificial Intelligence and Lecture Notes in Bioinformatics)
%
%[2] E. Gibson, F. Giganti, Y. Hu, E. Bonmati, S. Bandula, K. Gurusamy
%et al., "Automatic Multi-Organ Segmentation on Abdominal CT
%with Dense V-Networks," IEEE Transactions on Medical Imaging,
%vol. 37, no. 8, pp. 1822?1834, aug 2018.
%
%[3] O. Ronneberger, P. Fischer, and T. Brox, "U-net: Convolutional
%networks for biomedical image segmentation," in Lecture Notes in
%Computer Science (including subseries Lecture Notes in Artificial
%Intelligence and Lecture Notes in Bioinformatics), vol. 9351.
%
%[4] F. Milletari, N. Navab, and S. A. Ahmadi, "V-Net: Fully convolutional
%neural networks for volumetric medical image segmentation," in
%Proceedings - 2016 4th International Conference on 3D Vision,
%3DV 2016. IEEE, oct 2016, pp. 565?571.
%
%%% Applied ensemble methods are taken from;
%[5] L. I. Kuncheva, Combining Pattern Classifiers: Methods and Algorithms:
% Second Edition. Wiley-Interscience, 2014, vol. 9781118315
%
%%% The evaluation is handled by CHAOS challenge metrics.
% For more information about CHAOS challenge:
% https://chaos.grand-challenge.org/
% https://github.com/emrekavur/CHAOS-evaluation
% --A. Emre Kavur, July 2019

load('deepModelResults.mat') % Load segmentation probability maps for
%CHAOS Set 2 
load('set2Ground.mat') % Load ground truth and parameters of CHAOS Set 2
%(necessary for metric calculations)

allResults=cell(9,4); % Create one cell to store all scores

%% First we evaluate results of individual Deep Models
% 1)DeepMedic
[DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct]=CHAOSMetrics(Vref,(deepMedic>0.5),parameters);
[DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]=convertToScore(DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct);
FinalScore=mean([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]);
allResults{1,1}='DeepMedic';
allResults{1,2}=round([DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct],2);
allResults{1,3}=round([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore],2);
allResults{1,4}=round(FinalScore,2);
clear('DICE_ct', 'RAVD_ct', 'ASSD_ct', 'MSSD_ct','DICE_ctScore', 'RAVD_ctScore', 'ASSD_ctScore', 'MSSD_ctScore');

% 2)Dense-V-Networks
[DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct]=CHAOSMetrics(Vref,(denseVnet>0.5),parameters);
[DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]=convertToScore(DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct);
FinalScore=mean([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]);
allResults{2,1}='Dense-V-Networks';
allResults{2,2}=round([DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct],2);
allResults{2,3}=round([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore],2);
allResults{2,4}=round(FinalScore,2);
clear('DICE_ct', 'RAVD_ct', 'ASSD_ct', 'MSSD_ct','DICE_ctScore', 'RAVD_ctScore', 'ASSD_ctScore', 'MSSD_ctScore');

% 3)U-net
[DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct]=CHAOSMetrics(Vref,(Unet>0.5),parameters);
[DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]=convertToScore(DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct);
FinalScore=mean([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]);
allResults{3,1}='U-net';
allResults{3,2}=round([DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct],2);
allResults{3,3}=round([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore],2);
allResults{3,4}=round(FinalScore,2);
clear('DICE_ct', 'RAVD_ct', 'ASSD_ct', 'MSSD_ct','DICE_ctScore', 'RAVD_ctScore', 'ASSD_ctScore', 'MSSD_ctScore');

% 4)V-net
[DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct]=CHAOSMetrics(Vref,(Vnet>0.5),parameters);
[DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]=convertToScore(DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct);
FinalScore=mean([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]);
allResults{4,1}='V-net';
allResults{4,2}=round([DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct],2);
allResults{4,3}=round([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore],2);
allResults{4,4}=round(FinalScore,2);
clear('DICE_ct', 'RAVD_ct', 'ASSD_ct', 'MSSD_ct','DICE_ctScore', 'RAVD_ctScore', 'ASSD_ctScore', 'MSSD_ctScore');

%% Then we run and evaluate ensemble methods
Pall=cat(4,deepMedic,denseVnet,Vnet,Unet); % Combine all prob. maps into single matrix

% 5)Majority Voting
[Emv,Qmv] = ensembleLibrary(Pall,"majorityVoting");
[DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct]=CHAOSMetrics(Vref,Emv,parameters);
[DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]=convertToScore(DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct);
FinalScore=mean([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]);
allResults{5,1}='Majority Voting';
allResults{5,2}=round([DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct],2);
allResults{5,3}=round([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore],2);
allResults{5,4}=round(FinalScore,2);
clear('DICE_ct', 'RAVD_ct', 'ASSD_ct', 'MSSD_ct','DICE_ctScore', 'RAVD_ctScore', 'ASSD_ctScore', 'MSSD_ctScore');

% 6)Average
[Eavg,Qavg] = ensembleLibrary(Pall,"average");
[DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct]=CHAOSMetrics(Vref,Eavg,parameters);
[DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]=convertToScore(DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct);
FinalScore=mean([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]);
allResults{6,1}='Average Combiner';
allResults{6,2}=round([DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct],2);
allResults{6,3}=round([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore],2);
allResults{6,4}=round(FinalScore,2);
clear('DICE_ct', 'RAVD_ct', 'ASSD_ct', 'MSSD_ct','DICE_ctScore', 'RAVD_ctScore', 'ASSD_ctScore', 'MSSD_ctScore');

% 7)Product
[EprodTerm,QprodTerm] = ensembleLibrary(Pall,"product");
[DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct]=CHAOSMetrics(Vref,EprodTerm,parameters);
[DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]=convertToScore(DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct);
FinalScore=mean([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]);
allResults{7,1}='Product Combiner';
allResults{7,2}=round([DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct],2);
allResults{7,3}=round([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore],2);
allResults{7,4}=round(FinalScore,2);
clear('DICE_ct', 'RAVD_ct', 'ASSD_ct', 'MSSD_ct','DICE_ctScore', 'RAVD_ctScore', 'ASSD_ctScore', 'MSSD_ctScore');

% 8)Minimum 
[Emin,Qmin] = ensembleLibrary(Pall,"min");
[DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct]=CHAOSMetrics(Vref,Emin,parameters);
[DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]=convertToScore(DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct);
FinalScore=mean([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]);
allResults{8,1}='Minimum Combiner';
allResults{8,2}=round([DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct],2);
allResults{8,3}=round([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore],2);
allResults{8,4}=round(FinalScore,2);
clear('DICE_ct', 'RAVD_ct', 'ASSD_ct', 'MSSD_ct','DICE_ctScore', 'RAVD_ctScore', 'ASSD_ctScore', 'MSSD_ctScore');

% 9)Maximum (Note: n binary cases min and max combiner will give same results)
[Emax,Qmax] = ensembleLibrary(Pall,"max");
[DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct]=CHAOSMetrics(Vref,Emax,parameters);
[DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]=convertToScore(DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct);
FinalScore=mean([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore]);
allResults{9,1}='Maximum Combiner';
allResults{9,2}=round([DICE_ct, RAVD_ct, ASSD_ct, MSSD_ct],2);
allResults{9,3}=round([DICE_ctScore, RAVD_ctScore, ASSD_ctScore, MSSD_ctScore],2);
allResults{9,4}=round(FinalScore,2);
clear('DICE_ct', 'RAVD_ct', 'ASSD_ct', 'MSSD_ct','DICE_ctScore', 'RAVD_ctScore', 'ASSD_ctScore', 'MSSD_ctScore');

allResults=[{'Method','Metrics','Scores','Final Score'};allResults];
%% Save results to Excel file (Optional)
% writecell(allResults,'allResults.xlsx')
% disp('Results saved.')