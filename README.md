# Gamma-Scripts
All functions and scripts necessary to run gamma scripts

 
Karina Keus 3/10/2020

Instructions for Automatic GAMMA Scorer

A COMPLETE COPY OF THE INSTRUCTIONS (INCLUDING FOR RUNNING POWER ANALYSIS IS ON THE GOOGLE DRIVE FOLDER. THE FOLLOWING ONLY APPLIES TO THE EXAMPLE FILES THAT HAVE ALREADY UNDERGONE POWER ANALYSIS.
- Use MasterScript2 on Baseline1 sample (already loaded in MasterScript2), and MasterScript for SEFL3 and 6FE.

Run through MasterScript2
- Add your scripts and functions to the path
- Double click “MasterScript2.” In the actual script in the editor, the code will be lines 4 through 19. 
- Where there is purple text (lines 4, 9, and 14), input the names of your files in place of the purple text. KEEP SINGLE QUOTATION MARKS AROUND YOUR FILE NAME. The first purple line is for your PSD gamma range from the frontal screw file, the second is for EMG PSD, and the third is for theta-delta range from the parietal screw PSD file. The current version of MasterScript2 has example files already written into the code (Baseline 1). You can swap these out with the files from other folders on the Drive, including SEFL3 and 6FE (except use MasterScript instead of MasterScript2).
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


Note: The EMG functions are used as a caution to prevent periods of wake characterized as sleep. As a result, periods of sleep may be designated as wake as a precaution. However, if you are more concerned with getting as many periods of sleep as possible, run the MasterScript instead of Masterscript2.

