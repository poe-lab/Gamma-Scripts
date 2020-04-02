# Gamma-Scripts
All functions and scripts necessary to run gamma scripts

 
Karina Keus 3/10/2020

Instructions for Automatic GAMMA Scorer

Manually score file using traditional Sleep Scorer
- When determining NREM/REM use parietal EEG instead of frontal EEG. Very important for later!
- Run through Brook’s Power Analysis program
- Path: Z drive, Tools, Sleep and memory master, PowerAnalyses folder, SeqPSDvFrequencyAnalysis2015v01.m (updated 10/15/2019 -   the last file)
- Add to path: (not sure if necessary): SharedSubFunctions, SDK_Neuralynx, SleepArchitecture(?)
- An error will pop up saying “scorematic” is an undefined program, please ignore this error message as the program functions   fine without it

Step 1: Gamma Sleep-wake distinction
- In the Power Analysis GUI, upload the timestamp (TS) file, TR manually scored file, and EEG from FRONTAL OB SCREW when       prompted, and set frequency range from 50 - 70 Hz, click run and close gray text box that appears after a few seconds
- Running on a longer file works better, but may take upwards of 15 min or so to run through the power analysis. Do not chunk  file into four-hour segments. Let the power analysis program run until finished and do not disturb.
- When figures appear, close them and navigate to the Sleep Data folder on C:// drive where your PSD file will appear.
- Open PSD file: it will be an excel file with multiple tabs. Navigate to Power Spectra tab with a large matrix. 
- Copy paste all values into a new excel sheet to be edited and saved for later.
- Remove all lettered cells: Delete first row (shift all rows up)
Then, in the first two boxes, turn cells with words into 0’s. Do not shift cells as this will mess with the matrix configuration in matlab, simply replace words with one zero per box AFTER deleting the first row.
- Save as a .csv (comma separated values) file and name as something convenient in a relevant folder.

Step 2: theta-delta 
- Repeat all of Step 1, but run power analysis on PARIETAL SCREW instead of frontal screw (very important!!), set range of frequencies so that it includes 1-10 Hz at least (I typically run the set range up to 60 Hz, but this is not necessary).
- Ensure that this file is not “chunked” either. It MUST be the same length as the frontal EEG recording
- Repeat Step 1 for saving as a .csv file, but make sure to name it so that you know it is a parietal or theta/delta (TD) power analysis file

Step 3: EMG
- Repeat Step 1, but for the “EEG File” upload your EMG recording instead (remember it must be the same length as the other files). Frequency range: 30 - 125 Hz (max range).
- Save as a .csv file in the same manner as the previous steps with appropriate name in appropriate folder.

Run through MasterScript2
- Use MasterScript2: Z drive, tools, sleep and memory master, GAMMA SCRIPTS
- Add your scripts and functions to the path
- Double click “MasterScript2.” In the actual script in the editor, the code will be lines 4 through 19. 
- Where there is purple text (lines 4, 9, and 14), input the names of your files in place of the purple text. KEEP SINGLE QUOTATION MARKS AROUND YOUR FILE NAME. The first purple line is for your PSD gamma range from the frontal screw file, the second is for EMG PSD, and the third is for theta-delta range from the parietal screw PSD file.
- Before running “MasterScript2” make sure to navigate (in the left column of MATLAB) to the folder where you would like your TR file to show up. The MasterScript2 automatically saves a TR excel file to the folder in which you are located when you run the script.
- Click Save, and then Run (green arrow in the top bar of MATLAB). Wait a few minutes, figures and variables will appear.
- A file called TR_file.xls will appear in your current folder on the path. Rename this TR file to something appropriate (example: TR_auto_1694_baseline1.xls).

Check Output (optional)
- Multiple figures will show up. You should be concerned with the ones that have a red line. 
For bimodal distributions (of which there should be two with a red line on a bimodal histogram - one for gamma and one for EMG), the red line should fall at the end of the first peak. If it does, then the algorithm should work. For NREM/REM with the TD ratio, there should be a histogram of a normal distribution with a right skewed tail. The red line should fall at the end of normal peak on the left before the right tail. When comparing to manual scoring, the K values (variables in the right column of MATLAB) should be over 0.7 and the verification ratio values should be over 0.8. Additionally, the figures from the various comparing_thresholds functions (which have titles indicating they are testing K values and agreement values over various thresholds) should have a red line through their peak. This indicates that the algorithm worked well compared to manual scoring.

Sleep Scorer
- After saving the TR file to your folder with an appropriate name, create a Header file. From the manual scoring TR file, there should be another excel file with the exact same name but with “Header” at the end before the .xls. Make a copy of this file and rename it to have the exact same name as your automatic TR file, but with Header at the end before the .xls just like with the manually scored file and its Header file.
- Open sleep scorer, and proceed as normal (same EEG, EMG, and Time stamp (TS) files). All filters and ranges should be the same as you usually use.
- However, use the automatic TR file made by the algorithm for “manually scored file.” In addition, upload the parietal screw EEG as the first “EEG input” and the frontal screw EEG as “Input 3.” When checking the output of the automatic scoring, defer to parietal screw for REM distinction (as the algorithm conducts analysis on this screw due to its proximity to the hippocampus and different parts of the cortex can be in different states simultaneously).



Lastly, please give me your opinions on the functionality of the algorithm! - what states don’t look great, what sort of GUI and accessibility you would like to see. Anything to make it more accurate/precise and easy to use.

Note: The EMG functions are used as a caution to prevent periods of wake characterized as sleep. As a result, periods of sleep may be designated as wake as a precaution. However, if you are more concerned with getting as many periods of sleep as possible, run the MasterScript instead of Masterscript2. MasterScript is located in the “IN PROGRESS” folder (make sure to add to path).

Also: please do not have undergraduates sleep score olfactory bulb recordings to be used in the gamma paper. Please either score them personally or have myself score them. THANK YOU!!!!!
