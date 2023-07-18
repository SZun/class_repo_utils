#!/bin/bash

##########################################################
# Script for updating class repo
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
homework_directory="02-Homework/"
canvas_directory="04-Canvas/"
week=$1
week_directory=${week_names[week-1]}
day=$2
is_solutions=true

# If a third argument exists
if [ ! -z "$3" ]
then
  # Set solutions to false
  is_solutions=false
fi

## Path variables
lesson_week_directory="${lesson_directory}${week_directory}"

class_repo_directory="${root_directory}${class_repo_directory}"
class_lesson_week_directory="${class_repo_directory}${lesson_week_directory}"
class_lesson_day_directory="${class_lesson_week_directory}/${day}"
class_homework_directory="${class_repo_directory}${homework_directory}"

master_repo_directory="${root_directory}${master_repo_directory}"
master_lesson_day_directory="${master_repo_directory}${lesson_week_directory}/${day}"

content_type="Lessons"


# Set content type of commit message
set_content_type() {
  # Check if adding solutions
  if [ "$is_solutions" = true ] 
  then
      # Delete current day directory
      rm -rf "${class_lesson_day_directory}"
      # Set content type to solutions
      content_type="Solutions"
  # If it is the first day
  elif [ "$day" = "1" ]
  then
    # Set content type to include all folders changed
    content_type="Lessons, Homework, Canvas"
  else
    # Set content type to Lessons
    content_type="Lessons"
  fi
}

# Method to add weekly files
add_week () {
    # Create lesson directory
    mkdir "${class_lesson_week_directory}"

    # Copy/Paste current week homework directory
    cp -r "${master_repo_directory}${homework_directory}${week_directory}" "${class_homework_directory}"
    # Delete homework solution directory
    rm -rf "${class_homework_directory}${week_directory}/"Solutio**

    # Copy/Paste current week Canvas directory
    cp -r "${master_repo_directory}${canvas_directory}${week_directory}" "${class_repo_directory}${canvas_directory}${week_directory}"
}

# Method to reset the path variables
reset_path_variables() {
  # Set path variables
  lesson_week_directory="${lesson_directory}${week_directory}"

  class_repo_directory="${root_directory}${class_repo_directory}"
  class_lesson_week_directory="${class_repo_directory}${lesson_week_directory}"
  class_lesson_day_directory="${class_lesson_week_directory}/${day}"
  class_homework_directory="${class_repo_directory}${homework_directory}"

  master_repo_directory="${root_directory}${master_repo_directory}"
  master_lesson_day_directory="${master_repo_directory}${lesson_week_directory}/${day}"
}

# Method to add solutions
add_lessons () {
  # Copy/Paste folder
  cp -r "${master_lesson_day_directory}" "${class_lesson_week_directory}"

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


# Method to update next day content
handle_next_day_update() {
  # If it is the third day
  if [ "$day" == "3" ]
  then
    # Switch week directory to next week
    week_directory=${week_names[$week]}
    # Set day to first day
    day="1"
    # Reset the path variables
    reset_path_variables
    # Add weeks content
    add_week
  else
    # Increment day by 1
    day=$((day+1))
  fi

  # Reset Path Varaibles
  reset_path_variables
  # Set solutions to false
  is_solutions=false
  # Update content type
  set_content_type
  # Add lessons
  add_lessons
  # Add/Commit/Push changes
  add_commit_push
}

# Add commit and push changes
add_commit_push() {
  cd "${class_repo_directory}" && git add -A && git commit -m "Week ${week_directory} Day ${day} ${content_type}" && git push
}

# Method to handle updates/workflow
handle_updates() {
  # Change directory into your local class repo and pull from main branch
  cd "${class_repo_directory}" && git pull

  # Check if lesson directory deos not exists
  if [ ! -d "$class_lesson_week_directory" ] 
  then
    # Add content for this week (Canvas/Homework ect.)
    add_week
  fi

  # Update content type
  set_content_type
  # Add lessons
  add_lessons
  # Add/Commit/Push changes
  add_commit_push

  # Handle next day update
  handle_next_day_update
}

# Handle Workflow
handle_updates