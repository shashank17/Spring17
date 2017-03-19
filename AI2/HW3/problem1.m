Fd = [0.2; 0.8];
Fi = [0.1; 0.9];
Fgid = [0.1; 0.2; 0.3; 0.4];
FGid = [Fgid; 1-Fgid];

FGid = FGid.* repmat(Fd,4,1);
Fig = zeros(4,1);
for i = 1:4
    Fig(i) = sum(FGid(i*2-1:i*2));
end
