"""
Provides utility functions for creating figures and tables.
"""
import pandas as pd
from functools import reduce

def create_tex_table(df, dest, decimals=2, index=True):
    """
    Create a .tex table from pandas.DataFrame
    """
    with open(dest, 'w') as f:
        f.write(df.round(decimals).to_latex(index=index))

def create_fit_table(fit, dest=None, filter=[], decimals=2):
    """
    Create a publication ready latex table of StanFit4model

    The table can be included in the notebook with 

    \begin{table}
        \caption{Table caption}
        \input{dest}
    \end{table}

    Params:
        fit (StanFit4model)    
        dest (str)                Name of the file to save the table. None for not to save
        filter (list[str]):       Names of the keys to include.
        
    Returns:
        pd.DataFrame
    """
    
    summary = fit.summary()
    df = pd.DataFrame(summary['summary'],
                        index=summary['summary_rownames'],
                        columns=summary['summary_colnames'])
    if filter:
        df = df.loc[filter]
        
    if dest is not None:
        create_tex_table(df, dest, decimals)
        
    return df.round(decimals)

# Filters

def count_matches(seq, match):
    return reduce(lambda agg, p: agg + 1 if p == match else agg, seq, 0)

def no_info(seq):
    return seq.isnull().sum()

def tot(seq):
    return len(seq)

def females(passengers):
    return count_matches(passengers, "female") 

def males(passengers):
    return count_matches(passengers, "male")

def Queenstown(passengers):
    return count_matches(passengers, "Queenstown")

def Cherbourg(passengers):
    return count_matches(passengers, "Cherbourg")

def Southampton(passengers):
    return count_matches(passengers, "Southampton")
