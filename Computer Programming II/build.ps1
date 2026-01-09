# Simple build script for CP2_PROJECT
$gcc = "D:\tdm-gcc\bin\gcc.exe"
$src = "C:\Users\Abdul Rahim\Desktop\CP2_PROJECT\CP2_PROJECT\main.c"
$out = "C:\Users\Abdul Rahim\Desktop\CP2_PROJECT\CP2_PROJECT\main.exe"

if (!(Test-Path $gcc)) {
    Write-Host "gcc not found at $gcc. Update the path in build.ps1 or add gcc to PATH." -ForegroundColor Red
    exit 1
}

& $gcc $src -o $out
if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit $LASTEXITCODE
}
Write-Host "Build succeeded: $out" -ForegroundColor Green
