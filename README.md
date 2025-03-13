# AAE6102 Assignment 1 YAN Xinhao 23125502R

In this assignment, we utilize an open-source Matlab code called GNSS-SDR for the purpose of conducting simulations.
It includes two file folders, namely Common and include, a setting file initSetting.m, and the main function init.m.
We use this open-source code to process two provided source files, i.e., Opensky.bin and Urban.dat.
The results are given as follows.



## Task 1 -- Acquisition

### Settings:

The purpose of acquisition is to identify all satellites visible to the user, as well as the coarse values of carrier Doppler frequency and code phase of satellite signals.
The provided source file Opensky.bin is read by the following form in *initSettings.m*:

![image](https://github.com/user-attachments/assets/644826b3-14d5-4c3a-aa7f-e86014a703b1)

while that for Urban.bin is

![image](https://github.com/user-attachments/assets/e08d243b-1d4c-44fa-b770-ed429771ee32)

Then, we need to set the values of the intermediate frequency (IF) and the sampling frequency. 
Note that the original signal is GPS L1 signal, the IF is 4.58 MHz, and the sampling frequency is 58 MHz.
Hence, we set the above parameters in *initSettings.m* as follows:

<img width="415" alt="image" src="https://github.com/user-attachments/assets/d2f047f4-e5bb-42cb-890e-7b9156050112" />

while that for Urban dataset is

<img width="415" alt="image" src="https://github.com/user-attachments/assets/c1739151-e33d-472a-8ff9-7c753c9e09c7" />

Due to the Doppler shift, we need to search the frequencies in a certain range. 
Here, we set the search stepsize as 500Hz, which is depicted by the following code in *acquisition.m*:

<img width="415" alt="image" src="https://github.com/user-attachments/assets/f294dd52-fd31-4cca-a318-86fe496e3222" />

Notice that each satellite has its own pseudo-random noise (PRN) code, and the code phase will change due to the transmission. 
Therefore, the parallel frequency space search acquisition with 20 ms stepsize is considered, and the code can be found in *acquisition.m*:

<img width="415" alt="image" src="https://github.com/user-attachments/assets/b0b3bd26-16ec-4c8d-959a-91d9eef8931d" />

In fact, we only search maximum of 32 PRN codes as defined in *initSettings.m*:

<img width="415" alt="image" src="https://github.com/user-attachments/assets/50414983-1aa5-4e6f-a694-e05c6b624a38" />

Before acquisition, the threshold should determined to judge the acquisition metrics, and this parameter is set in *initSettings.m*:

<img width="415" alt="image" src="https://github.com/user-attachments/assets/6e207fbd-82cd-49ca-a2df-30a0c66d81af" />

### Results for Opensky:

First, we give the result for the Opensky source file. 
After running the main function init.m and press 1 to continue, the acquisition result can be obtained. 
The acquisition metrics for every PRN codes are plotted in the following figure.
We can see that there are 5 satellite signals, including 16, 22, 26, 27, and 31, exceed the pre-determined threshold 1.5.
Also, we label the acquired PRN codes green as shown in the figure:

<img width="415" alt="image" src="https://github.com/user-attachments/assets/574bfbb7-bf30-4f24-ae2d-e0f9e173279e" />

Meanwhile, we also draw the sky plot as follows:

<img width="311" alt="image" src="https://github.com/user-attachments/assets/e0adb625-3a63-4aef-893e-917abeefa7b6" />

Finally, to summarize, we provide a table to show the complete acquisition results.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/ba5ba669-7133-44e4-9006-fe6e04b02572" />

### Results for Urban:

On the other hand, the result for the Urban source file can be derived in a similar manner as outlined below. 
In this case, only 4 satellites are identifiable, namely satellite PRN numbers 1, 3, 11, and 18.
The corresponding acquisition metric is plotted as

<img width="415" alt="image" src="https://github.com/user-attachments/assets/e6779ddd-4c69-4594-9842-790c45545e5a" />

and the sky plot is

<img width="334" alt="image" src="https://github.com/user-attachments/assets/276a4ab1-6980-49ff-9371-7cbc4ddafc77" />

The summarized acquisition results for the Urban data can be found in the following table.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/d0f327c4-9e7a-409c-8b5a-827935f467d3" />



## Task 2 – Tracking

### Settings:

Based on the acquisition results, we then do the tracking. 
The tracking process involves refining the initial, the coarse estimate of Doppler frequency and code phase through feedback loops, which ensures continuous tracking of the received signal.
First, we must determine the correlation, encompassing its early, prompt, and late components.
Tthe corresponding code is written in the *tracking.m*.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/7561e87c-dda1-4e7f-b3e3-9400d0a603ca" />

Then, the delay lock loop (DLL) discriminator will be used to adjust the code phase as shown in *tracking.m*:

<img width="415" alt="image" src="https://github.com/user-attachments/assets/50933066-d844-4a8d-9a71-faae948fed99" />

To get the autocorrelation function (ACF), it is necessary to implement numerous correlators. 
Here, correlators spaced at stepsize of 0.1 chip, ranging from -0.5 chip to 0.5 chip, are utilized as shown in *tracking.m*:

<img width="415" alt="image" src="https://github.com/user-attachments/assets/84881af9-9255-4df5-a532-c3216a171e21" />

According to the theoretical analysis, the correlation function should be a triangle as illustrated below, where the early and late are similar while the prompt is largest.

<img width="126" alt="image" src="https://github.com/user-attachments/assets/428973e0-6e3f-45aa-9b03-95b76942d486" />

### Results for Opensky:

First, we plot the I-channel and Q-channel signals in the following figure. 
It is evident that the Q-channel converges towards 0, implying that it primarily consists of some noises.
Note that the fluctuations of its value remain centered around 0.
It indicates that the carrier phase has been accurately aligned.

<img width="322" alt="image" src="https://github.com/user-attachments/assets/4b92e105-fd71-4286-b9d4-42fe52f9fc2f" />

The following figure plots the PLL discriminator results, where we can see that PLL output is around 0. 
It means the local carrier and the received signal carrier are synchronized.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/acaa1c7c-d785-482f-8686-ad4aa0954af8" />

When the DLL output is close to 0 as shown in the following figure, the local code is synchronized with the code phase of the received signal. 
In this case, the code tracking error is minimized.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/8ca3471d-862f-4580-bccf-75bd632413f8" />

Then, the result of correlation is displayed in the following figure. 
It can be intuitively seen that the prompt correlation significantly exceeds early and late correlations. 
This indicates that the code phases is highly aligned and the tracking of the DLL is good.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/37eae784-bc0b-41dd-9543-2963178c8e44" />

The ACF is presented below.
It exhibits a symmetric shape, suggesting that the satellite is free from distortion and not affected by multipath effects, aligning with the experimental setup of an open sky environment.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/a69d989d-da0e-4128-bdfb-b18749d29192" />

### Results for Urban:

On the other hand, the results of the Urban data are provided as follows. 
First, the relation between the I-channel and Q-channel signals are shown in the following figure:

<img width="294" alt="image" src="https://github.com/user-attachments/assets/973e6d7f-f218-4922-b1ec-b73d24671e3b" />

Then, the PLL and DLL discriminators are shown as follows:

<img width="415" alt="image" src="https://github.com/user-attachments/assets/941a28aa-e11e-41fc-8517-dc74345cd358" /><br>

<img width="415" alt="image" src="https://github.com/user-attachments/assets/d9b23227-6c3f-448b-81a0-50750cc3eb05" />

Moreover, the early, prompt, and late correlations are plotted below.
Under the effect of multipath, there seems to be no evident difference between prompt and early or late.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/4a4ec014-6822-4268-927c-a232a5acc64c" />

Finally, we draw the ACF.
We can see that in urban area, there is the multipath that impacts the triangle shap.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/3de9af05-6ca2-48ed-a26e-a44a37118e93" />



## Task 3 – Navigation Data Decoding

### Settings:

The basic format of navigation data can be expressed by the following figure.  

<img width="415" alt="image" src="https://github.com/user-attachments/assets/4ee88626-76f3-4020-aea0-56d278b73f54" />

In this open-source code, the ephemeris is decoded in *postNavigation.m*, and the detailed code is as follows.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/7d901a73-05dd-465c-bd42-488aff0dc378" />

### Results for Opensky:

First, we plot the received bits of the navigation message in the following figure。
Notice that the navigation data is binary information, which is consistent with the modulation.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/ac8d937f-c57b-4014-90be-beed50367032" />

The, the data of ephemeris is displayed as follows, which include 31 parameters:

<img width="415" alt="image" src="https://github.com/user-attachments/assets/6c89dbae-c7d8-4cca-8b1e-500c2c8ccea7" /><br>

<img width="415" alt="image" src="https://github.com/user-attachments/assets/85d91c69-6878-4bed-a785-ac42b9a897b0" /><br>

<img width="415" alt="image" src="https://github.com/user-attachments/assets/110e1969-d514-49d1-85f3-81cff21acc26" />

### Results for Urban:

On the other hand, the binary bits of the navigation message for Urban data is plotted in the following figure. 

<img width="415" alt="image" src="https://github.com/user-attachments/assets/8465dc8e-f457-41a9-99dd-17d014276513" />



## Task 4 – Position and Velocity Estimation

### Settings:

The weighted least square (WLS) estimate is in *leastSquarePos.m*.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/b60e4926-3fff-43f4-8fd1-0c62df631199" />

Meanwhile, the velocity can be estimated by using the following code in *leastSquarePos.m*.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/ee810d2b-e1a2-462c-8b09-2fca49991ac9" />

### Results for Opensky:

The positioning result with weighted least square (WLS) is shown in the following figure.
The ground truth is (22.328444770087565, 114.1713630049711), which is marked by the yellow circle.
Other estimated positions are marked as red. 
From this figure, we can find that the solved location of the GPS signals can track the target well.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/f65554f1-76aa-4db0-aa21-3a573c308ef5" />

The variation is plotted in the following figure:

<img width="415" alt="image" src="https://github.com/user-attachments/assets/a6aaa598-45c5-4d30-a8ec-420fee05e4c9" />

### Results for Urban:

Then, the positioning result for Urban is shown as follows, where the ground truth of Urban data is (22.3198722, 114.209101777778).

<img width="415" alt="image" src="https://github.com/user-attachments/assets/72f6cc16-fcb8-45bf-8455-a4c63f6aedef" />

Also, the variation is drawn below.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/04d28b65-824e-43f3-a829-7361fe6a8fa6" />



## Task 5 – Kalman Filter-Based Positioning

### Settings:

The basic theory of the extended Kalman filter (EKF) is demonstrated by the following figure.
The EKF means to fusing the state prediction and the measurement.
More precisely, the measurement will be utilized to adjust the prediction, and the gain is related to their error covariances with resepct to the real state.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/bc4f15e4-3302-4a03-9413-1e583a9deace" />

In the code, we write the EKF in *ekf.m* as follows:

<img width="415" alt="image" src="https://github.com/user-attachments/assets/2ec3efd8-d069-45c1-9bb5-45b7be9a4333" />

### Results for Opensky:

Based on the EKF, the estimated positions in Opensky are displayed in the following figure, as well as the ground truth.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/b6ad64fb-f667-475d-9a77-9203ba6fbb89" />

The variation for the estimate is shown in the following figure.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/97bfaffc-e873-477f-8a54-f8dd68faf904" />

### Results for Urban:

The estimated positions of Urban data are plotted below.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/3e51ea9b-5573-43d9-a506-4a13d0ed436c" />

The corresponding estimation error is presented in the following figure.

<img width="415" alt="image" src="https://github.com/user-attachments/assets/70dfac8d-6f80-40e2-b64f-3c23f2854cfb" />




