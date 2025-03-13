# AAE6102 Assignment 1 
# YAN Xinhao 23125502R

In this assignment, we utilize an open-source Matlab code called GNSS-SDR for the purpose of conducting simulations.
It includes two file folders, namely Common and include, a setting file initSetting.m, and the main function init.m.
We use this open-source code to process two provided source files, i.e., Opensky.bin and Urban.dat.
The results are given as follows.

## Task 1 -- Acquisition

### Settings:

The purpose of acquisition is to identify all satellites visible to the user, as well as the coarse values of carrier Doppler frequency and code phase of satellite signals.
The provided source file Opensky.bin is read by the following form in *initSettings.m*:

<img width="816" alt="image" src="https://github.com/user-attachments/assets/2157a1bf-c167-4da2-8f05-2bd893261d4d" />

Then, we need to set the values of the intermediate frequency (IF) and the sampling frequency. 
Note that the original signal is GPS L1 signal, the IF is 4.58 MHz, and the sampling frequency is 58 MHz.
Hence, we set the above parameters in *initSettings.m* as follows:

<img width="401" alt="image" src="https://github.com/user-attachments/assets/d2f047f4-e5bb-42cb-890e-7b9156050112" />

Due to the Doppler shift, we need to search the frequencies in a certain range. 
Here, we set the search stepsize as 500Hz, which is depicted by the following code in *acquisition.m*:

<img width="416" alt="image" src="https://github.com/user-attachments/assets/f294dd52-fd31-4cca-a318-86fe496e3222" />

Notice that each satellite has its own pseudo-random noise (PRN) code, and the code phase will change due to the transmission. 
Therefore, the parallel frequency space search acquisition with 20 ms stepsize is considered, and the code can be found in *acquisition.m*:

<img width="416" alt="image" src="https://github.com/user-attachments/assets/b0b3bd26-16ec-4c8d-959a-91d9eef8931d" />

In fact, we only search maximum of 32 PRN codes as defined in *initSettings.m*:

<img width="416" alt="image" src="https://github.com/user-attachments/assets/50414983-1aa5-4e6f-a694-e05c6b624a38" />

Before acquisition, the threshold should determined to judge the acquisition metrics, and this parameter is set in *initSettings.m*:

<img width="350" alt="image" src="https://github.com/user-attachments/assets/6e207fbd-82cd-49ca-a2df-30a0c66d81af" />

### Results for Opensky:

First, we give the result for the Opensky source file. 
After running the main function init.m and press 1 to continue, the acquisition result can be obtained. 
The acquisition metrics for every PRN codes are plotted in the following figure.
We can see that there are 5 satellite signals, including 16, 22, 26, 27, and 31, exceed the pre-determined threshold 1.5.
Also, we label the acquired PRN codes green as shown in the figure:



Meanwhile, we also draw the sky plot as follows:



Finally, to summarize, we provide a table to show the complete acquisition results.



### Results for Urban:

On the other hand, the result for the Urban source file can be derived in a similar manner as outlined below. 
In this case, only 4 satellites are identifiable, namely satellite PRN numbers 1, 3, 11, and 18.
The acquisition metric is plotted as

and the sky plot is

The summarized acquisition results for the Urban data can be found in the following table.




