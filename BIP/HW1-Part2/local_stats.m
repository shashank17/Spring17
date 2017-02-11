function [ meanI, meanP, varI, covIP ] = local_stats( I, P, w)
% Finds the local statistics of the given images

    meanI = local_mean(I, w);
    meanP = local_mean(P, w);
    corrI = local_mean(I.*I, w);
    corrIP = local_mean(I.*P, w);
    varI = corrI - (meanI.*meanI);
    covIP = corrIP - (meanI.*meanP);
end

