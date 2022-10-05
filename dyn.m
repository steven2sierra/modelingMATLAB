%% collaboration with "sub" file
% Steven Sierra

% stay fresh
clear dyn; 
close all;
clc;

o = [151 149 10]; % initial values for owls
h = [199 201 10]; % intial values for hawks
num = [30 30 26]; % number of days

% cases
for i = 1:3
    a = o(i); % intial owl population that is chosen
    b = h(i); % initial hawk population that is chosen
    c = num(i);
    [finalO,finalH] = sub(a,b,c); 
end



