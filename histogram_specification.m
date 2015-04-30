function specified = histogram_specification(image, levels)
    [rows, cols] = size(image);
    specified = uint16(zeros(rows, cols));
    for i = 1:rows
        for j = 1:cols
            specified(i, j) = mapping(image(i, j), levels);
        end
    end
end


%The function to which the histogram is to be matched
function mapped = mapping(value, levels)
    mapped = power((levels - 1) * value, 1 / 3);
end