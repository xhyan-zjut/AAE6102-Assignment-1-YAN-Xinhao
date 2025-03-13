# AAE6102-Assignment-1-YAN-Xinhao

In this assignment, we use the open-source code GNSS-SDR with Matlab for simulation. The main function is init.m, and the parameter adjustment can be found in initSetting.m.

## Task 1 -- Acquisition

### Settings:

The purpose of acquisition is to identify all satellites visible to the user, and coarse values of carrier Doppler frequency and code phase of the satellite signals.
The provided source file Opensky.bin is read by the following form in *initSettings.m*:

<img width="816" alt="image" src="https://github.com/user-attachments/assets/2157a1bf-c167-4da2-8f05-2bd893261d4d" />

Then, we need to set the intermediate frequency (IF) and sampling frequency. Note that the original signal is GPS L1 signal, and the IF is 4.58 MHz, sampling frequency is 58 MHz, thus we set the above parameters in initSettings.m as follows:

<img width="401" alt="image" src="https://github.com/user-attachments/assets/d2f047f4-e5bb-42cb-890e-7b9156050112" />

Due to the Doppler shift, we need to search the frequencies in a certain range. Here, we set the search stepsize as 500Hz, which can be described by the following code in acquisition.m:

<img width="416" alt="image" src="https://github.com/user-attachments/assets/f294dd52-fd31-4cca-a318-86fe496e3222" />

Notice that each satellite has its own pseudo-random noise (PRN) code, and the code phase will change due to the transmission. Hence, we use parallel frequency space search acquisition with 20 ms stepsize in acquisition.m to find the code

<img width="416" alt="image" src="https://github.com/user-attachments/assets/b0b3bd26-16ec-4c8d-959a-91d9eef8931d" />

Here, we only search 32 PRN codes as defined in initSettings.m:

<img width="416" alt="image" src="https://github.com/user-attachments/assets/50414983-1aa5-4e6f-a694-e05c6b624a38" />


Before acquisition, Then, the threshold is determined before the acquisition in initSettings.m:

<img width="350" alt="image" src="https://github.com/user-attachments/assets/6e207fbd-82cd-49ca-a2df-30a0c66d81af" />



### Results for Opensky:

First, we run the result for the Opensky source file. After running the init.m, the acquisition result can be obtained. The acquisition metrics are plotted in the following figure. We can see that there are 5 satellite signals, including 16, 22, 26, 27, and 31, exceed the threshold 1.5, where we label them green:

Meanwhile, the sky plot is also given:

To summarize, the acquisition results is given by the following table.


Results for Urban:
On the other hand, the result for Urban source file can be similarly obtained as follows. Here, only 4 satellites can be found, including 1, 3, ,11, and 13. The acquisition metric is plotted as

and the sky plot is

The summarized acquisition results for the Urban data can be found in the following table.




