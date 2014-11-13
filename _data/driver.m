% Download and Image from the web and fit the phases

url = 'https://farm6.staticflickr.com/5572/15062860448_0ff498a9bb_s.jpg';
out = segmentprob( mean(double( imread(url) ), 3), ... A 2-D (could be 3-D) image, average the RGB channels
    51, ... Number of bins in the histogram
    4 ...  Number of peaks of phases to find
    );
