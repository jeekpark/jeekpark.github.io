@echo off
SET DATE=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%

git add .
git status

set /p VAL="Commit and push the changes? [yes(y) / no]: "
if "%VAL%"=="y" (
	git commit -m "Update: %DATE%"
	git push
)
