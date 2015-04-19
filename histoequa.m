% The function performs histogram equalization on a grayscale image.
function [equalized] = histoequa(levels, img)
[dim1, dim2] = size(img);
nk = zeros(1, levels);
for i = 1:dim1
    for j = 1:dim2
        nk(img(i, j) + 1) = nk(img(i, j) + 1) + 1;
    end
end
intensity = helper(levels, nk , dim1, dim2);
equalized = uint8(zeros(dim1, dim2));
for i = 1:dim1
    for j = 1:dim2
        equalized(i, j) = intensity(img(i, j)); 
    end
end
end




function [intensity] = helper(levels, nk, dim1, dim2)
pr = zeros(1, levels);
ps = zeros(1, levels);
sk = zeros(1, levels);
sum = 0;
for i = 1:levels
    pr(i) = nk(i) / (dim1 * dim2);
    sum = sum + pr(i) * (levels - 1);
    sk(i) = sum;
end
intensity = round(sk);
for i = 1:levels
    ps(intensity(i) + 1 ) = ps(intensity(i) + 1) + pr(i);
end
end
