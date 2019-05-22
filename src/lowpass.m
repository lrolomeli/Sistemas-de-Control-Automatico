N   = 133;        % FIR filter order
Fp  = 4e3;       % 20 kHz passband-edge frequency
Fs  = 10e3;       % 96 kHz sampling frequency
Rp  = 0.00057565; % Corresponds to 0.01 dB peak-to-peak ripple
Rst = 1e-4;       % Corresponds to 80 dB stopband attenuation

eqnum = firceqrip(N,Fp/(Fs/2),[Rp Rst],'passedge'); % eqnum = vec of coeffs
fvtool(eqnum,'Fs',Fs,'Color','White') % Visualize filter

%%

N2 = 200; % Change filter order from 100 to 200
eqNum200 = firceqrip(N2,Fp/(Fs/2),[Rp Rst],'passedge');
fvt = fvtool(eqnum,1,eqNum200,1,'Fs',Fs,'Color','White');
legend(fvt,'FIR filter; Order = 100','FIR filter. Order = 200')


%%
Fst = 5e3;  % Transition Width = Fst - Fp
numMinOrder = firgr('minorder',[0,Fp/(Fs/2),Fst/(Fs/2),1],[1 1 0 0],...
    [Rp Rst]);
fvt = fvtool(eqnum,1,eqNum200,1,numMinOrder,1,'Fs',Fs,'Color','White');
legend(fvt,'FIR filter; Order = 100','FIR filter. Order = 200',...
    'FIR filter. Order = 133')

%%

lowpassFIR = dsp.FIRFilter('Numerator',numMinOrder); %or eqNum200 or numMinOrder
fvtool(lowpassFIR,'Fs',Fs,'Color','White')