function final = apply_sobel_operators(image)
    sobel_x = [-1 -2 -1; 0 0 0; 1 2 1];
    sobel_y = [-1 0 1; -2 0 2; -1 0 1];
    
    gx = generic_filter(image, sobel_x);
    gy = generic_filter(image, sobel_y);
    
    final = abs(gx) + abs(gy);
    
end

function filtered = generic_filter(image, filter)

    filter_size = size(filter);
    f_size = filter_size(1);
    strips = int8((f_size - 1) / 2);
    padded = pad(image, strips);
    strips = double(strips);
    % Apply the generic filter onto the image
    clone = zeros(size(image));
    [rows, cols] = size(padded);
        for i = strips + 1 : rows - strips
            for j = strips + 1 : cols - strips
                % Convolution
                value = 0.0;
                for k = -strips : strips
                    for l = -strips : strips
                        value = value + int16(padded(i + k, j + l)) * int16(filter(k + strips + 1, l + strips + 1));
                       
                    end
                end
                clone(i - strips, j - strips) = value;
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