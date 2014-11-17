%% Datasets

%% Flickr set
% From:: http://imperssonator.github.io/MIC-OFET-Processing/2014/09/17/Initial-Issues.html
seturl = 'https://www.flickr.com/photos/127699624@N02/sets/72157647191955619'

photos = loadjson( '_data/ofet-set.json')

%% Construct Flickr from Set Request

%           id: '15062861898'
%       secret: '3cbc927301'
%       server: '3847'
%         farm: 4
%        title: '10%_2min'
%    isprimary: 0
%     ispublic: 1
%     isfriend: 0
%     isfamily: 0


res = 'z';
[ farm, server, id, secret] = deal( ...
        photos.photoset.photo{3}.('farm'), ...
        photos.photoset.photo{3}.('server'),...
        photos.photoset.photo{3}.('id'), ...
        photos.photoset.photo{3}.('secret') ...
        );

photourl = sprintf( 'https://farm%i.staticflickr.com/%s/%s_%s_%s.jpg', ...
            farm, server, id, secret, res );

%%

if false
 img = imread( photourl );
else
  load( '_data/sampleimage.mat' );
  lclimg = '_data/sampleimage.jpg';
  % The lclimg is used to test the original code
end

%% Test Nils's Code

[ A B C] = cleanFull_Seg2( lclimg );