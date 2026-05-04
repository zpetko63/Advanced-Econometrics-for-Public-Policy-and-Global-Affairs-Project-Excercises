README for crosswalk file cw_ctygrp1970_czone.dta
David Dorn

Notes:
Use the Stata command "joinby" to combine the Census microdata with the crosswalk file using the county group variable (renamed to "cty_grp70" in the crosswalk file). The variable "afactor" in the crosswalk indicates which fraction of a county group's population maps to a given CZ. To analyze weighted Census data, the person weight from the Census needs to be multiplied with "afactor".

Please cite as source for this file:
David Autor and David Dorn. "The Growth of Low Skill Service Jobs and the Polarization of the U.S. Labor Market." American Economic Review, 103(5), 1553-1597, 2013.