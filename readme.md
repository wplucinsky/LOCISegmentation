# LOCISegmentation
Laboratory for Optical and Computational Instrumentation ([LOCI](https://loci.wisc.edu/)) 

Clathrin Light Chain with Green Fluorescent Protein ([CLC-GFP](http://www.uniprot.org/uniprot/P09496)) Image Segmentation with [Matlab](https://www.mathworks.com/products/matlab.html)

The goal is to programatically determine the boundaries of the clathrin light chains in order to more easily visualize and analyze the images. [LeverJS](http://leverjs.net) is used to track the segmentated areas over time. This is my final project for Drexel's ECES 486 - Cell and Tissue Image Analysis class. A quick presentation can be found [here](https://docs.google.com/presentation/d/14cn0rTEpvzDUGAnEgptr60_lPP5YNSOcTdOhsISTSKY/edit?usp=sharing).

## Processing Methods
- [imsharpen](https://www.mathworks.com/help/images/ref/imsharpen.html)
- [medfilt2](https://www.mathworks.com/help/images/ref/medfilt2.html)
- [imdilate](https://www.mathworks.com/help/images/ref/imdilate.html)
- [bwdist](https://www.mathworks.com/help/images/ref/bwdist.html)
- [watershed](https://www.mathworks.com/help/images/ref/watershed.html)
- [bwboundaries](https://www.mathworks.com/help/images/ref/bwboundaries.html)

## Example Segmentation
Original
![Original](https://github.com/wplucinsky/LOCISegmentation/blob/master/Original.jpg)

Segmented
![Segmented](https://github.com/wplucinsky/LOCISegmentation/blob/master/Segmented.jpg)
