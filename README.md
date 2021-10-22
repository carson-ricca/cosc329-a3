# COSC 329 - Assignment 3

There are two main files to be aware of in order to run the project `main.py` and `a3.m`. All CSVs that are outputted
from `main.py` are in the `data/output/` directory. The `process_data.py` and `time_range.py` both provide helper
functions intended for processing of the raw data files. `install_bnt.m` is used to install `BNT` into matlab, when
matlab is first started.

## CPTs

All CPTs with their respective value are in `cpts.pdf`. These are where the values returned from processing, and other
CPT values exist. These CPTs values are used in the matlab script.

## Running the Project

To run the project follow the steps below:
> 1. Ensure matlab is running.
> 2. Ensure you are in the root directory of the project.
> 3. In matlab run the `install_bnt.m` script.
> 4. From the project's root directory run `python main.py`, this will process the raw data, and create the CSVs in `data/output` if they don't already exist.
> 5. In matlab run the `a3.m` script to generate the Bayesian Network and perform inference.