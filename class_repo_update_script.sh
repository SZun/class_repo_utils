#!/bin/bash

##########################################################
# Script for updating class repo
##########################################################

# Config variablesroot_directory
root_directory="${HOME}/Documents/repos/UT-A-Data/"
class_repo_name="UTA-VIRT-DATA-PT-06-2023-U-LOLC/"
master_repo_name="DataViz-Lesson-Plans/"
lesson_directory="01-Lesson-Plans/"
homework_directory="02-Homework/"
canvas_directory="04-Canvas/"
week_directory="09-SQL"
day="1"
is_solutions=false


## Path variables
lesson_week_directory="$lesson_directory$week_directory"

class_repo_directory="$root_directory$class_repo_name"
class_lesson_week_directory="$class_repo_directory$lesson_week_directory"
class_lesson_day_directory="$class_lesson_week_directory/$day"
class_homework_directory="$class_repo_directory$homework_directory"

master_repo_directory="$root_directory$master_repo_name"
master_lesson_day_directory="$master_repo_directory$lesson_week_directory/$day"


# Change directory into your local class repo and pull from main branch
cd $class_repo_directory && git pull origin main


# Check if lesson directory deos not exists
if [ ! -d "$class_lesson_week_directory" ]; 
then

    # Create lesson directory
    mkdir $class_lesson_week_directory

    # Copy/Paste current week homework directory
    cp -r "$master_repo_directory$homework_directory$week_directory" $class_homework_directory
    # Delete homework solution directory
    rm -rf "${class_homework_directory}${week_directory}/"Solutio**

    # Copy/Paste current week Canvas directory
    cp -r "$master_repo_directory$canvas_directory$week_directory" "$class_repo_directory$canvas_directory$week_directory"
fi

# Check if adding solutions
if [ "$is_solutions" = true ]; 
then
    # Delete current day directory
    rm -rf "${class_lesson_day_directory}"
fi

# Copy/Paste folder
cp -r $master_lesson_day_directory $class_lesson_week_directory

# Check if not adding solutions
if [ "$is_solutions" = false ]; 
then
    # Delete student student solved folders
    rm -rf "${class_lesson_day_directory}"/Activities/**Stu**/Solved
    # Delete student partner solved folders
    rm -rf "${class_lesson_day_directory}"/Activities/**Par**/Solved
fi

# Delete Lesson Plan
rm -rf "${class_lesson_day_directory}/LessonPlan.md"
# Delete Time Tracker
rm -rf "${class_lesson_day_directory}/TimeTracker.xlsx"



content_type="Lessons"

if [ "$is_solutions" = true ]; 
then
  content_type="Solutions"
elif [ "$day" = "1" ]
then
  content_type="Lessons, Homework, Canvas"
fi

# Add commit and push changes
cd $class_repo_directory && git add -A && git commit -m "Week ${week_directory} Day ${day} ${content_type}" && git push