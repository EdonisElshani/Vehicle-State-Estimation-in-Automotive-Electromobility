%% Recursive Least Squares Function with exponential Forgetting Factor (RLSeF)

% function of recusive least squared with forgetting factor
% based on algorithmic pseudocode of RLSeF deviation from literature [7] (page 281-283)
function [theta_new, P_new] = fcn(phi, y, lambda, theta_old, P_old)
    % calculation of residual between measured system output and model
    % output
    e = y-phi'*theta_old;
    % calculating new correction factor
    gamma = (P_old*phi)/(lambda+phi'*P_old*phi);
    % calculation of new parameter theta estimation
    theta_new = theta_old+gamma*e;
    % calculation of new information matrix P
    P_new = (1-gamma*phi')*P_old/lambda;
end

%% Initialisation

% Time steps
N = 200;
% Defining Lambda
lambda1 = 1;
lambda2 = 0.95;
% Definition of real value of theta
theta_true = 0.5;
% measured system phi which is used for least squares calculation of theta
phi_all = randn(1, N);

% Noise of System Output y
% If no noise -> 
% noise = 0;
noise = 0.05*randn(1, N);
% calculating system output y with noise
y = theta_true*phi_all+noise;

% Initialisation of theta estimated for calculation with lambda 1
theta_est_1 = zeros(1, N); 
% Initialisation of information matrix phi^T*phi for calculation with lambda 1
P1 = 1000; 
% Initialisation of old estimated theta: theta[k-1] for calculation with
% lambda 1
theta_old_1 = 0;
% Initialisation of theta estimated for calculation with lambda 2
theta_est_2 = zeros(1, N); 
% Initialisation of information matrix phi^T*phi for calculation with lambda 2
P2 = 1000; 
% Initialisation of old estimated theta: theta[k-1] for calculation with
% lambda 2
theta_old_2 = 0;

%% RLS Simulation
for k = 1:N

    % call RLSeF function for Lambda 1
    [theta_new_1, P1] = fcn(phi_all(k), y(k), lambda1, theta_old_1, P1);
    % store new estimated theta in variable theta_est_1 for lambda 1
    theta_est_1(k) = theta_new_1;
    % replace old theta with new theta for next iteration step (lambda 1)
    theta_old_1 = theta_new_1;

    % call RLSeF function for Lambda 1
    [theta_new_2, P2] = fcn(phi_all(k), y(k), lambda2, theta_old_2, P2);
    % store new estimated theta in variable theta_est_1 for lambda 2
    theta_est_2(k) = theta_new_2;
    % replace old theta with new theta for next iteration step (lambda 2)
    theta_old_2 = theta_new_2;
end

%% Plot
figure;
% plot estimated theta for N timesteps
% calculation of lambda 1
plot(1:N, theta_est_1, 'b', 'LineWidth', 1); 
hold on;
% plot estimated theta for N timesteps
% calculation of lambda 2
plot(1:N, theta_est_2, 'r', 'LineWidth', 1);
% plot real theta
yline(theta_true, 'k--', 'LineWidth', 2);
% label x and y axis
xlabel('Time steps'); 
ylabel('\theta estimated');
% define title
title('Recursive Least Squares (Noisy Output y)');
% creating legend of plot funcation with 2 estimated theta and real theta 
legend(['\lambda = ' num2str(lambda1)],['\lambda = ' num2str(lambda2)],'\theta');
grid on;