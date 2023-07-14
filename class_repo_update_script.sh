#!/bin/bash
##########################################################
# Script for updating class repo
##########################################################



# Config variablesroot_directory
root_directory="~/Documents/repos/UT-A-Data/"
class_repo_name="UTA-VIRT-DATA-PT-06-2023-U-LOLC/"
master_repo_name="DataViz-Lesson-Plans/"
lesson_directory="01-Lesson-Plans/"
homework_directory="02-Homework/"
canvas_directory="04-Canvas/"
week_directory="06-Python-APIs/"
day="2"
is_solutions=false


## Path variables
lesson_week_directory="${lesson_directory}${week_directory}"
class_repo_directory="${root_directory}${class_repo_name}"
class_lesson_directory="${class_repo_directory}${lesson_week_directory}"
class_lesson_day_directory="${class_lesson_directory}${day}"
class_homework_directory="${class_repo_directory}${homework_directory}"
master_repo_directory="${root_directory}${master_repo_name}"
master_lesson_day_directory="${master_repo_directory}${lesson_week_directory}${day}"


# ###### This section is to reset your class repo ######

# # Change directory into your local class repo
# cd "${root_directory}${class_repo_name}"

# # Pull current version of main
# git pull

# ###### This section is for adding content to your local repository and deleting sensitive files/folders ######

# # Check if lesson directory deos not exists
# if [ ! -d "$class_lesson_directory" ]; then
#     # Create lesson directory
#     mkdir $class_lesson_directory

#     # Copy/Paste current week homework directory
#     cp -r "${master_repo_directory}${homework_directory}${week_directory}" $class_homework_directory
#     # Delete current week homework solutions
#     rm -rf "${class_homework_directory}${week_directory}Solutions"

#     # Copy/Paste current week Canvas directory
#     cp -r "${master_repo_directory}${canvas_directory}${week_directory}" "${class_repo_directort}${canvas_directory}${week_directory}"
# fi

# # Check if adding solutions
# if [ "$is_solutions" = true ] ; then
#     # Delete current day directory
#     rm -rf "${class_lesson_day_directory}"
# fi

# # Copy/Paste folder
# cp -r $master_lesson_day_directory $class_lesson_directory

# # Check if not adding solutions
# if [ "$is_solutions" = false ] ; then
#     # Delete student student solved folders
#     rm -rf "${class_lesson_day_directory}/Activities/**Stu**/Solved"
# fi

# # Delete LessonPlan.md file
# rm -rf "${class_lesson_day_directory}/LessonPlan.md"

# ####### This section is for adding the changes to the GitLab repo #######

# # Add changes
# git add -A

# # Set commit message
# message="${week} Day ${day} Content"
# if [ "$is_solutions" = true ] ; then
#     message="${message} Solutions"
# fi
# # Commit changes
# git commit -m "${message}"

# # Push changes
# git push

# ###### This section is to reset the class repo ######

# # Change directory back into DataViz-Lesson-Plans
# cd "${master_repo_directory}"

# # Add changes
# git add -A

# # Stash changes
# git stash

# # Drop stashed changes
# git stash drop