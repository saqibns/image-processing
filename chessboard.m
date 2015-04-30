% The function creats a chessboard with 'size' being the size of each of
% the small squares.
function board = chessboard(size)
    black = uint8(zeros(size));
    white = 255 + uint8(zeros(size));
    bw = cat(2, white, black);
    wb = cat(2, black, white);
    strip1 = [];
    strip2 = [];
    for i = 1:4
        strip1 = cat(2, strip1, bw);
        strip2 = cat(2, strip2, wb);
    end
    
    board = [];
    for i = 1:4
        board = cat(1, board, strip1);
        board = cat(1, board, strip2);
    end
end

        
        