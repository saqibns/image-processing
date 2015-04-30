function interpolated = pixel_replication_interpolation(image, factor)
    [rows, cols] = size(image);
    interpolated = [];
    intermediate = [];
    for i = 1:cols
        col_vector = image(:, i);
        for dummy = 1:factor
            intermediate = cat(2, intermediate, col_vector);
        end
    end
    
    for j = 1:rows
        row_vector = intermediate(j, :);
        for dummy = 1:factor
            interpolated = cat(1, interpolated, row_vector);
        end
    end
end