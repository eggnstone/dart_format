# Stops the currently-running dart_format web service on 127.0.0.1:$port (if
# any) and starts a fresh one in the background, pinned to the same port via
# --port=$port so /quit and follow-up requests can find it.
#
# dart_format's own default is to pick a random free port and announce it via
# the JSON line on stdout; this script overrides that so the address stays
# predictable for manual testing.
#
# Assumes `dart_format` is on PATH (installed via `dart pub global activate
# dart_format`). Adjust $port below if you want a different fixed port.

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