%This library contains formulas for different non-trainable ensemble
%methods. Written by A. Emre~Kavur and Ludmila I.Kuncheva
%July 2019

function [Pcombined, Pobj] = ensembleLibrary(Pall,method,Tf)

switch method
    case "majorityVoting"
        th = ceil(size(Pall,4)/2);
        Pcombined = sum(Pall>0.5,4) > th;        
        Pobj = Pcombined;
        
    case "average"  
        Pobj = mean(Pall,4);
        Pcombined = Pobj > 0.5;
            
    case "product"
        p1 = prod(Pall,4);
        p2 = prod(1-Pall,4);
        Pcombined = p1 > p2;
        Pobj = p1./(p1 + p2);
        
    case "productTerm"                        
        if nargin < 3
            Tf = 0.5; % equal priors
        end
        p1 = prod(Pall,4)/Tf;
        p2 = prod(1-Pall,4)/(1 - Tf);
        Pcombined =  p1 > p2;
        Pobj = p1./(p1 + p2);
        
    case "min"
        p1 = min(Pall,[],4);
        p2 = min(1-Pall,[],4);
        Pcombined = p1 > p2;
        Pobj = p1./(p1 + p2);
        
    case "max"
        p1 = max(Pall,[],4);
        p2 = max(1-Pall,[],4);
        Pcombined = p1 > p2;
        Pobj = p1./(p1 + p2);
        
    otherwise
        disp("Error: Unknown method!")
        Pcombined = [];
end
