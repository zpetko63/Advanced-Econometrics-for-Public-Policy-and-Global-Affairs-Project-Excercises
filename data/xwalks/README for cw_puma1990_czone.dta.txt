README for crosswalk file cw_puma1990_czone.dta
David Dorn

Notes:
Create a variable "puma1990" whose first two digits are the state FIPS code and whose last four digits are the PUMA code within a state. Use the Stata command "joinby" to combine the Census microdata with the crosswalk file using the variable "puma1990". The variable "afactor" in the crosswalk indicates which fraction of a PUMA's population maps to a given CZ. To analyze weighted Census data, the person weight from the Census needs to be multiplied with "afactor".

Please cite as source for this file:
David Autor and David Dorn. "The Growth of Low Skill Service Jobs and the Polarization of the U.S. Labor Market." American Economic Review, 103(5), 1553-1597, 2013.