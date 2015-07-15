function [] = PlotEB(StructPath)

load(StructPath)

EB = zeros(length(UVS),1);
SSE = zeros(length(UVS),1);

EB = [UVS(:).EB]';
GMEB = [UVS(:).GMEB]';
SSE = [];
for i = 1:length(UVS)
    Res = UVS(i).FCFit.Res;
    SSE(i,1) = sum(Res.^2);
end

figure
subplot(2,1,1), plot((1:length(UVS)),EB,'ob',(1:length(UVS)),GMEB,'oc')
title('Exciton Bandwidth')
xlabel('Run')
ylabel('Exciton Bandwidth (eV)')
subplot(2,1,2), plot((1:length(UVS)),SSE,'*r')
title('Sum Square Error of Gaussian Fits')

end
