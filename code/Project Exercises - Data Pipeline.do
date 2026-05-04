**** Final Project Exercises - Zach Petko
***** MGA 60211 / MDSC 40211 / ECON 40502: Advanced Econometrics
***** Spring 2026
***** ================================================================

clear all
set more off

global pathmain "G:\My Drive\Advanced Econometrics for Public Policy and Global Affairs\Advanced Econometrics for Public Policy and Global Affairs Project Excercises"    // <- Set your working directory
global path_data "./data"    
cd "${pathmain}"

cap log close
log using "final_project_exercises.log", replace text

eststo clear

*** ================================================================
*** Data Pipeline
*** ================================================================

foreach year in 1970 1980 1990 2000 2010 {
	
    * 1. Load in IPUMS data 
    use "$path_data/raw/ipums_usa_`year'.dta", clear
		
    * 2. Restrict sample 
    drop if inlist(STATEFIP, 2, 15) // drop AK and HI
    drop if inlist(GQ, 0, 3, 4) // drop group quarters /
    drop if AGE < 16 // age restriction

    * 3. Set geography and allocation factors by decade 
    if `year' == 1970 {
        gen cty_grp70 = CNTYGP97
        local xkey  "cty_grp70" // name in the xwalk file
        local xwalk "cw_ctygrp1970_czone_corr.dta" 
        local afac  "afact"
    }
    else if `year' == 1980 {
        gen ctygrp1980 = 1000*STATEFIP + CNTYGP98
        local xkey  "ctygrp1980"
        local xwalk "cw_ctygrp1980_czone_corr.dta"
        local afac  "afactor"
    }
    else if `year' == 1990 {
        gen puma1990 = 10000*STATEFIP + PUMA
        local xkey  "puma1990"
        local xwalk "cw_puma1990_czone.dta"
        local afac  "afactor"
    }
	else {
        gen puma2000 = 10000*STATEFIP + PUMA
        local xkey  "puma2000"
        local xwalk "cw_puma2000_czone.dta"
        local afac  "afactor"
    }
	
    * 4. Convert to commuting zones 
    joinby `xkey' using "$path_data/xwalks/`xwalk'"
    gen aperwt = `afac' * PERWT
	
    * 5. Classify by origin
    gen bpld = BPLD
	merge m:1 bpld using "$path_data/raw/cw_bpld_kmp.dta", keep(3) nogenerate
    drop if kmp_ctry == 82 // Drop 'other' origins
	
    * 6. Construct wages (Midpoints required per instructions) 
    * Recode weeks depending on decade
    if `year' == 1970 | `year' == 2010 {
        recode WKSWORK2 (1=7) (2=20) (3=33) (4=43.5) (5=48.5) (6=51), gen(weeks)
    }
    else {
        gen weeks = WKSWORK1 
    }
    * Recode hours
    if `year' == 1970 {
        recode HRSWORK2 (1=7.5) (2=22) (3=32) (4=37) (5=40) (6=44.5) (7=54) (8=60), gen(hours)
    }
    else {
        gen hours = UHRSWORK
    }
    
    gen hourly_wage = INCWAGE / (hours * weeks)
    drop if hourly_wage <= 0 | hourly_wage == .
	
    * 7. Collapse to CZ x Origin
    collapse (rawsum) pop=aperwt (mean) wage=hourly_wage [pw=aperwt], by(czone kmp_ctry YEAR)
	
    * 8. Save data
    save "$path_data/clean/cz_o_`year'.dta", replace
}


