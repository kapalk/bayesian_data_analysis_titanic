# bayesian_data_analysis_titanic
Bayesian data analysis on famous titanic dataset


## Creating pdf

Create the pdf using better-template.tplx

`jupyter nbconvert --template better-template.tplx --to pdf <filename>` 

The standard base.tplx upon which better-template.tplx as well as all the other templates are built on, has only limited latex packages available.
To come around this, we need to modify the base.tplx found in nbconvert/templates/latex/

Find the location of site-packages
 
 `python -m site`

### Modify the _site-packages_/nbconvert/templates/latex/base.tplx

Extend the block ((* block packages *))
```
\usepackage[parfill]{parskip}
\usepackage{float}
\usepackage{listings}
```
