# Advanced Econometrics Project Exercises: Shift Share IV on Immigration and Local Wages

## Project Overview
This project investigates the impact of immigration on the wages of native-born workers across U.S. labor markets. Using a **Bartik Shift-Share Instrumental Variable** design, this research replicates and extends the work of **Kim, Merritt, and Peri (2024)** to isolate the supply-side effect of immigration.

The primary challenge in this research is the endogeneity of immigrant location choices: immigrants typically settle in booming regions where wages are already rising. This project addresses that bias by using historical settlement patterns (1970) to predict contemporary immigration flows, independent of current local economic shocks.

## Methodology
The analysis employs a **Shift-Share (Bartik) Instrument** constructed as follows:
1. **Historical Shares:** Calculates the 1970 distribution of immigrants by country of origin across U.S. Commuting Zones (CZs).
2. **Shift:** Multiplies these historical shares by the total national growth of immigration from each country in subsequent decades.
3. **Normalization:** Normalizes the predicted inflow by the CZ’s 1970 total population to ensure the instrument is uncorrelated with contemporary local labor demand shocks.

## Data Pipeline
The analysis utilizes five decades of US Census data (1970–2010) sourced from **IPUMS USA**. 

- **Unit of Analysis:** 722 Commuting Zones (CZs) representing local labor markets.
- **Harmonization:** Crosswalks Census geographies (PUMAs/Counties) to 1990 Commuting Zone definitions.
- **Variable Construction:** Estimates hourly wages by dividing annual earnings by weeks worked and hours per week, adjusted for inflation.
- **Aggregation:** Data is collapsed to the CZ-by-origin level for each decade (1970, 1980, 1990, 2000, 2010).

**Note:** The raw data files are not in this repository since they are too large for GitHub to store.

## Key Findings
The results demonstrate a significant divergence between OLS and IV estimates, highlighting the importance of the instrumental variable approach:

| Specification | Coefficient (Effect on Wage) | Significance |
| :--- | :--- | :--- |
| **OLS** | 3.246 | *** (p < 0.001) |
| **IV (2SLS)** | -1.370 | Not Significant |

- **Interpretation:** The positive OLS estimate reflects the fact that immigrants sort into high-wage/high-growth markets. 
- **Conclusion:** Once this sorting is controlled for via the Shift
