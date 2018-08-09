# light-field-graph-codec

In recent years, light field imaging has attracted the attention of the academic and industrial communities thanks to its enhanced rendering capabilities that allow to visualise contents in a more immersive and interactive way. However, those enhanced capabilities come at the cost of a considerable increase in content size when compared to traditional image and video applications. Thus, advanced compression schemes are needed to efficiently reduce the volume of data for storage and delivery of light field content. In this paper, we introduce a novel method for compression of light field images. The proposed solution uses a graph learning approach to estimate the disparity among the views composing the light field. The graph is then used to reconstruct the entire light field from an arbitrary subset of encoded views. Experimental results show that our method is a promising alternative to current compression algorithms for light field images. In particular, notable gains can be observed across all bitrates with respect to the state of the art.  

The codec is implemented in MATLAB. To run the software, you will need to install the Graph Signal Processing Toolbox:
https://epfl-lts2.github.io/gspbox-html/index.html

If you use this code in your research, please cite our paper:

I. Viola, H. Petric Maretic, P. Frossard and T. Ebrahimi. "A graph learning approach for light field image compression". 2018. SPIE Optical Engineering + Applications, San Diego, California, USA, August 19-23, 2018. 
