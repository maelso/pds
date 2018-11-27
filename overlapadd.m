% % Main code.
% 
clear();
% 
% Entrada A - Pulso retangular de 3000 pontos centrado em zero.
n=-1499:1500;
A=rectangularPulse(-750,750,n);
% plot(n,A,'LineWidth',2);
% set(gca,'fontsize',14);
% axis([-1500 1500 -0.5 1.5])
% title('Sinal A');

% Entrada B - Pulso retangular de 220 pontos centrado em zero.
n=-109:110;
B=rectangularPulse(-55,55,n);
% plot(n,B,'LineWidth',2);
% set(gca,'fontsize',14);
% axis([-110 110 -0.5 1.5])
% title('Sinal B');


plot(conv(A,B))
result = OverlapAdd(A,B,512);
plot(result, 'LineWidth',2);
set(gca,'fontsize',14);
title('Convolução de A e B por Sopreposição e Soma');

%% Method overlap and add for convolution calculation
% A: Input Sequence to be convoluated.
% B: Input Sequence to be convoluated.
% N_DFT: Number of points of the DFT.
function Y = OverlapAdd(A, B, N_DFT)
    
    AL = length(A);
    M = length(B);    
    Y = [];
    
    % Adjust A to be divisible per N_DFT.
    remainder = rem(AL,N_DFT);
    
    A = [A zeros(1, N_DFT - remainder)];
    AL = length(A);
    
    B = [B zeros(1, N_DFT-1)];            
    Y = zeros(1,AL+M-1);
    
    i=0;
    for k = 1 : N_DFT : AL        
        al = [A(k : k+N_DFT-1) zeros(1,M-1)];
        conv = convolution(al,B);    
        Y = Y + [zeros(1, i*N_DFT) conv  zeros(1, (AL+M-1)-(i*N_DFT)-length(conv))];                     
        i=i+1;        
    end     
end


