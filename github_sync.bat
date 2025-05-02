@echo off
setlocal

REM Change directory to your website folder
cd "G:\My Drive\My_Finances\My Business\Southern_Travels\website"

REM Check if Git is initialized
if not exist .git (
    git init
    echo Initialized Git repository.
) else (
    echo Git repository already exists.
)

REM Set branch name to main
git branch -M main

REM Set remote URL to DeepSouthTours repo
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    git remote add origin https://github.com/DeepSouthTours/southern_tours.git
    echo Remote origin added.
) else (
    echo Remote origin already exists.
)

REM Stage and commit changes
git add .
git commit -m "Sync commit" 2>nul || echo Nothing new to commit.

REM Remove cached GitHub credentials (triggers login prompt)
cmdkey /delete:git:https://github.com >nul 2>&1
echo Cleared cached credentials. You will be prompted to enter username and PAT.

REM Pull and push to remote repo
git pull origin main --allow-unrelated-histories --no-edit
git push origin main

pause
endlocal
