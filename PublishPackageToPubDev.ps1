# Refuses anything that is not a plain MAJOR.MINOR.PATCH stable release -
# pre-release suffixes like `2.0.0-dev1` are rejected on purpose so we don't
# publish dev versions by mistake.
$versionRegex = "^version: (\d+)\.(\d+)\.(\d+)\s*$"
$pubspecFileName = "pubspec.yaml"
$versionDartFileName = "lib/src/Constants/Generated/VersionConstants.dart"

$versionLine = (Get-Content -Path $pubspecFileName) | Where-Object { $_ -match "^version: " } | Select-Object -First 1
if (-not ($versionLine -match $versionRegex))
{
    Write-Error "${pubspecFileName} version is not a plain MAJOR.MINOR.PATCH stable release: '$versionLine'. Update pubspec.yaml to a stable version (e.g. 2.0.0) before publishing."
    exit 1
}
$major = $matches[1]
$minor = $matches[2]
$patch = $matches[3]

# Refuse to publish if the master DEBUG flag in Constants.dart is on. Every
# DEBUG_X flag derives from `(DEBUG && …) || DEBUG_ALL`, so DEBUG=false is
# sufficient to keep them all off in production builds.
$constantsFileName = "lib/src/Constants/Constants.dart"
$debugLine = Get-Content -Path $constantsFileName | Where-Object { $_ -match '^\s*static const bool DEBUG\s*=' } | Select-Object -First 1
if (-not ($debugLine -match '=\s*false\s*;\s*$'))
{
    Write-Error "Constants.DEBUG is not set to false. Reset it before publishing.`n  $($debugLine.Trim())"
    exit 1
}

$oldVersionDartFileContent = Get-Content -Path $versionDartFileName -Raw
$newVersionDartFileContent = $oldVersionDartFileContent `
    -replace "MAJOR = \d+;", "MAJOR = $major;" `
    -replace "MINOR = \d+;", "MINOR = $minor;" `
    -replace "PATCH = \d+;", "PATCH = $patch;"

# Atomic write: bypass Set-Content (which races with IDE/build_runner holding the file open)
# and swap via Move-Item -Force. UTF-8 without BOM to match the original.
$versionDartTempFileName = "$versionDartFileName.tmp"
[System.IO.File]::WriteAllText(
    (Join-Path (Get-Location) $versionDartTempFileName),
    $newVersionDartFileContent,
    (New-Object System.Text.UTF8Encoding $false))
Move-Item -Path $versionDartTempFileName -Destination $versionDartFileName -Force

dart pub publish
