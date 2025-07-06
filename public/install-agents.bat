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

:: Count DLL files in source directory
set /a DLL_COUNT=0
for %%f in ("%SOURCE_DIR%\*.dll") do (
    set /a DLL_COUNT+=1
)

:: Count ZIP files in source directory
set /a ZIP_COUNT=0
for %%f in ("%SOURCE_DIR%\*.zip") do (
    set /a ZIP_COUNT+=1
)

if %DLL_COUNT%==0 if %ZIP_COUNT%==0 (
    echo.
    echo No .dll or .zip files found in "%SOURCE_DIR%"
    echo Please check the directory and try again.
    echo.
    goto INPUT_DIR
)

:: Handle ZIP extraction if no DLL files found
if %DLL_COUNT%==0 if %ZIP_COUNT% gtr 0 (
    echo.
    echo No .dll files found, but %ZIP_COUNT% .zip file(s) detected.
    echo Extracting ZIP files to find agent DLL files...
    echo.
    
    :: Create temporary extraction directory
    set "TEMP_EXTRACT=%TEMP%\ttr_agent_extract_%RANDOM%"
    mkdir "%TEMP_EXTRACT%" 2>nul
    
    :: Extract all ZIP files
    for %%f in ("%SOURCE_DIR%\*.zip") do (
        echo Extracting: %%~nxf
        powershell -command "Expand-Archive -Path '%%f' -DestinationPath '%TEMP_EXTRACT%' -Force" 2>nul
        if errorlevel 1 (
            echo   WARNING: Failed to extract %%~nxf
        )
    )
    
    :: Update source directory to extraction folder
    set "SOURCE_DIR=%TEMP_EXTRACT%"
    
    :: Recount DLL files in extracted content
    set /a DLL_COUNT=0
    for /r "%TEMP_EXTRACT%" %%f in (*.dll) do (
        set /a DLL_COUNT+=1
    )
    
    if %DLL_COUNT%==0 (
        echo.
        echo ERROR: No .dll files found in ZIP archives.
        echo Please ensure the ZIP files contain agent DLL files.
        rmdir /s /q "%TEMP_EXTRACT%" 2>nul
        echo.
        pause
        exit /b 1
    )
    
    echo Found %DLL_COUNT% .dll file(s) after extraction.
)

echo.
echo Found %DLL_COUNT% agent DLL file(s) to install.
echo.
echo Source: %SOURCE_DIR%
echo Destination: %DESTINATION%
echo.
echo Do you want to proceed with the installation? (Y/N)
set /p "CONFIRM="

if /i not "%CONFIRM%"=="Y" if /i not "%CONFIRM%"=="YES" (
    echo.
    echo Installation cancelled.
    :: Clean up temp directory if it exists
    if exist "%TEMP_EXTRACT%" rmdir /s /q "%TEMP_EXTRACT%" 2>nul
    echo.
    pause
    exit /b 0
)

echo.
echo Installing agent DLL files...
echo.

:: Copy DLL files and verify
set /a COPIED=0
set /a FAILED=0

if exist "%TEMP_EXTRACT%" (
    :: Copy from extracted files (recursive search)
    for /r "%SOURCE_DIR%" %%f in (*.dll) do (
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
) else (
    :: Copy from source directory directly
    for %%f in ("%SOURCE_DIR%\*.dll") do (
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
)

:: Clean up temporary extraction directory
if exist "%TEMP_EXTRACT%" (
    echo.
    echo Cleaning up temporary files...
    rmdir /s /q "%TEMP_EXTRACT%" 2>nul
)

echo.
echo ========================================
echo   Installation Summary
echo ========================================
echo DLL files copied successfully: %COPIED%
echo DLL files failed: %FAILED%
echo Total DLL files processed: %DLL_COUNT%
echo.

if %FAILED% gtr 0 (
    echo WARNING: Some files failed to copy. Please check permissions and disk space.
    echo.
) else (
    echo All agent DLL files have been successfully installed to TTR-SUITE!
    echo.
)

echo Installation complete.
echo.
pause