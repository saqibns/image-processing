% Find the threshold of a grayscale image.
function final = threshold(image, threshold_value, levels)
[rows, cols] = size(image);
final = uint8(zeros(rows, cols));
for i = 1:rows
    for j = 1:cols
        if image(i, j) >= threshold_value
            final(i, j) = levels - 1;
        else
            final(i, j) = 0;
        end
    end
end
end