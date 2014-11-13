function param = segmentprob( I, nhist, npeak )
%%
% I is a signal or image with distinct phases.  
% nhist - number of histogram bins
% npeak - number of peaks to find in the histogram

nd = ndims( I );
sz = size(I);

if ~exist( 'nhist','var') || numel(nhist) == 0
    nhist = 101;
end
if ~exist( 'npeak','var') || numel(nhist) == 0
    nhist = 3;
end

param = struct( 'hist',  struct( 'n', nhist, ...
                                 'pixel',[], ...
                                 'cdf',[], ...
                                 'intensity', [] ), ...
                'peak', struct( 'n', npeak, ... 
                                 'info', [] ), ...
                'out', struct( 'ci', zeros( sz ), ...
                               'phase', zeros( sz ) ) );

%%

normalize = @(A)( A-min(A(:)) ) ./ ( max(A(:)) - min(A(:)) );
adjust = @(A)reshape(  ... back to original shape
                imadjust( ... adjust image
                        reshape( ... flatten to 2-D image
                                normalize(A), ... normalize from zero to one
                                size(A,1), numel(A)./size(A,1))), ... Reshape to 2-D array
                                size(A) ... Reshape back to original size
                                );


%% 

I(:) = normalize(I);
I(:) = adjust(I);
                            
%% Histogram for Signal

[ param.hist.intensity, ...
    param.hist.pixel ] = hist( I(:), param.hist.n );


param.hist.cdf = cumsum( param.hist.intensity )./sum( param.hist.intensity );

%% Fit peak
% Fit the peak with the default Gaussian fit.
% No initial Guesses

p = peakfit( param.hist.intensity(:)', 0, 0, param.peak.n );

% peak index - peak center - peak 
param.peak.center = interp1( 1: param.hist.n, param.hist.pixel, p(:,2) );

[ param.peak.area, ...
  param.peak.fwhm, ...
  param.peak.intensity ] = deal( p(:,3), p(:,4), p(:,5 ) );
    
D = bsxfun( @minus, I,  permute( param.peak.center , ...
                                    circshift( 1 : ( nd+1), [1 -1]) ) ).^2;
D(:) = 2 .* bsxfun( @rdivide, D, permute( param.peak.center , ...
                                    circshift( 1 : ( nd+1), [1 -1]) ) );
                                
D(:) = exp(-1.*D.^2);

% How do I actualy compute the confidence index
[ param.out.ci, param.out.phase ] = max( D, [], nd + 1 );

%%

if all(size(I) > 1) & ndims( I ) == 2
figure;
sp = [ 3 1];


% subplot(sp(1),sp(2),1)
% pcolor( I ); ; title('Original')
% subplot(sp(1),sp(2),2)
% pcolor( param.out.phase ); title('Phase')
% subplot(sp(1),sp(2),3)
% pcolor( param.out.ci ); title('Relative Confidence')

imtool(I)
imtool(param.out.phase)
imtool(param.out.ci)


for ii = 1 : 3
    ax(ii) = subplot(sp(1),sp(2),ii);
    axis equal; axis tight
    shading flat;
    colorbar
end

linkaxes( ax );

figure(gcf-1);
end