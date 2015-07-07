function [] = PlotEB(StructPath)

load(StructPath)

EB = zeros(length(UVS),1);
MSE = zeros(length(UVS),1);

EB = [UVS(:).EB]';
MSE = [];
for i = 1:length(UVS)
    MSE(i,1) = UVS(i).GMM.MSE;
end

figure
subplot(2,1,1), plot((1:length(UVS)),EB,'ob')
title('Exciton Bandwidth')
xlabel('Run')
ylabel('Exciton Bandwidth (eV)')
subplot(2,1,2), plot((1:length(UVS)),MSE,'*r')
title('Mean Square Error of Gaussian Fits')

end
