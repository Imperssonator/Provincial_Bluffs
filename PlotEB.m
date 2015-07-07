function [] = PlotEB(StructPath)

load(StructPath)

EB = zeros(length(UVS),1);
SSE = zeros(length(UVS),1);

EB = [UVS(:).EB]';
SSE = [];
for i = 1:length(UVS)
    SSE(i,1) = UVS(i).GMM.SSE;
end

figure
subplot(2,1,1), plot((1:length(UVS)),EB,'ob')
title('Exciton Bandwidth')
xlabel('Run')
ylabel('Exciton Bandwidth (eV)')
subplot(2,1,2), plot((1:length(UVS)),SSE,'*r')
title('Sum Square Error of Gaussian Fits')

end
