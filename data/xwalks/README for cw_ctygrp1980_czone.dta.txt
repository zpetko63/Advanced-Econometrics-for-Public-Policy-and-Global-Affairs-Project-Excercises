README for crosswalk file cw_ctygrp1980_czone.dta
David Dorn

Notes:
Adjust variable "ctygrp1980" such that the first two digits are the state FIPS code and the last three digits are the county group code within a state from the Census 5% sample (in Stata: "replace ctygrp1980=1000*statefip+ctygrp1980"). Then use the Stata command "joinby" to combine the Census microdata with the crosswalk file using the state code-augmented variable "ctygrp1980". The variable "afactor" in the crosswalk indicates which fraction of a county group's population maps to a given CZ. To analyze weighted Census data, the person weight from the Census needs to be multiplied with "afactor".

Please cite as source for this data file:
David Autor and David Dorn. "The Growth of Low Skill Service Jobs and the Polarization of the U.S. Labor Market." American Economic Review, 103(5), 1553-1597, 2013.