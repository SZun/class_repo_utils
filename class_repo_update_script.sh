##########################################################
# Script for updating class repo
##########################################################

# Config variables
root_directory_path = '~/Documents/repos/UT-A-Data/'
class_repo_name = 'UTA-VIRT-DATA-PT-06-2023-U-LOLC/'
master_repo_name = 'DataViz-Lesson-Plans/'
lesson_directory = '01-Lesson-Plans/'
week_directory = '06-Python-APIs/'
day = '2'
is_solutions = false


# Path variables
lesson_week_directory = "${lesson_directory}${week_directory}"

class_lesson_directory = "${root_directory_path}${class_repo_name}${lesson_week_directory}"
class_lesson_day_directory = "${class_lesson_directory}${day}"

master_repo_path = "${root_directory_path}${master_repo_name}"
master_lesson_day_directory = "${master_repo_path}${lesson_week_directory}${day}"


###### This section is to reset your class repo ######

# Change directory into your local class repo
cd "${root_directory_path}${class_repo_name}"

# Pull current version of main
git pull

###### This section is for adding content to your local repository and deleting sensitive files/folders ######

# Check if lesson directory deos not exists
if [ ! -d "$class_lesson_directory" ]; then
    # Create lesson directory
    mkdir $class_lesson_directory
fi

# Check if adding solutions
if [ "$is_solutions" = true ] ; then
    # Delete current day directory
    rm -rf "${class_lesson_day_directory}"
fi

# Copy folder
cp -r $master_lesson_day_directory $class_lesson_directory

# Check if not adding solutions
if [ "$is_solutions" = false ] ; then
    # Delete student student solved folders
    rm -rf "${class_lesson_day_directory}/Activities/**Stu**/Solved/"
fi

# Delete LessonPlan.md file
rm -rf "${class_lesson_day_directory}/LessonPlan.md"

####### This section is for adding the changes to the GitLab repo #######

# Add changes
git add -A

# Commit changes
git commit -m "${week} Day ${day} content"

# Push changes
git push -u origin main

###### This section is to reset the class repo ######

# Change directory back into DataViz-Lesson-Plans
cd "${master_repo_path}"

# Add changes
git add -A

# Stash changes
git stash

# Drop stashed changes
git stash drop