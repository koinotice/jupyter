# Data Science Image Docker

This image was created from base-notebook and minimal-notebook by Jupyter Project (docker-stacks) 

## Using

[notebooks]: full path, not relative path

$ docker run -it --rm -p 8888:8888 -v [notebooks]:/opt/app/data cristianounix/datascience

Ex:

$ docker run -it --rm -p 8888:8888 -v /home/cristianounix/notebooks:/opt/app/data cristianounix:datascience

![Docker run cristianounix/datascience](https://github.com/cristianounix/docker-datascience/raw/master/images/docker-run-terminal.jpg "Docker run cristianounix/datascience")


![Jupyterlab](https://github.com/cristianounix/docker-datascience/raw/master/images/jupyterlab.jpg "Jupyter lab")


## Libs


### Python

+ scikit-learn
+ numpy
+ pandas
+ scipy
+ matplotlib
+ nltk
+ ipywidgets
+ seaborn
+ spacy
+ cv2

### R

+ r-irkernel
+ r-plyr
+ r-devtools
+ r-tidyverse
+ r-shiny
+ r-rmarkdown
+ r-forecast
+ r-rsqlite
+ r-reshape2
+ r-nycflights13
+ r-caret
+ r-rcurl
+ r-crayon
+ r-randomforest
+ r-htmltools
+ r-sparklyr
+ r-htmlwidgets
+ r-hexbin


