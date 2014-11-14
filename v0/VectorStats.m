function stats = VectorStats( Labelled )


NDIMS = ndims( Labelled  );


stats.count = accumarray( Labelled( Labelled ~= 0  ), ...
                          ones( sum(Labelled(:) ~= 0), 1), ...
                          [], @sum ); 


for ii = 1 : NDIMS
    [ stats.std(:,ii), stats.center(:,ii) ] = VectorEccentricitydim( Labelled, ii, { @std, @mean } );
end

stats = Stats2Matrix( stats );

end %VectorStats

function varargout = VectorEccentricitydim( Image, dim, op );
%%
% Calculate the eccentricity of a labeled feature in an image.
% 
% op - a cell of function

%% Image Properties
sz = size( Image );
NDIM = numel( sz );


%% Index Pixel Values
ind = [1 : size( Image, dim)]';

axs = circshift( 1 : NDIM, [ 1 dim-1] );

repax = sz;
repax( axs == 1) = 1;


% Pixel values in the dim of interest
dimind = repmat( permute( ind,axs), repax );

%% Vectorized standard deviation

varargout = cell( numel( op ) ,1);

for ii = 1 : numel( op )
    varargout{ii} = accumarray( ...
                    Image(Image~=0), ... Labelled Image
                    dimind(Image~=0), ... Positions in Dimension fo interest
                    [], ...
                    op{ii} );
end



end %VectorEccentricitydim

function stats = Stats2Matrix( stats )
% Augment stats structure with the eccentricity values

ncol = size( stats.std, 2 );

iscell = ncol > 2;
if iscell
     stats.eccentricity = cell(1);
else
     stats.eccentricity = [];
end

ct = 0;
for ii = 1 : ncol
    for jj = ( ii + 1 ): ncol
        ct = ct + 1;
        
        S = sort( stats.std(:,[ ii jj] ) ,2 );
        b = all(S == 0 ,2 );
        if iscell
% This doesn't work yet
%             stats.eccentricity{ ct } = ...
%                 sqrt(1 - ( S(:,1) ./ S(:,2) ).^2); % <<http://en.wikipedia.org/wiki/Eccentricity_(mathematics)#Values>>
%             stats.eccentricity{ct}( b, : ) = 0;
        else
            stats.eccentricity = ...
                sqrt(1 - ( S(:,1) ./ S(:,2) ).^2); % <<http://en.wikipedia.org/wiki/Eccentricity_(mathematics)#Values>>
            stats.eccentricity( b, : ) = 0;
        end %iscell
    end %jj
end %ii
end % Stats2Matrix
%%