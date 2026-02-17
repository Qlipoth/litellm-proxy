@echo off
echo ========================================
echo Starting LiteLLM Proxy with ngrok
echo ========================================
echo.

cd /d C:\work\litellm

REM Проверяем наличие ngrok
where ngrok >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: ngrok not found in PATH
    echo Please install ngrok from https://ngrok.com/download
    echo Or add ngrok to your PATH
    pause
    exit /b 1
)

REM Активируем виртуальное окружение
call venv\Scripts\activate

echo Starting LiteLLM Proxy on port 4000...
start "LiteLLM Proxy" cmd /k "C:\work\litellm\venv\Scripts\litellm.exe --config C:\work\litellm\config.yml"

REM Ждем немного, чтобы сервер запустился
timeout /t 3 /nobreak >nul

echo.
echo Starting ngrok tunnel...
echo Your public URL will be displayed below:
echo.

REM Запускаем ngrok (будет работать в этом окне)
ngrok http 4000

pause
