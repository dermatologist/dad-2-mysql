# dad-2-mysql

ETL script for loading Discharge Abstract Database (DAD) on to MySQL prior to data mining.

Discharge Abstract Database (DAD) is a Canada-wide database of hospital admission and discharge data, maintained by Canadian Institute for Health Information (CIHI).

Please note that this repository only contains the scripts for processing DAD, not the data. Data is available for researchers from [Odesi](https://search2.odesi.ca/#/)

## Disclaimer
*Parts of this material are based on the Canadian Institute for Health Information Discharge Abstract Database Research Analytic Files (sampled from fiscal years 2014-15). However the analysis, conclusions, opinions and statements expressed herein are those of the author(s) and not those of the Canadian Institute for Health Information.*

## How to use:

* Download DAD csv file to same folder as this script.
 If you have the SPSS file, use the freeware [PSPP](https://www.gnu.org/software/pspp/) to convert to csv

* pip install -r requirements.txt

* create database using the provided dad.sql file

* Add database settings and filename in settings.py

* python dad2mysql.py 

## Author

Bell Eapen (McMaster U)
