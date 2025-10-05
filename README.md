# UKRegionsMap
This repository provides R scripts and spatial data for mapping results by UK region. It allows the creation of consistent maps for analyses, reports, or publications that require regional visualisation across England, Scotland, Wales, and Northern Ireland.

## Contents
- `createMap.R`: main script to generate maps by UK region  
- `regions_map/`: maps for regions within England  
- `countries_map/`: maps for England, Scotland, Wales, and Northern Ireland  
- `ireland_map/`: maps for the Republic of Ireland (in case the full island of Ireland needs to be shown, not just Northern Ireland)  
- `UKRegionsMap.Rproj`: RStudio project file

## Usage
To use the repository, first clone or download it to your computer.  
Open the R project (`UKRegionsMap.Rproj`) in RStudio, or set your working directory to the local copy (not to the original repository).  
Run the main script `createMap.R` to generate the maps by UK region. The script reads the geometry files from the `regions_map`, `countries_map`, and `ireland_map` folders, combines them as needed, and produces visualisations of the UK by region based on the data you provide or upload.  
Maps are saved in the current working directory unless you specify a different path in the script.

## Requirements
Required packages: `sf`, `dplyr`, `ggplot2`, and `here`

## Licence
Released under the Apache 2.0 licence.

