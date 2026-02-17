@echo off
cd /d C:\work\litellm
call venv\Scripts\activate
C:\work\litellm\venv\Scripts\litellm.exe --config "C:\work\litellm\config.yml"
