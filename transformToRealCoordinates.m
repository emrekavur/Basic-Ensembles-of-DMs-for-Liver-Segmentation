% This is modified version of the original code which gets parameters from
% saved file. If you are looking for the original code, you may visit:
% https://github.com/emrekavur/CHAOS-evaluation
% Written by Ali Emre Kavur, emrekavur@gmail.com
% Last update: 07/09/2019

function [realPoints]=transformToRealCoordinates(indexPoints,parameters)

T1=parameters.T1;
TN=parameters.TN;
N=parameters.N;
X=parameters.X;
Y=parameters.Y;
deltaI=parameters.deltaI;
deltaJ=parameters.deltaJ;

M=[X(1)*deltaI,Y(1)*deltaJ,(T1(1)-TN(1))/(1-N),T1(1);...
    X(2)*deltaI,Y(2)*deltaJ,(T1(2)-TN(2))/(1-N),T1(2);...
    X(3)*deltaI,Y(3)*deltaJ,(T1(3)-TN(3))/(1-N),T1(3);...
    0,0,0,1];

realPoints=zeros(size(indexPoints,1),size(indexPoints,2));
for i=1:size(indexPoints,1)
    P=M*[indexPoints(i,1),indexPoints(i,2),indexPoints(i,3),1]';
    realPoints(i,:)=P(1:3)';
end
