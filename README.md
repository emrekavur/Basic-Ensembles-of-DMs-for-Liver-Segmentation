
# Basic Ensembles of Deep Learning Models for Liver Segmentation from CT Images
This repo contains a sample script for the ensemble methods explained in "Basic Ensembles of Deep Learning Models for Liver Segmentation from CT Images" article. For detailed explanations, please refer to the article. 

The codes were written in MATLAB language. `ensemleDeepModels_MAIN.m` is the main script that users need to execute. There are evaluation of four individual segmentation methods and implentation of five different ensemble methods as well as their evaluations in the script. Data is provided from [CHAOS challenge dataset](https://zenodo.org/record/3367758),  CT Set 2.

Besides of all files in this repo, it is necessary to download [deepModelResults.mat](https://yadi.sk/d/ff6Tld0jcbrz2g) (143 MB) from provided link. This file stores probability maps coming from four individual Deep Models for *CHAOS CT Set 2*. These models are:

1. K. Kamnitsas, E. Ferrante, S. Parisot, C. Ledig, A. V. Nori, A. Criminisi et al., “DeepMedic for brain tumor segmentation,” in Lecture Notes in Computer Science, vol. 10154 LNCS. Springer, Cham, oct 2016, pp. 138–149. http://link.springer.com/10.1007/978-3-319-55524-9 14

2. E. Gibson, F. Giganti, Y. Hu, E. Bonmati, S. Bandula, K. Gurusamy et al., “Automatic Multi-Organ Segmentation on Abdominal CT with Dense V-Networks,” IEEE Transactions on Medical Imaging, vol. 37, no. 8, pp. 1822–1834, aug 2018. https://ieeexplore.ieee.org/document/8291609/

3. O. Ronneberger, P. Fischer, and T. Brox, “U-net: Convolutional networks for biomedical image segmentation,” in Lecture Notes in Computer Science, vol. 9351.
Springer, Cham, 2015, pp. 234–241. http://link.springer.com/10.1007/978-3-319-24574-4 28

4. F. Milletari, N. Navab, and S. A. Ahmadi, “V-Net: Fully convolutional neural networks for volumetric medical image segmentation,” in Proceedings - 2016 4th International Conference on 3D Vision, 3DV 2016. IEEE, oct 2016, pp. 565–571. 
http://ieeexplore.ieee.org/document/7785132/

Applied ensemble methods are taken from:
- Ludmila I. Kuncheva, Combining Pattern Classifiers: Methods and Algorithms:
Second Edition. Wiley-Interscience, 2014, ISBN:0471210781, vol. 9781118315. https://onlinelibrary.wiley.com/doi/book/10.1002/9781118914564

The evaluation is handled by CHAOS challenge metrics. For more information about ;
- CHAOS Challenge: https://chaos.grand-challenge.org/ 
- CHAOS Evaluation Code: https://github.com/emrekavur/CHAOS-evaluation 
- CHAOS Dataset: https://zenodo.org/record/3367758

