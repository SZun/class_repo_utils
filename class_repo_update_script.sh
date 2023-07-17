#!/bin/bash

##########################################################
# Script for updating class repo
##########################################################

# Array of week names
week_names=("01-Excel" "02-VBA-Scripting" "03-Python" "04-Data-Analysis-Pandas" "05-Data-Visualization" "06-Python-APIs" "07-Project-1-Week-1" "08-Project-1-Week-2" "09-SQL" "10-Advanced-SQL" "11-Data-Collection" "12-NoSQL-Databases" "13-Project-2-ETL" "14-Interactive-Visualizations" "15-Mapping" "16-Project-3-Data-Ethics" "17-Project-3-Week-2" "18-Tableau" "19-Unsupervised-Learning" "20-Supervised-Learning" "21-Neural-Networks-Deep-Learning" "22-Big-Data" "23-Project-4-Week-1" "24-Project-4-Week-2")

# Config variables
root_directory="${HOME}/Documents/repos/UT-A-Data/"
class_repo_name="UTA-VIRT-DATA-PT-06-2023-U-LOLC/"
master_repo_name="DataViz-Lesson-Plans/"
lesson_directory="01-Lesson-Plans/"
homework_directory="02-Homework/"
canvas_directory="04-Canvas/"
week=$1
week_directory=${week_names[week-1]}
day=$2
is_solutions=true


if [ ! -z "$3" ]
then
  is_solutions=false
fi

## Path variables
lesson_week_directory="$lesson_directory$week_directory"

class_repo_directory="$root_directory$class_repo_name"
class_lesson_week_directory="$class_repo_directory$lesson_week_directory"
class_lesson_day_directory="$class_lesson_week_directory/$day"
class_homework_directory="$class_repo_directory$homework_directory"

master_repo_directory="$root_directory$master_repo_name"
master_lesson_day_directory="$master_repo_directory$lesson_week_directory/$day"

content_type="Lessons"


set_content_type() {
  # Check if adding solutions
  if [ "$is_solutions" = true ] 
  then
      # Delete current day directory
      rm -rf "${class_lesson_day_directory}"
      content_type="Solutions"
  elif [ "$day" = "1" ]
  then
    content_type="Lessons, Homework, Canvas"
  fi
}

add_week () {
    # Create lesson directory
    mkdir $class_lesson_week_directory

    # Copy/Paste current week homework directory
    cp -r "$master_repo_directory$homework_directory$week_directory" $class_homework_directory
    # Delete homework solution directory
    rm -rf "${class_homework_directory}${week_directory}/"Solutio**

    # Copy/Paste current week Canvas directory
    cp -r "$master_repo_directory$canvas_directory$week_directory" "$class_repo_directory$canvas_directory$week_directory"
}

reset_path_variables() {
  lesson_week_directory="$lesson_directory$week_directory"

  class_repo_directory="$root_directory$class_repo_name"
  class_lesson_week_directory="$class_repo_directory$lesson_week_directory"
  class_lesson_day_directory="$class_lesson_week_directory/$day"
  class_homework_directory="$class_repo_directory$homework_directory"

  master_repo_directory="$root_directory$master_repo_name"
  master_lesson_day_directory="$master_repo_directory$lesson_week_directory/$day"
}

add_lessons () {
  # Copy/Paste folder
  cp -r $master_lesson_day_directory $class_lesson_week_directory

  # Check if not adding solutions
  if [ "$is_solutions" = false ] 
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
}

set_next_day() {
  if [ "$day" == "3" ]
  then
    week_directory=${week_names[$week]}
    day="1"
    reset_path_variables
    add_week
  else
    day=$((day+1))
  fi
  reset_path_variables
  is_solutions=false
  set_content_type
  add_lessons
}

# Add commit and push changes
add_commit_push() {
  cd $class_repo_directory && git add -A && git commit -m "Week ${week_directory} Day ${day} ${content_type}" && git push
}

# Change directory into your local class repo and pull from main branch
# cd $class_repo_directory && git pull

# Check if lesson directory deos not exists
if [ ! -d "$class_lesson_week_directory" ] 
then
  add_week
fi

set_content_type
add_lessons
add_commit_push

if [ "$is_solutions" = true ] 
then
  set_next_day
fi

add_commit_push
