
clear();

filename='voice_signal.wav';

%% Upload audio recorded.
[y, Fs] = audioread(filename);
t=[0:1/8000:10];
t=t(1:end-1);
% plot(t,y, 'color', 'red')
% set(gca,'fontsize',14);
% title('Sinal de voz')
% xlabel('Tempo (seg)')
% ylabel('Amplitude')
% sound(y,Fs);


%% Add sinusoid 2kHz, 10 seconds.
f=2000;
t=[0:1/8000:10];
t=t(1:end-1);
noise = sin(2*pi*f*t);

% % Plot sinal completo
% subplot(2,1,1);
% plot(t,noise);
% ylim([-2 2])
% set(gca,'fontsize',14);
% title('Ruído senoidal 2KHz')
% xlabel('Tempo (seg)')
% ylabel('Amplitude')
% 
% % Plot do sinal com zoom.
% subplot(2,1,2);
% plot(t,noise, 'LineWidth', 2);
% ylim([-2 2])
% xlim([0 0.01])
% set(gca,'fontsize',14);
% title('Ruído senoidal 2KHz (Zoom)')
% xlabel('Tempo (seg)')
% ylabel('Amplitude') 



%% Sum of noise and voice]
y_noised = y + noise';
% plot(t, y_noised, 'color', 'red')
% set(gca,'fontsize',14);
% title('Voz com ruído')
% xlabel('Tempo (seg)')
% ylabel('Amplitude')
% sound(y+noise',Fs);

%% Generating filter
n = 0:124;
for i=1:length(n)
    if (n(i)==62)
        H(i)=1.02102/pi;
    else
        numerador = sin(0.325*pi*(n(i)-62));
        denominador = pi*(n(i)-62);
        H(i)= (numerador/denominador)*(0.5 - 0.5*cos((2*pi*n(i))/(124)));
    end    
end

% plot(H,'-', 'LineWidth',2, 'color','black')
% set(gca,'fontsize',14);
% xlim([0 124])
% title('Filtro')
% ylabel('Amplitude')
% xlabel('n')

%% Apply filter with Overlap Add

signal_overlapadd = overlapadd(y_noised',H, 512);
% plot(t,signal_overlapadd(1:80000), 'color', 'red')
% set(gca,'fontsize',14);
% title('Método Sobreposição e Soma')
% xlabel('Tempo (seg)')
% ylabel('Amplitude')
% sound(signal_overlapadd,Fs)
% audiowrite('audio_sobre_soma.wav', signal_overlapadd, 8000);

%% Apply filter with Overlap Save

signal_overlapsave = overlapsave(y_noised',H, 512);
% plot(t,signal_overlapsave(1:80000),'color', 'red')
% set(gca,'fontsize',14);
% title('Método Sobreposição e Armazenamento')
% xlabel('Tempo (seg)')
% ylabel('Amplitude')
% sound(signal_overlapsave,Fs)
% audiowrite('audio_sobre_arm.wav', signal_overlapsave, 8000);

corr(y,signal_overlapsave(1:80000)')

%% Record audio 
% recObj = audiorecorder;
% disp('Start speaking.')
% recordblocking(recObj, 10);
% disp('End of Recording.');
% 
% y = getaudiodata(recObj);
% audiowrite(filename, y, 8000);




