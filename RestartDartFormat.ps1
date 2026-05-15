# Stops the currently-running dart_format web service on 127.0.0.1:7777 (if
# any) and starts a fresh one in the background.
#
# Assumes `dart_format` is on PATH (installed via `dart pub global activate
# dart_format`). Adjust $port below if your service runs elsewhere.

$port = 7777
$quitUrl = "http://127.0.0.1:${port}/quit"

Write-Host "Stopping any dart_format on port ${port} ..."
try
{
    $response = Invoke-WebRequest -Uri $quitUrl -UseBasicParsing -TimeoutSec 3 -ErrorAction Stop
    Write-Host "  Quit signal sent (HTTP $($response.StatusCode))."
    Start-Sleep -Seconds 1
}
catch
{
    Write-Host "  No server responded on ${port}. Assuming none was running."
}

Write-Host "Starting new dart_format --web --port=${port} ..."
Start-Process -FilePath "dart_format" -ArgumentList "--web","--port=${port}" -WindowStyle Hidden
Write-Host "Done."