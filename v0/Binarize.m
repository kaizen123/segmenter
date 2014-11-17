function Data = Binarize( Data, Thresh );
% Binarize data using a threshold
% negative inverts the algorithm

Data(:) = double( [ sign( Thresh) * Data ] >= Thresh );