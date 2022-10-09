
%% Function
function [O,H,item_Cell,item_Cell2,item_Cell3,item_Cell4] = sub_oz(OO,HH,N)

%% Initialization

% counter
count = 5;

% preallocation of space ( k3 ) 
O = zeros(N,count);
H = zeros(N,count);

%% Constants, K

%% K1
k1 = 0.2; % growth rate of owls
%{
    For the variation case, k1 will be named m1
%}
m1 = zeros(N,count);
m1(:,1) = 0.2;
for ll = 1:count
    m1(:,ll+1) = m1(:,ll) + 0.1;
end

%% K2
k2 = 0.3; % growth rate of hawks
%{
    For the variation case, k2 will be named m2
%}
m2 = zeros(N,count);
m2(:,1) = 0.3;
for xx = 1:count
   m2(:,xx+1) = m2(:,xx) + 0.1; 
end


%% K3
k3 = 0.001; % competitive effect - owls
%{
    For the variation case, k3 will be named m3
%}
m3 = zeros(N,count);
m3(:,1) = 0.001;
for kk = 1:count
    m3(:,kk+1) = m3(:,kk) + 0.001;
end

%% K4
k4 = 0.002; % competitive effect - hawks
%{
    For this case, k4 will be named m4
%}
m4 = zeros(N,count);
m4(:,1) = 0.002;
for ww = 1:count
   m4(:,ww+1) = m4(:,ww) + 0.001; 
end

%% Iteration


% Original, no variations

O5 = zeros(N,1);
H5 = zeros(N,1);

O5(1) = OO;
H5(1) = HH;

for v = 1:N
   O5(v+1) = (1 + k1) * O5(v) - k3 * ( O5(v) * H5(v) );
   H5(v+1) = (1 + k2) * H5(v) - k4 * ( O5(v) * H5(v) );
end

% variations of k1

% preallocation of space
O3 = zeros(N,count);
H3 = zeros(N,count);

for c = 1:N
   % initialize vector for each iteration
   O3(1,:) = OO;
   H3(1,:) = HH;
   % Varying k1 ( m1 )
   for d = 1:count
        O3(c+1,d) = (1 + m1(c,d) ) * O3(c) - k3 * ( O3(c) * H3(c) );
        H3(c+1,d) = (1 + k2) * H3(c) - k4 * ( O3(c) * H3(c) );         
   end 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% variations of k2

% preallocation of space
O4 = zeros(N,count);
H4 = zeros(N,count);

for g = 1:N 
   % initialize vector for each iteration    
    O4(1,:) = OO;
    H4(1,:) = HH;
    % Varying k2 ( m2 )
    for h = 1:count
        O4(g+1,h) = (1 + k1) * O4(g) - k3 * ( O4(g) * H4(g) );
        H4(g+1,h) = (1 + m2(g,h) ) * H4(g) - k4 * ( O4(g) * H4(g) );         
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
    k3 was observed first, so preallocation of space already done above...
%}


% k3 variations
for i = 1:N
   % initialize vector for each iteration
    O(1,:) = OO;
    H(1,:) = HH;
    % Varying k3 ( m3 )    
    for j = 1:count
        O(i+1,j) = (1 + k1) * O(i) - m3(i,j) * ( O(i) * H(i) );
        H(i+1,j) = (1 + k2) * H(i) - k4 * ( O(i) * H(i) );
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% preallocation of space
O2 = zeros(N,count);
H2 = zeros(N,count);

% k4 variations
for a = 1:N
    % initialize vector for each iteration
    O2(1,:) = OO;
    H2(1,:) = HH;
    % Varying k4 ( m4 )
    for b = 1:count
        O2(a+1,b) = (1 + k1) * O2(a) - k3 * ( O2(a) * H2(a) );
        H2(a+1,b) = (1 + k2) * H2(a) - m4(a,b) * ( O2(a) * H2(a) );      
    end
end

%% CELL ARRAYS

%% K1 and K2 variations

%% K1 Cell Array
% intialize cell array
item_Cell3 = cell(1,count);

% hold each owl vector from iteration
for cc = 1:count
    item_Cell3{cc} = O3(:,cc);
end

%% K2 Cell Array
% intialize cell array
item_Cell4 = cell(1,count);

% hold each hawk vector from iteration
for dd = 1:count
    item_Cell4{dd} = H4(:,dd);
end


%% K3 and K4 variations

%% K3 Cell Array
% initialize cell array
item_Cell = cell(1,count);
   
% hold each owl vector from iteration
for ii = 1:count
    item_Cell{ii} = O(:,ii);
end

%% K4 Cell Array
% intialize cell array
item_Cell2 = cell(1,count);

% hold each hawk vector from iteration
for jj = 1:count
    item_Cell2{jj} = H2(:,jj);
end

%% Color
% figure
bb = hsv(8);
hold on;

%% Figures

% variation of k1 plots

for tt = 1:count
   figure(1)
   subplot(2,3,tt);
   hold on;
   plot(item_Cell3{tt},'o','color',bb(tt,:),'MarkerFaceColor',bb(tt,:),'DisplayName','Variation of K1')
   % original data
   plot(O5,'-bo','DisplayName','Original Owl Data'); 
   plot(H5,'-mo','DisplayName','Original Hawk Data');
   
   xlabel('Time (days)')
   ylabel('Population') 
   set(gca,'FontSize',12)
   title('Variations: Growth Rate of Owls')
   
   % legend
   lgd = legend;
   lgd.NumColumns = 1;
   legend('Location','northwest')
end

% variation of k2 plots

for ss = 1:count
   figure(2)
   subplot(2,3,ss);
   hold on;
   plot(item_Cell4{ss},'o','color',bb(ss,:),'MarkerFaceColor',bb(ss,:),'DisplayName','Variation of K2')
   
   % original data
   plot(O5,'-bo','DisplayName','Original Owl Data'); 
   plot(H5,'-mo','DisplayName','Original Hawk Data');
   
   xlabel('Time (days)')
   ylabel('Population') 
   set(gca,'FontSize',12)
   title('Variations: Growth Rate of Hawks')
 
   % legend
   lgd = legend;
   lgd.NumColumns = 1;
   legend('Location','northwest')
end

% variation of k3 plots

for qq = 1:count
   figure(3)
   subplot(2,3,qq);
   hold on;
   plot(item_Cell{qq},'o','color',bb(qq,:),'MarkerFaceColor',bb(qq,:),'DisplayName','Variation of K3')
   
   % original data
   plot(O5,'-bo','DisplayName','Original Owl Data'); 
   plot(H5,'-mo','DisplayName','Original Hawk Data');
   
   xlabel('Time (days)')
   ylabel('Population') 
   set(gca,'FontSize',12)
   title('Variations: Competitive Effect for Owls')

   % legend
   lgd = legend;
   lgd.NumColumns = 1;
   legend('Location','northwest')
end

% variation of k4 plots

for rr = 1:count
   figure(4)
   subplot(2,3,rr);
   hold on;
   plot(item_Cell2{rr},'o','color',bb(rr,:),'MarkerFaceColor',bb(rr,:),'DisplayName','Variation of K4')
   
   % original data
   plot(O5,'-bo','DisplayName','Original Owl Data'); 
   plot(H5,'-mo','DisplayName','Original Hawk Data');
  
   xlabel('Time (days)')
   ylabel('Population') 
   set(gca,'FontSize',12)
   title('Variations: Competitive Effect for Hawks')
   
   % legend
   lgd = legend;
   lgd.NumColumns = 1;
   legend('Location','northwest')
end

%% Diary

diary off; 

end
    