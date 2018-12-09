# Motivation

This project demonstrates the use of Bayesian data analysis on the famous titanic dataset. The data for this project was acquired from Vanderbilt Biostatistics dataset collection (http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/titanic.html)

The sinking of the RMS Titanic On April 15, 1912 is a widely known tragedy that took lives of 1502 out of 2224 unlcky passengers and crew. Despite the fact that there was an irremovable element of luck involved in surviving the sinking, some groups of people were more likely to survive than others, such as women, children, and the upper-class. This project aimed to examine these differences in depth. We inteded to create an accurate model for predicting survival probabilities of individuals. We chose survival status as our dependent variable and age, passenger class, sex, and city of embarktion to be our independent variables.

We approached the problem by constructing a logistic regression likelihood model on the chosen explanatory variables. We modelled the posterior distributions for the variables as pooled, as we reasoned that all individuals follow the same distribution for e.g. age altering the survival probability. Our prior selection was weakly informative Student-t distribution, as we chose to let the data speak for itself. 

We were able train a classifier to predict survivors with 0.74 F1 score and found validation for the argument that being young, female and having higher class ticket improved individual's chances to survive. The model predictions are not perfectly accurate which was expected, as the survival included an substantially random element.


![The posterior distribution for regression coefficients](code/figs/betas.png | width=100)

# Run

Run jupyter in the code directory. The notebook contains multiple flags for controlling the running of especially time consuming code blocks. The computed results are cached and provided with the source.

`jupyter notebook`

# Installation

Clone repository
`git clone git@github.com:kapalk/bayesian_data_analysis_titanic.git`

Install updated dependencies

`pip install -r requirements.txt`  

# Requirements

The notebook runs with python 2.7 and 3.6.

# Structure

The data is found from the equally named folder and all the source code is included in the code directory. 'Bayesian Data Analysis - Course project.pdf' contains a report summarizing the results of the study.

# Creating pdf

Create the pdf using better-template.tplx. All credits to Markus Beuckelmann.
source: http://markus-beuckelmann.de/blog/customizing-nbconvert-pdf.html

`jupyter nbconvert --template better-template.tplx --to pdf <filename>` 

The standard base.tplx upon which better-template.tplx as well as all the other templates are built on, has only limited latex packages available.
To come around this, we need to modify the base.tplx found in nbconvert/templates/latex/

Find the location of site-packages
 
 `python -m site`

## Modify the _site-packages_/nbconvert/templates/latex/base.tplx

Extend the block ((* block packages *))
```
\usepackage[parfill]{parskip}
\usepackage{float}
\usepackage{listings}

\makeatletter
\lstdefinestyle{mystyle}{
  basicstyle=%
    \ttfamily
    \color{blue}%
    \lst@ifdisplaystyle\scriptsize\fi
}
\makeatother

\lstset{style=mystyle}

```
