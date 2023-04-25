#!/bin/bash

filenametime=$(date +"%m%d%Y%H%M%S")

export BASE_FOLDER='/home/omar/labs/lab1'
export INPUTS_FOLDER=${BASE_FOLDER}'/input'
export OUTPUTS_FOLDER=${BASE_FOLDER}'/output'
export LOGS_FOLDER=${BASE_FOLDER}'/logs'
export SHELL_SCRIPT_NAME='lab1'
export LOG_FILE=${LOGS_FOLDER}/${SHELL_SCRIPT_NAME}_${filenametime}.log

exec > >(tee ${LOG_FILE} 2>&1)

echo "starting sh file"

for year in {2020..2022};
do
    wget --content-disposition "https://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=48549&Year=${year}&Month=2&Day=14&timeframe=1&submit=Download+Data" -O ${INPUTS_FOLDER}/${year}.csv
done;

RC1=$?
if [ ${RC1} != 0 ]; then
	echo "\n[ERROR:] ERROR FOR SH SCRIPT"
	echo "[ERROR:] RETURN CODE:  ${RC1}"
	echo "[ERROR:] REFER TO THE LOG FOR THE REASON FOR THE FAILURE."
	exit 1
fi

echo "Success downloading data. Running Python Script Now"

# Concatenate downloaded CSV files using Python script
python3 /home/omar/labs/lab1/lab1.py

RC1=$?
if [ ${RC1} != 0 ]; then
        echo "\n[ERROR:] ERROR FOR PYTHON SCRIPT"
        echo "[ERROR:] RETURN CODE:  ${RC1}"
        echo "[ERROR:] REFER TO THE LOG FOR THE REASON FOR THE FAILURE."
        exit 1
fi

echo "Success"

exit 0
