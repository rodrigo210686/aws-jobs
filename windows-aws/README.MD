## Setar chaves para 400 no windows


icacls.exe key.pem /reset

icacls.exe key.pem /grant:r "$($env:username):(r)"

icacls.exe key.pem /inheritance:r
