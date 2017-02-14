Fma = [0.7; 0.01];
Fma = [Fma; 1- Fma];
Fja = [0.90; 0.05];
Fja = [Fja; 1-Fja];


Fjma = [repmat(Fja(1:2),2,1); repmat(Fja(3:4),2,1)].*repmat(Fma,2,1);

Fma = sum(reshape(Fjma,4,2),2);
Fabe = [0.95; 0.94; 0.29; 0.001];
Fabe = [Fabe; 1- Fabe];
temp = zeros(16,1);
for i = 1 : numel(Fma)
    temp((i-1)*4+(1:4)) = repmat(Fma(i),4,1);
end
Fma = temp;
Fabe = repmat(Fabe,2,1);
Fmabe = Fma.*Fabe;
temp = zeros(8,1);
for i = 1: 4
    temp(i) = Fmabe(i)+Fmabe(i+4);
end
for i = 9:12
    temp(i-4) = Fmabe(i)+Fmabe(i+4);
end
Fmbe = temp;
Fe = [0.002; 1-0.002];
Fe = repmat(Fe,4,1);

Fmbe = Fmbe.*Fe;
Fmb = zeros(4,1);
for i = 1: 4
    Fmb(i) = sum(Fmbe((i-1)*2+(1:2)));
end

Fb = [0.001; 1-0.001];
Fb = repmat(Fb,2,1);
Fmb = Fmb.*Fb;
Fm = zeros(2,1);
for i = 1: 2
    Fm(i) = sum(Fmb((i-1)*2+(1:2)));
end

