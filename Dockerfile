# escape=`
FROM microsoft/windowsservercore

ENV GOVERSION 1.10.3
ENV DEPVERSION v0.4.1
ENV DOCKER_VERSION 18.09.0

RUN powershell iex(iwr -useb https://chocolatey.org/install.ps1)
RUN choco install -y golang -version %GOVERSION%
RUN choco install -y git
RUN choco install -y mingw

ENV GOPATH C:\gopath
RUN git clone -q --branch=master https://github.com/docker/cli.git C:\gopath\src\github.com\docker\cli
WORKDIR C:\gopath\src\github.com\docker\cli
RUN git checkout v%DOCKER_VERSION%
COPY setversion.ps1 setversion.ps1
RUN powershell -File .\setversion.ps1
RUN type C:\gopath\src\github.com\docker\cli\cli\version.go
RUN powershell -File .\scripts\make.ps1 -Binary
RUN dir C:\gopath\src\github.com\docker\cli\build\docker.exe
