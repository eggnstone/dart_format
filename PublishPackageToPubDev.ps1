$versionRegex = "version: (\d+)\.(\d+).(\d+)"
$pubspecFileName = "pubspec.yaml"
$versionDartFileName = "lib/src/Constants/Generated/VersionConstants.dart"

$pubspecFileContent = (Get-Content -Path $pubspecFileName)
$select = $pubspecFileContent | Select-String -Pattern $versionRegex
$dummy = $select[0] -match $versionRegex
$major = $matches[1]
$minor = $matches[2]
$patch = $matches[3]

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
