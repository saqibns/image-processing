function filtered = ideal_lowpass_filter(image, d0)
    [rows, cols] = size(image);
    r2 = rows / 2;
    c2 = cols / 2;
    f_transform = fft2(image);
    filter = zeros(size(image));
    for i = 1:rows
        for j = 1:cols
            duv = (((i - r2) ^ 2) + ((j - c2) ^ 2)) ^ 0.5;
            if duv > d0
                filter(i, j) = 0;
            else
                filter(i, j) = 1;
            end
        end
    end
    
    filtered = abs(ifft2(f_transform .* filter));
end