# escape=`
FROM microsoft/windowsservercore

ENV GOVERSION 1.13.12
ENV DEPVERSION v0.4.1
ENV DOCKER_VERSION 19.03.12

ENV chocolateyUseWindowsCompression false
RUN powershell iex(iwr -useb https://chocolatey.org/install.ps1)
RUN choco feature disable --name showDownloadProgress
RUN choco install -y golang -version %GOVERSION%
RUN choco install -y git
RUN choco install -y mingw

ENV GOPATH C:\gopath
RUN git clone -q --branch=v%DOCKER_VERSION% --single-branch https://github.com/docker/cli.git C:\gopath\src\github.com\docker\cli
WORKDIR C:\gopath\src\github.com\docker\cli
RUN setx VERSION "%DOCKER_VERSION%"
RUN powershell -File .\scripts\make.ps1 -Binary
RUN dir C:\gopath\src\github.com\docker\cli\build\docker.exe
