---
title: "Reprod Research"
author: "Rishi"
date: "16 July 2016"
output: html_document
---


---
title: "ReproduceRes"
author: "Rishi"
date: "16 July 2016"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

#### R Markdown

### Reproducible Research: Peer Assessment 1

#### Introduction

##### The goal of this assignment to practice skills needed for reproducible research. Specifically this assignment use R markdown to write a report that answers the questions detailed in the sections below. In the process, the single R markdown document will be processed by knitr and be transformed into an HTML file. 

##### Start this assignment with fork/clone the GitHub repository created for this assignment. When finish, submit this assignment by pushing your completed files into your forked repository on GitHub. The assignment submission will consist of the URL to your GitHub repository and the SHA-1 commit ID for your repository state.

####Data

#####This assignment makes use of data from a personal activity monitoring device. This device collects data at 5 minute intervals through out the day. The data consists of two months of data from an anonymous individual collected during the months of October and November, 2012 and include the number of steps taken in 5 minute intervals each day. The data for this assignment can be downloaded from the course web site: Dataset: Activity monitoring data [52K] The variables included in this dataset are:
 steps: 
 1. Number of steps taking in a 5-minute interval (missing values are coded as NA)
 2. date: The date on which the measurement was taken in YYYY-MM-DD format
 3. interval: Identifier for the 5-minute interval in which measurement was taken The dataset is stored in a    
 4. comma-separated-value (CSV) file and there are a total of 17,568 observations in this dataset.



```{r}
# Download the file if necessary (29MB)
fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
filePath <- "./data/repdata%2Fdata%2Factivity.zip"

if (!file.exists("data")) {
  dir.create("data")
}

if (!file.exists(filePath)) {
  download.file(fileUrl, destfile = filePath)
   
  # And unzip it
  unzip(filePath, exdir="./data")
}

# Load the raw activity data
activityData <- read.csv("./data/activity.csv", stringsAsFactors=FALSE)

```

## Including Plots

You can also embed plots, for example:


Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
