clc
clear
close all


load mat/timerz.mat

lw = 4;
ms = 30;
fs = 30;



figure 
hold on;
box on;
grid on;
plot(Ms, timez_A(2, :), 'b>-', 'LineWidth', lw, 'MarkerSize', ms);%kr
plot(Ms, timez_A(3, :), 'k^-', 'LineWidth', lw, 'MarkerSize', ms);%kr
plot(Ms, timez_A(4, :), 'cp-', 'LineWidth', lw, 'MarkerSize', ms);%kr
plot(Ms, timez_A(5, :), 'gs-', 'LineWidth', lw, 'MarkerSize', ms);%kr
axis tight;
legend('CoSamp', 'OMP', 'AKRON', 'L1', 'Location', 'best');
xlabel('n', 'FontSize', fs);
ylabel('time', 'FontSize', fs);
set(gca, 'fontsize', fs);


