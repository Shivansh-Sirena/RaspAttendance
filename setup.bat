@echo off
REM RaspAttendance Windows Testing Setup Script (setup.bat)
REM
REM This script initializes the Python virtual environment and installs
REM dependencies on a Windows system.
REM
REM Author: Embedded Systems & Computer Vision Specialist

echo =======================================================
echo        RaspAttendance Windows System Setup
echo =======================================================

REM 1. Verify Python Installation
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed or not added to your system PATH.
    echo Please install Python 3.8+ from https://www.python.org/
    exit /b 1
)

REM 2. Create Virtual Environment
echo [1/4] Setting up Python virtual environment...
python -m venv venv
if %errorlevel% neq 0 (
    echo [ERROR] Failed to create virtual environment.
    exit /b 1
)
echo Virtual environment created successfully.

REM 3. Activate Virtual Environment and Upgrade Pip
echo [2/4] Activating virtual environment and upgrading pip...
call venv\Scripts\activate
python -m pip install --upgrade pip

REM 4. Install Dependencies
echo [3/4] Installing dependencies via pip...
echo (Note: Installing face-recognition requires Visual Studio C++ Build Tools.)
echo (If face-recognition fails to compile, install Build Tools from https://visualstudio.microsoft.com/visual-cpp-build-tools/)
pip install cmake
pip install flask pandas openpyxl opencv-python numpy face-recognition

REM 5. Setup Test Directories
echo [4/4] Setting up local directories...
if not exist Student_Images (
    mkdir Student_Images
    echo Created local Student_Images directory.
)

echo =======================================================
echo        SETUP COMPLETE - READY FOR WINDOWS TESTING
echo =======================================================
echo To start testing, follow these commands:
echo.
echo   1. Activate the environment:
echo      venv\Scripts\activate
echo.
echo   2. Start the Data Sharing and Admin web server:
echo      python share_logs.py
echo      (Open your browser and navigate to: http://localhost:5000)
echo.
echo   3. Start the recognition camera engine (requires webcam connected):
echo      python attendance_engine.py
echo.
echo Note: You can test the Web Portal and Admin console at http://localhost:5000/admin
echo immediately even without a webcam or DS3231 RTC hardware connected.
echo.
pause
