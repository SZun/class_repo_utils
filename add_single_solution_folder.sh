#!/bin/bash

##########################################################
# Script to add Solved folder
##########################################################

# Array of week names
week_names=("01-Excel" "02-VBA-Scripting" "03-Python" "04-Data-Analysis-Pandas" "05-Data-Visualization" "06-Python-APIs" "07-Project-1-Week-1" "08-Project-1-Week-2" "09-SQL" "10-Advanced-SQL" "11-Data-Collection" "12-NoSQL-Databases" "13-Project-2-ETL" "14-Interactive-Visualizations" "15-Mapping" "16-Project-3-Data-Ethics" "17-Project-3-Week-2" "18-Tableau" "19-Unsupervised-Learning" "20-Supervised-Learning" "21-Neural-Networks-Deep-Learning" "22-Big-Data" "23-Project-4-Week-1" "24-Project-4-Week-2")

# Root Directory
root_directory="/c/Users/Samuel Zun/OneDrive/Documents/repos/UT-A-Data/"

# If on Windows
if [[ $OSTYPE = *"darwin"* ]]
then
  # Set Root Directory
  root_directory="${HOME}/Documents/repos/UT-A-Data/"
fi

# Global variables
class_repo_directory="UTA-VIRT-DATA-PT-06-2023-U-LOLC/"
master_repo_directory="DataViz-Lesson-Plans/"
lesson_directory="01-Lesson-Plans/"
week=$1
week_directory=${week_names[week-1]}
day=$2
solution_number=$3

## Path variables
lesson_week_directory="${lesson_directory}${week_directory}"

class_repo_directory="${root_directory}${class_repo_directory}"
# class_lesson_week_directory="${class_repo_directory}${lesson_week_directory}"
# class_lesson_day_directory="${class_lesson_week_directory}/${day}"

# master_repo_directory="${root_directory}${master_repo_directory}"
# master_lesson_day_directory="${master_repo_directory}${lesson_week_directory}/${day}"

master_solution_path="${root_directory}${master_repo_directory}${lesson_week_directory}/${day}/Activities/${solution_number}-Stu_**/Solved"
class_activity_path="${root_directory}${class_repo_directory}${lesson_week_directory}/${day}/Activities/${solution_number}-Stu_**/"

cp -r "${master_solution_path}" "${class_activity_path}"

echo $master_solution_path
echo $class_activity_path

# cd "${class_repo_directory}" && git status && git add -A && git stash && git stash drop

# cd "${class_repo_directory}" && git add -A && git commit -m "Adding Solution for Activity ${solution_number}" && git push