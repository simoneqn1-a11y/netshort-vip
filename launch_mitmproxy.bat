@echo off
:: NetShort VIP Crack Launcher
:: Mo mitmweb + Chrome qua proxy de bat traffic

set MITM_PORT=8080
set SCRIPT_DIR=%~dp0
set MITM_SCRIPT=%SCRIPT_DIR%mitm_netshort.py
set TARGET_URL=https://web.shortnivo.com/vi

echo ============================================
echo  NetShort VIP Crack - mitmproxy Launcher
echo ============================================
echo.
echo [1] Khoi dong mitmweb tren port %MITM_PORT%...
echo [2] Script: %MITM_SCRIPT%
echo [3] Log API: %SCRIPT_DIR%api_capture.jsonl
echo.

:: Kiem tra mitmweb co san khong
where mitmweb >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [!] mitmweb khong tim thay trong PATH
    echo     Thu duong dan day du:
    set MITMWEB=C:\Users\PCs\AppData\Local\Programs\Python\Python313\Scripts\mitmweb.exe
) else (
    set MITMWEB=mitmweb
)

:: Chay mitmweb trong cua so rieng
echo [*] Dang khoi dong mitmweb...
start "mitmweb" cmd /k "%MITMWEB% -s "%MITM_SCRIPT%" -p %MITM_PORT% --set console_eventlog_verbosity=info --set ssl_insecure=true --set web_password="""

:: Doi mitmweb khoi dong
timeout /t 3 /nobreak >nul

:: Tim Chrome
set CHROME=
for %%p in (
    "C:\Program Files\Google\Chrome\Application\chrome.exe"
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe"
) do (
    if exist %%p set CHROME=%%~p
)

if "%CHROME%"=="" (
    echo [!] Chrome khong tim thay. Mo thu bang Edge...
    set CHROME=msedge
)

:: Mo Chrome voi proxy va ignore cert errors
echo [*] Dang mo trinh duyet qua proxy 127.0.0.1:%MITM_PORT%...
start "" "%CHROME%" --proxy-server=127.0.0.1:%MITM_PORT% --ignore-certificate-errors --user-data-dir="%TEMP%\chrome_mitm_profile" "%TARGET_URL%"

echo.
echo ============================================
echo  DA KHOI DONG THANH CONG
echo ============================================
echo.
echo  mitmweb UI: http://127.0.0.1:8081
echo  Target:     %TARGET_URL%
echo  API Log:    %SCRIPT_DIR%api_capture.jsonl
echo.
echo  Huong dan:
echo   1. Dang nhap vao NetShort tren trinh duyet
echo   2. Luot xem phim, bam vao tap VIP
echo   3. Xem console mitmweb de thay cac field bi patch
echo   4. Chay analyze.py de phan tich log
echo.
echo  Nhan phim bat ky de dong...
pause >nul
