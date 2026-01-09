@echo off
:: Build script for Windows (gcc must be on PATH)
set SRC=CP2_PROJECT\main.c
set OUT=build\%~n0.exe
if not exist build mkdir build

gcc "%SRC%" -o "build\main.exe"
if %ERRORLEVEL% neq 0 (
    echo Build failed
    exit /b %ERRORLEVEL%
)

echo Build succeeded: build\main.exe
