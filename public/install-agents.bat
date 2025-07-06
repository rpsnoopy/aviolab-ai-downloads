@echo off
setlocal EnableDelayedExpansion

:: TTR-SUITE Agent Installation Script
:: This script copies agent files to the TTR-SUITE installation directory

echo.
echo ========================================
echo   TTR-SUITE Agent Installation Script
echo ========================================
echo.

:: Check if TTR-SUITE directory exists
set "DESTINATION=C:\TTR-SUITE\AppData\AgentCodes"
if not exist "C:\TTR-SUITE\" (
    echo ERROR: TTR-SUITE not found at C:\TTR-SUITE\
    echo Please ensure TTR-SUITE is installed before running this script.
    echo.
    pause
    exit /b 1
)

:: Create AgentCodes directory if it doesn't exist
if not exist "%DESTINATION%" (
    echo Creating AgentCodes directory...
    mkdir "%DESTINATION%" 2>nul
    if errorlevel 1 (
        echo ERROR: Failed to create directory %DESTINATION%
        echo Please check permissions and try again.
        echo.
        pause
        exit /b 1
    )
    echo Directory created successfully.
    echo.
)

:: Prompt user for source directory
:INPUT_DIR
echo Please enter the path to the directory containing agent files:
echo (Press Enter to browse or type the full path)
set /p "SOURCE_DIR="

:: If no input, show current directory and ask again
if "%SOURCE_DIR%"=="" (
    echo.
    echo Current directory: %CD%
    echo.
    goto INPUT_DIR
)

:: Remove quotes if present
set "SOURCE_DIR=%SOURCE_DIR:"=%"

:: Check if source directory exists
if not exist "%SOURCE_DIR%" (
    echo.
    echo ERROR: Directory "%SOURCE_DIR%" does not exist.
    echo Please check the path and try again.
    echo.
    goto INPUT_DIR
)

:: Count agent files in source directory
set /a FILE_COUNT=0
for %%f in ("%SOURCE_DIR%\*.zip") do (
    set /a FILE_COUNT+=1
)

if %FILE_COUNT%==0 (
    echo.
    echo No .zip files found in "%SOURCE_DIR%"
    echo Please check the directory and try again.
    echo.
    goto INPUT_DIR
)

echo.
echo Found %FILE_COUNT% agent file(s) in source directory.
echo.
echo Source: %SOURCE_DIR%
echo Destination: %DESTINATION%
echo.
echo Do you want to proceed with the installation? (Y/N)
set /p "CONFIRM="

if /i not "%CONFIRM%"=="Y" if /i not "%CONFIRM%"=="YES" (
    echo.
    echo Installation cancelled.
    echo.
    pause
    exit /b 0
)

echo.
echo Installing agents...
echo.

:: Copy files and verify
set /a COPIED=0
set /a FAILED=0

for %%f in ("%SOURCE_DIR%\*.zip") do (
    echo Copying: %%~nxf
    copy "%%f" "%DESTINATION%\" >nul 2>&1
    
    if errorlevel 1 (
        echo   ERROR: Failed to copy %%~nxf
        set /a FAILED+=1
    ) else (
        :: Verify file was copied correctly
        if exist "%DESTINATION%\%%~nxf" (
            echo   SUCCESS: %%~nxf installed
            set /a COPIED+=1
        ) else (
            echo   ERROR: %%~nxf not found after copy
            set /a FAILED+=1
        )
    )
)

echo.
echo ========================================
echo   Installation Summary
echo ========================================
echo Files copied successfully: %COPIED%
echo Files failed: %FAILED%
echo Total files processed: %FILE_COUNT%
echo.

if %FAILED% gtr 0 (
    echo WARNING: Some files failed to copy. Please check permissions and disk space.
    echo.
) else (
    echo All agent files have been successfully installed to TTR-SUITE!
    echo.
)

echo Installation complete.
echo.
pause