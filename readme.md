Getting and Cleaning Data Course Project
----------------------------------------

This document describe the steps done to complete the project.

### Activities

1.  Data should be tidy.
    -   Accroding to Hadley Wickham [original
        article](http://vita.had.co.nz/papers/tidy-data.pdf) in **tidy
        data**
        -   Each variable formw a column.
        -   Each observation forms a row.
        -   Each observation unit form a table.
    -   Besides the Subject ID and Activity, each of the measures that
        includes "mean" are included in a separate column.
    -   Each observation (a combination of Subject ID and activity) are
        included in its own row.
    -   The table contains the average of each variable for each
        activity and subject.
    -   As mentioned by [this
        article](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/)
        this project allows for the wide or long form of tidy data, so I
        decided to use the long form.
2.  Script tasks
    -   The script was developed in functions to increase readability:
        -   The **initial\_setup** function loads the required libraries
            and set the working folder..
        -   The **merge\_data** function merges the training and the
            test sets.
        -   The **filter\_columns** function extracts only the
            measurements on the mean and standard deviation for each
            measurement.
        -   The **name\_columns** function uses descriptive activity
            names to name the activities in the data set.
        -   The **rename\_columns** function appropriately labels the
            data set with descriptive variable names.
        -   The **summary\_data** function creates a new tidy data set
            with the average of each variable for each activity and each
            subject.
        -   A section at the bottom called **run project** where all the
            functions are called.
3.  How to read the result data set.
    -   Download the file `results.txt` to a local folder.
    -   Open R Studio, use the function **setwd** to set the working
        folder to the one where the file is located.
    -   Execute the following R code:
    -   `read_result <- read.table("result.txt", header = TRUE)`
    -   `View(read_result)`

Created by: Elmer Ore.

**Source**: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra
and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity
Recognition Using Smartphones. 21th European Symposium on Artificial
Neural Networks, Computational Intelligence and Machine Learning, ESANN
2013. Bruges, Belgium 24-26 April 2013.
