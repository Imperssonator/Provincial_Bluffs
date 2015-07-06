function [] = ExcitonBW(StructPath)

load(StructPath);

for i = 1:length(UVS)
    Params = UVS(i).GMM.Params;
    a0 = Params(1,3);
    a1 = Params(1,2);
    s0 = Params(3,3);
    s1 = Params(3,2);
    ARatio = a0*s1/(a1*s0);
    EBi = 0.018*(1-sqrt(ARatio)) / 0.3173;
    UVS(i).EB = EBi;
end

save(StructPath,'UVS')

end

