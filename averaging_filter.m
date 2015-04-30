function averaged = averaging_filter(image)
    filter = (1 / 9) + zeros(3);
    averaged = generic_filter(image, filter);
end

function filtered = generic_filter(image, filter)

    filter_size = size(filter);
    f_size = filter_size(1);
    strips = int8((f_size - 1) / 2);
    padded = pad(image, strips);
    strips = double(strips);
    % Apply the generic filter onto the image
    clone = image;
    [rows, cols] = size(padded);
    count = 0;
        for i = strips + 1 : rows - strips
            for j = strips + 1 : cols - strips
                % Convolution
                count = count + 1;
                value = 0.0;
                for k = -strips : strips
                    for l = -strips : strips
                        value = value + padded(i + k, j + l) * filter(k + strips + 1, l + strips + 1);
                    end
                end
                clone(i - strips, j - strips) = value;
            end
            
        end
     filtered = clone;
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