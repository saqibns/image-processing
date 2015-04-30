function final = median_filter(image)
    final = generic_filter2(image, 3);
end

function filtered = generic_filter2(image, neighbourhood_size)

    f_size = neighbourhood_size;
    strips = int8((f_size - 1) / 2);
    padded = pad(image, strips);
    strips = double(strips);
    % Apply the generic filter onto the image
    clone = zeros(size(image));
    [rows, cols] = size(padded);
        for i = strips + 1 : rows - strips
            for j = strips + 1 : cols - strips
                % Extraction
                window = padded(i - 1 : i + 1, j - 1 : j + 1);
                clone(i - strips, j - strips) = calculate_median(window);
            end
        end
     filtered = uint8(clone);
end

function padded_image = pad(image, layers)
    [rows, cols] = size(image);
    padded_image = image;
    for i = 1:layers
        padded_image = cat(1, padded_image, uint8(zeros(1, cols)));
        padded_image = cat(1, uint8(zeros(1, cols)), padded_image);
        padded_image = cat(2, padded_image, uint8(zeros(rows  + 2, 1)));
        padded_image = cat(2, uint8(zeros(rows + 2, 1)), padded_image);
        rows = rows + 2;
        cols = cols + 2;
    end
end

function med = calculate_median(matrix)
    [rows, cols] = size(matrix);
    med = uint8(median(double(reshape(matrix, rows * cols, 1))));
end