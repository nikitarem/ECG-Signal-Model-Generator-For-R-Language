# ECG-Signal-Model-Generator-For-R-Language
**My "hello world" on github.**

This function generates piecewise linear Electrocardiogram (ECG) signal model in R. Might be useful to test biomedical signal analyzing algorithms.

You can specify the length of the signal (ECG_Length) and a number of periods (Num_of_periods) to create an ECG sequence. Also You can get smoothed ECG specifying parameter "Smooth" to TRUE.

**Output** is an ECG Signal (Sequence).

**Inputs:**
- **ECG_Length:** Length of generated signal model, must be > 16, I recommend to use ECG_Length = 300 to get realistic ECG.
- **Num_of_periods:** With this parameter You can specify number of ECG periods. For example, if **Num_of_periods = 2**, You get two cardiointervals, 
if **Num_of_periods = 1**, You get one cardiointerval. By default **Num_of_periods = 1**.
- **Smooth:** If TRUE, linear ECG signal will be smoothed with moving average window. Waves' magnitudes will be restored to the original ratios. By default **Smooth = FALSE**.

# Examples
1. ECG: 300 samples, one cardiointerval, not smoothed.
```R
ecg1 <- ecg_signal() # we use default parameters
# ecg1 <- ecg_signal(300L, 1L, FALSE) # is the same
plot(ecg1, type = "l", xlab = "Samples, n", ylab = "Magnitude, mV")
```
![Example #1](https://raw.githubusercontent.com/nikitarem/ECG-Signal-Model-Generator-For-R-Language/main/Pictures/1.png)
2. ECG: 800 samples, five cardiointervals, smoothed.
```R
ecg2 <- ecg_signal(800L, 5L, Smooth = TRUE)
plot(ecg2, type = "l", xlab = "Samples, n", ylab = "Magnitude, mV")
```
![Example #2](https://raw.githubusercontent.com/nikitarem/ECG-Signal-Model-Generator-For-R-Language/main/Pictures/2.png)
3. ECG: 600 samples, three cardiointervals, smoothed, cutted to two cardiointervals.
```R
ecg3 <- ecg_signal(600L, 3L, Smooth = TRUE)
ecg3 <- ecg3[275:1675] #cut signal
plot(ecg3, type = "l", xlab = "Samples, n", ylab = "Magnitude, mV")
```
![Example #3](https://raw.githubusercontent.com/nikitarem/ECG-Signal-Model-Generator-For-R-Language/main/Pictures/3.png)

# Installation
Download file **ecg_signal.R**, launch it with Your R Gui or RStudio, run the code to get the function into the variable browser. Now You can use function **ecg_signal()** in the current session.

### ALTERNATIVE
Copy the code from file **ecg_signal.R** into Your R Script (or R Notebook). Run the code to get the function into the variable browser. Now You can use function **ecg_signal()** in Your R Script.




*Best regards, nikitarem.*
