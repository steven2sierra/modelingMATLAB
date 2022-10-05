%% math modeling exercise

%% Stay fresh
clear sandHillCranes;
close all;
clc

%% (a)
%{
    (a)
        p0 = 100 % initial population
        r = 1.0194 % growth rate
        i = 1:20 % first 20 years
        build a dynamical system, v_pn (a vector)
%}

num = 20; % first 20 years

% extra
% n, number of years
% n = zeros(num,1);
% for k = 1:num
%   n(k+1) = n(k) + 1;
% end

p0 = 100;
r = 1.0194; % (1)p0 + (0.0194)p0 = 1.0194, growth rate
v_pn = zeros(num,1); % preallocation of space
v_pn(1) = p0; % set initial condition

% Begin for loop - (a)
for i = 1:num
    v_pn(i+1) = ((r)^(i)) * (p0);
end

% Display the resulting vector of the dynamical system of (a)
% disp(v_pn);

% Plot of (a) - Figure 1
figure(1)
plot(v_pn,'bo-','MarkerFaceColor','b');
title('Figure 1');
xlabel('Time (years)');
ylabel('Population Size');
% legend('Data','Location','northwest');

%% (b)
%{
    (b) 
        p0 = 100;
        r2 = 0.9676, (1)p0 + (-0.0324)p0
        j = 1:20 % first 20 years
        estimate number of years it will take for population
        to become extinct
%}

r2 = 0.9676; % growth rate
v_pn2 = zeros(num,1); % preallocation of space
v_pn2(1) = p0;

% Begin the for loop - (b)
for j = 1:num
    v_pn2(j+1) = ((r2)^(j)) * (p0);
end

% Plot of (b) - Figure 2
figure(2)
plot(v_pn2,'ro-','MarkerFaceColor','r');
title('Figure 2');
xlabel('Time (years)');
ylabel('Population Size');
% legend('Data 2','Location','northeast');

%% (c) and (d)
r3 = 0.9676; % growth rate
count = 5; %  counter: iterate for one bird, two bird, etc.
iter = 1; 
num2 = 200;
v_pn3 = zeros(num2+1,iter); % matrix for case iter = 1,2,3,4,5

% for loop for (c) and (d)
for a = 1:num2
    v_pn3(1,:) = p0;
    
    for b = 1:iter:count
            v_pn3(a+1,b) = ( ((r3)^(a)) * (p0) ) + b;
    end
end

item_c_Cell = cell(1,count); % placement of vectors

% hold each vector from iteration
for ii = 1:iter:count
        item_c_Cell{ii} = v_pn3(:,ii);
end

% Plot of (c) and (d)

% Figure 3

% adding five birds annually
figure(3);
plot(item_c_Cell{5},'-o','LineWidth',1,'MarkerSize',5,'color','m','MarkerFaceColor','m');
title('Figure 3');
xlabel('Time (years)');
ylabel('Population Size');
hold on;
legend(['Birds added: ',num2str(5)],'Location','northeast');

% Color data points
cc = hsv(8);
hold on;

% Figure 4
figure(4);
for mm = 1:count
plot(item_c_Cell{mm},'o-','LineWidth',1,'MarkerSize',5,'color',cc(mm,:),'MarkerFaceColor',cc(mm,:));
title('Figure 4');
xlabel('Time (years)');
ylabel('Population Size');
hold on;
end

% Legend for Figure 4
Legend = cell(count,1);
for hh = 1:count
   Legend{hh} = strcat('Birds added: ', num2str(hh));
end

legend(Legend);

%% Tables - see command window

% (a) and (b)
% n, for use in cell array
n = zeros(num,1);
for k = 1:num
    n(k+1) = n(k) + 1;
end

% (c) and (d)

% n2, for use in cell array
n2 = zeros(num2,1);
for k = 1:num2
    n2(k+1) = n2(k) + 1;
end

% Display v_pn and v_pn2 in command window

C = [n,v_pn,v_pn2];
% convert array to a table
T = array2table(C,...
    "VariableNames",["n" "Population A" "Population B"]);
disp(T); % display table

% Display v_pn3 in command window

D = [n2,v_pn3];
U = array2table(D,...
    "VariableNames",["n" "One Bird" "Two Birds","Three Birds", "Four Birds","Five Birds"]);
disp(U); % display table

%% Diary - command window output to text file

% diary sandHillCranes
diary off