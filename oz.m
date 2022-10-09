%% Stay Fresh
clear oz;
close all;
clc;

%% Initial conditions

% Case 
OO = 151; % owl population
HH = 199; % hawk population
N = 29; % number of days - 1

%% Calling Function

[O,H,item_Cell,item_Cell2,item_Cell3,item_Cell4] = sub_oz(OO,HH,N);
