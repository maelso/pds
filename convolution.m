%% Method to make a convolution of 2 signals
% Using the fft method to do the convolution.
% A: Input signal of size m
% B: Input signal of size m
function Y = convolution(A,B)
    Af = fft(A);
    Bf = fft(B);
    Cf = Af.*Bf;
    Y = ifft(Cf);
end