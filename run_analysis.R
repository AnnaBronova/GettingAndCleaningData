# run_analysis.R - Coursera Getting and Cleaning Data Kursprojekt

library(dplyr)

# --- Daten einlesen ---
features        <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train       <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train       <- read.table("UCI HAR Dataset/train/y_train.txt")

subject_test  <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test        <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test        <- read.table("UCI HAR Dataset/test/y_test.txt")

# --- Schritt 1: Trainings- und Testdatensatz zusammenführen ---
subject <- rbind(subject_train, subject_test)
x       <- rbind(x_train, x_test)
y       <- rbind(y_train, y_test)
names(subject) <- "subject"
names(y)       <- "activity"

# --- Schritt 2: nur mean()- und std()-Messwerte extrahieren ---
names(x)      <- features$V2
mean_std_cols <- grep("mean\\(\\)|std\\(\\)", features$V2)
x_sub         <- x[, mean_std_cols]

# --- Schritt 3: beschreibende Aktivitätsnamen ---
y$activity <- activity_labels$V2[match(y$activity, activity_labels$V1)]

# --- Schritt 4: beschreibende Variablennamen ---
names(x_sub) <- gsub("\\(\\)", "", names(x_sub))
names(x_sub) <- gsub("-", "_", names(x_sub))
names(x_sub) <- gsub("^t", "time_", names(x_sub))
names(x_sub) <- gsub("^f", "freq_", names(x_sub))

# --- Schritt 5: tidy Dataset mit Durchschnitt je Aktivität + Proband ---
data <- cbind(subject, y, x_sub)
tidy <- data %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean), .groups = "drop")

write.table(tidy, "tidy_dataset.txt", row.names = FALSE)