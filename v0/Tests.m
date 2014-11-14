%% Test Environ

d = 10;
cut = 5;

%% 2-D Image

[ X, Y ] = meshgrid( -d:d );
D = sqrt( X.^2 + Y.^2 );

Image2 = Binarize( D, -cut );

%% 3-D Image

[ X, Y, Z ] = meshgrid( -d:d );
D = sqrt( X.^2 + Y.^2 + Z.^2 );

Image3 = Binarize( D, -cut );

%% Real Data

ImageR = mean( ...
        double( ...
            imread('https://farm4.staticflickr.com/3847/15062861898_3cbc927301_z.jpg') ), ...
    3)';

ImageR(:) = bwlabeln( Binarize( ImageR, 155 ) );

%% Single Label

stats2 = VectorStats( Image2 );
stats3 = VectorStats( Image3 );
statsR = VectorStats( ImageR );

%%

PlotVectorStats( Image2, stats2 )
figure(gcf)

%%

PlotVectorStats( ImageR, statsR )
figure(gcf)

%%