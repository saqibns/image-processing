% The script applies an averaging filter on a grayscale image.
function averaged = averag(image, sizze)
[rows, cols] = size(image);
averaged = uint8(zeros(rows ,cols));
limit = int16(sizze / 2) - 1;
points = sizze * sizze;
image = pad_image(image, limit);
for i = (limit + 1):(rows + limit)
    for j = (limit + 1):(cols + limit)
        g = helper(image, i, j, limit, points);
        averaged(i - 1, j - 1) = g;
    end
end
end

function a = helper(image, x, y, limit, sample_points)
summation = 0.0;
tmp = [];
for i = (-limit):limit
    for j = (-limit):limit
        %i
        %j
        summation = summation + image(i + x, j + y);
        %tmp = cat(1, tmp, [image(i + x, j + y)]);
    end
end
a = uint8(summation / sample_points);
end

function padded = pad_image(image, limit)
for i = 1:limit
    [rows, cols] = size(image);
    image = cat(2, image, zeros(rows, 1));
    image = cat(2, zeros(rows, 1), image);
    image = cat(1, image, zeros(1, cols + 2));
    image = cat(1, zeros(1, cols + 2), image);
end
padded = image;
end