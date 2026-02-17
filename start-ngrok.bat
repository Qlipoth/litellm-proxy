@echo off
echo Starting ngrok tunnel for LiteLLM Proxy...
echo Make sure LiteLLM is running on port 4000 first!
echo.
ngrok http 4000
