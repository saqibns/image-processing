function final = gamma_correction(image, gamma, c)
final = c * double(image) .^ gamma;
end