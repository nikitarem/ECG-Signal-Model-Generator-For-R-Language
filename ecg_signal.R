# Electrocardiogram (ECG) signal model generator
# This function generates piecewise linear ECG signal model
#
# OUTPUT:
# ECG signal (or sequence) model with specified properties.
#
# INPUTS:
# ECG_Length: Length of generated signal model, must be > 16,
# 300 is recommended.
#
# Num_of_periods: If > 1, an ECG sequence will be created.
#
# Smooth: If TRUE, linear ECG signal will be smoothed with moving average
# window. Waves' magnitudes will be restored to the original ratios.
#
# Version 1.0
# Author: NIKITAREM, Sc.B., Samara University

ecg_signal <- function(ECG_Length = 300L,
                       Num_of_periods = 1L,
                       Smooth = FALSE) {

################## ERRORS ##################
    if (ECG_Length <= 16L) {
        stop("ECG_Length must be > 16")
    }
    
    if (is.integer(ECG_Length) == FALSE) {
        stop("ECG_Length must be integer")
    }
    
    if (is.integer(Num_of_periods) == FALSE) {
        stop(
            "Num_of_periods must be integer. Note: you can cut your signal using
         square brackets []. Do this function and
         then do sth like:

         ecg_model <- ecg_signal(300L, 5L)
         ecg_model <- ecg_model[150:350]

         then you will get samples of signal from 150 to 350"
        )
    }
    
    if (Num_of_periods < 1L) {
        stop("Num_of_periods must be > 0")
    }
    
    if (is.logical(Smooth) == FALSE) {
        stop("Smooth must be logical")
    }
################## ERRORS ##################
################# FUNCTION #################
    ecg_template <- c(0, 0, 3, 11, 3, 0, 0, -31, 144, -58, 0, 7.5, 25, 2.5, 0, 0) # Template, 16 samples
    ecg_samples <- c(0, 21, 29, 33, 37, 38, 39, 41, 46, 49, 52, 70, 82, 88, 89, 123)
    
    # INTERPOLATE SIGNAL
    ECG_Length <- ECG_Length * 20L # Later signal will be decimated by 20
                                   # for better resolution
    ecg_approx <- approx(x = ecg_samples,
                         y = ecg_template,
                         method = "linear",
                         n = ECG_Length)
    ecg_final <- ecg_approx$y
    ecg_samples_interp <- ecg_approx$x
    
    # SMOOTH SIGNAL IF NECESSARY
    if (Smooth == TRUE) {
        n <- ECG_Length %/% 30 # Window Length
        k <- 1L # Cycle counter
        ecg_smooth <- c(1:ECG_Length)
        # smoothing algorithm
        for (k in 1:(n - 1))
            ecg_smooth[k] <- mean(ecg_final[1:k])
        for (k in n:ECG_Length)
            ecg_smooth[k] <- mean(ecg_final[(k - n + 1):k])
        # NORMALIZE WAVES
        # NORMALIZE P WAVE
        p_wave_samples <- ecg_samples_interp < ecg_samples[8]
        p_wave <- ecg_smooth * p_wave_samples
        p_wave <- p_wave * (11 / max(p_wave))
        
        # NORMALIZE QRS COMPLEX
        qrs_samples1 <- ecg_samples_interp <= ecg_samples[11]
        qrs_samples2 <- ecg_samples_interp >= ecg_samples[8]
        qrs <- ecg_smooth * qrs_samples1 * qrs_samples2
        qrs <- qrs * (144 / max(qrs))
        
        # NORMALIZE T WAVE
        t_wave_samples <- ecg_samples_interp > ecg_samples[11]
        t_wave <- ecg_smooth * t_wave_samples
        t_wave <- t_wave * (25 / max(t_wave))
        
        # SUM
        ecg_final <- p_wave + qrs + t_wave
    }
    
    # DECIMATE
    ecg_final <- ecg_final[seq(1, ECG_Length, by = 20L)]
    
    # ADD PERIODS IF NECESSARY
    if (Num_of_periods > 1) {
        ecg_final <- rep(ecg_final, Num_of_periods)
    }
    
    # NORMALIZE MAGNITUDE
    ecg_model <- ecg_final / (max(ecg_final))
    return(ecg_model)
}