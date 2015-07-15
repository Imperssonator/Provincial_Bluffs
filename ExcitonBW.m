function [] = ExcitonBW(StructPath)

load(StructPath);

for i = 1:length(UVS)
    Params = UVS(i).GMM.Params;
    P00 = Get00Params(Params); P01 = Get01Params(Params);
    a0 = P00(1);
    a1 = P01(1);
    s0 = P00(3);
    s1 = P01(3);
    ARatio = a0*s1/(a1*s0);
    EBi = 0.018*(1-sqrt(ARatio)) / (0.073*sqrt(ARatio)+0.24);
    UVS(i).EB = EBi;
end

save(StructPath,'UVS')

end

