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

ImageR = double(rgb2gray( imread('https://farm4.staticflickr.com/3847/15062861898_3cbc927301_z.jpg') ) ) ./ 255; 
% ImageR(:) = bwlabeln( Binarize( ImageR, 155 ) );

ImageI = bwlabel( Binarize( ImageR, .5) );
%% Single Label

stats2 = VectorStats( Image2 );
stats3 = VectorStats( Image3 );
statsR = VectorStats(  );

%%

PlotVectorStats( Image2, stats2 )
figure(gcf)

%%

PlotVectorStats( ImageI, statsR )
figure(gcf)

%% Reproduce Nils's Results
% reproduce cleanerupper.m

I = ImageR;
cuts = [ 40 : 60 ] * 0.01;
s = size( I );
tmp = zeros( s );

layermem = 5;

sortlayer = zeros( [ s , ...
    layermem, ... Memory in the sorted layers
    3 ... The number of modes 
    ] );

IDmat = zeros(s);

% Layer one dim 4 - eccentricity
% Layer two dim 4 - angle
% Layer two dim 4 - threshold

for cut = cuts;
    
    labelled = bwlabeln( Binarize( ImageR, cut(1) ), 8 ... 8-node connectivity
                                                       );

    disp( sum( logical( labelled(:))))
    stats = VectorStats( labelled );
    
    % Remove unwanted labels
    labelled( ...
        ismember( labelled, ... 
            find( stats.count < 250 | stats.count > 20000 ) ) ... Identify low and high count labels
        ) = 0 ; % Set them to zero
    
    % Find the places where fibers exist
    b = logical( labelled );
    
    % initlize temporal
    tmp(:) = 0;
    
    % Sort the eccentricities
    tmp(b) = stats.eccentricity( labelled(b) ) + 1; % Add one for sort, a circle has an eccentricity of zero and is counted for
    % Subtract 1 at the end
    
    % Sort the eccentiricties and output the indices
    [ stmp, si ] = sort( ...
        cat( 3, tmp, sortlayer(:,:,:,1) ), ...
            3 );
        
    stmp( si == 1 & stmp ~=0 ) = stmp( si == 1 & stmp ~=0 ) - 1;
    % Update eccentricities in the sorted matrix
    sortlayer(:,:,:,1) = stmp( :, :, 2 : ( layermem + 1) );

    % Update angles based on sorting
    tmp(:) = 0;
    tmp(b) = stats.angle( labelled(b) );
    stmp(:) = cat( 3, tmp, sortlayer(:,:,:,2) );
    
    % Reorder the angles
    stmp(:) = stmp(  bsxfun( ...
                        @plus, ...
                        [ 1 : prod(s) ]' ,  ....
                        reshape( si - 1, prod(s), [] ) * prod( s ) ...
                   ) );
    
    sortlayer(:,:,:,2) = stmp( :, :, 2 : ( layermem + 1));
    
    tmp(:) = 0;
    tmp(b) = b(b) * cut(1);
    stmp = cat( 3, tmp, sortlayer(:,:,:,3) );
    
    % Reorder the angles
    stmp(:) = stmp(  bsxfun( ...
                        @plus, ...
                        [ 1 : prod(s) ]' ,  ....
                        reshape( si - 1, prod(s), [] ) * prod( s ) ...
                   ) );
    
    sortlayer(:,:,:,3) = stmp( :, :, 2 : ( layermem + 1) );

end

sortlayer(:) = flipdim( sortlayer, 3 );
