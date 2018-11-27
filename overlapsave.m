%% Main Code
clear();

% % Pulso retangular de 3000 pontos centrado em zero.
% add 72 samples.
% n=-1499:1500;
% A=rectangularPulse(-750,750,n);
% subplot(2,1,1)
% plot(n,A,'-o');
% axis([-1500 1500 -0.5 1.5])
% title('A');
% 
% % Pulso retangular de 220 pontos centrado em zero.
% n=-109:110;
% B=rectangularPulse(-55,55,n);
% subplot(2,1,2)
% plot(n,B,'-o');
% axis([-110 110 -0.5 1.5])
% title('B');
% 
% result = OverlapSave(A,B,512);
% plot(result, '-b' ,'LineWidth',2);
% set(gca,'fontsize',14);
% title('Convolução de A e B por Sopreposição e Armazenamento');

%% Method overlap and add for convolution calculation
% A: Input Sequence to be convoluated.
% B: Input Sequence to be convoluated.
% N_DFT: Number of points of the DFT.
function Y = OverlapSave(A, B, N_DFT)
    
    AL = length(A);
    M = length(B);    
    Y = [];
    
    % Adjust A to be divisible per N_DFT.
    remainder = rem(AL, N_DFT);
    
    A = [A zeros(1, N_DFT - remainder)];
    AL = length(A);
    
    B = [B zeros(1, N_DFT-1)];
    Y=[];
    al=zeros(1,N_DFT+M-1);
    for k = 1 : N_DFT : AL  
        al = [al(end-(M-2):end) A(k : k + N_DFT -1)];
        conv = convolution(al, B);     
        Y = [Y conv(M-1:end)];       
    end     
end


