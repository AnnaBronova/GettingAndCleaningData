# CodeBook – Getting and Cleaning Data Course Project

## Source data
Human Activity Recognition Using Smartphones Dataset (UCI HAR Dataset).
Measurements come from the accelerometer and gyroscope of a Samsung Galaxy S
smartphone, recorded for 30 subjects performing 6 activities
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
Original data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Input files used
- `UCI HAR Dataset/features.txt` – names of the 561 measured features
- `UCI HAR Dataset/activity_labels.txt` – mapping of activity IDs (1–6) to activity names
- `train/subject_train.txt`, `train/X_train.txt`, `train/y_train.txt`
- `test/subject_test.txt`, `test/X_test.txt`, `test/y_test.txt`

## Transformations performed by run_analysis.R
1. **Merge:** training and test sets were combined with `rbind()` into one
   dataset (10299 rows): subjects, activity IDs and the 561-feature matrix.
2. **Extract measurements:** only features containing `mean()` or `std()`
   were kept (66 columns). Features like `meanFreq()` were excluded.
3. **Activity labels:** numeric activity IDs were replaced with descriptive
   names (WALKING, SITTING, ...) from `activity_labels.txt`.
4. **Variable names:** cleaned to be descriptive and valid R names:
   - removed parentheses `()`
   - hyphens `-` replaced with underscores `_`
   - leading `t` replaced with `time_` (time domain signal)
   - leading `f` replaced with `freq_` (frequency domain, FFT of the signal)
5. **Tidy dataset:** the data was grouped by `subject` and `activity` and the
   average of each variable was computed. Result written to
   `tidy_dataset.txt` (180 rows = 30 subjects × 6 activities, 68 columns).

## Variables in tidy_dataset.txt
- `subject` – subject ID, integer 1–30
- `activity` – activity name (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,
  SITTING, STANDING, LAYING)
- 66 measurement columns, each the **average** of that measurement over all
  observations for the given subject and activity. Values are normalized and
  bounded within [-1, 1].

Naming pattern: `time_`/`freq_` prefix + signal name + `_mean` or `_std` +
axis suffix `_X`, `_Y`, `_Z` (only for directional signals).

| Signal (prefix time_/freq_) | Axes | mean & std |
|---|---|---|
| BodyAcc | X, Y, Z | yes |
| GravityAcc | X, Y, Z | yes |
| BodyAccJerk | X, Y, Z | yes |
| BodyGyro | X, Y, Z | yes |
| BodyGyroJerk | X, Y, Z | yes |
| BodyAccMag | – | yes |
| GravityAccMag | – | yes |
| BodyAccJerkMag | – | yes |
| BodyGyroMag | – | yes |
| BodyGyroJerkMag | – | yes |

This yields 5 directional signals × 3 axes × 2 statistics = 30 columns,
plus 9 magnitude signals × 2 statistics = 18 columns, plus 9 frequency-domain
directional signals × 3 axes × 2 statistics = 18 columns → 66 measurement
columns in total.