"""
Provides utility functions for creating figures and tables.
"""
import pandas as pd

def create_fit_table(fit, dest, filter=[]):
    """
    Create a publication ready latex table of StanFit4model

    The table can be included in the notebook with 

    \begin{table}
        \caption{Table caption}
        \input{dest}
    \end{table}

    Params:
        fit (StanFit4model)    
        dest (str)                name of the file to save the table
        filter (list[str]):       names of the keys to include.
        
    Returns:
        pd.DataFrame
    """
    
    summary = fit.summary()
    df = pd.DataFrame(summary['summary'],
                        index=summary['summary_rownames'],
                        columns=summary['summary_colnames'])
    if filter:
        df = df.loc[filter]
        
    with open(dest, 'w') as f:
        f.write(df.to_latex())
        
    return df
