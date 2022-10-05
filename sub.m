%% subroutine file
% Steven Sierra 

function [finalO,finalH] = sub(a,b,c)

n = c; % number of days, our iteration counter

% constants
k1 = 0.2;
k2 = 0.3;
k3 = 0.001;
k4 = 0.002;

% owls
vec_oN = zeros(n,1); % preallocation of space 
vec_oN(1) = a; % initial value for vector


% hawks
vec_hN = zeros(n,1); % preallocation of space
vec_hN(1) = b; % intial value for vector

% for loop
for i = 1:n
    
    vec_oN(i+1) = (1+k1) * vec_oN(i) - k3 * ( vec_oN(i) * vec_hN(i) );
    vec_hN(i+1) = (1+k2) * vec_hN(i) - k4 * ( vec_oN(i) * vec_hN(i) );
    
    finalO = vec_oN(n); % number of owls on day n
    finalH = vec_hN(n); % number of hawks on day n 
    
    % check 
    
    if finalO < 1 && finalH > 1
       % owls extinct, hawks that remain
       disp("Owls are extinct.")
       formatH = 'Remaining hawks after %d days: %.3f \n \n';
       fprintf(formatH,n,finalH);
       break
       
    elseif finalH < 1 && finalO > 1
        % hawks extinct, owls that remain
        disp("Hawks are extinct.");
        formatO = 'Remaining owls after %d days: %.3f \n \n';
        fprintf(formatO,n,finalO);
        break
        
    elseif finalH > 1 && finalO > 1
        % number of owls and hawks that remain
        formatO = 'Remaining owls after %d days: %.3f \n';
        formatH = 'Remaining hawks after %d days: %.3f \n \n';
        fprintf(formatO,n,finalO);
        fprintf(formatH,n,finalH);
        break
    
    end
end % fin of for loop

end % fin of function




