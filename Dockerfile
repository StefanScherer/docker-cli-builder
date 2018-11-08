# escape=`
FROM chocolateyfest/chocolatey

#  GOPATH: c:\gopath
#  GOVERSION: 1.10.3
ENV DEPVERSION v0.4.1
ENV DOCKER_VERSION 18.09.0

RUN choco install -y golang -version 1.10.3
RUN choco install -y git

# install:
#   - rmdir c:\go /s /q
#   - appveyor DownloadFile https://storage.googleapis.com/golang/go%GOVERSION%.windows-amd64.msi
#   - msiexec /i go%GOVERSION%.windows-amd64.msi /q
#   - go version
#   - go env
RUN git clone -q --branch=master https://github.com/docker/cli.git C:\Users\ContainerAdministrator\go\src\github.com\docker\cli
WORKDIR C:\Users\ContainerAdministrator\go\src\github.com\docker\cli
RUN git checkout v%DOCKER_VERSION%
  # - ps: |
  #     "package cli
  #     var (
  #       PlatformName = """"
  #       Version      = ""$env:DOCKER_VERSION""
  #       GitCommit    = ""$(git rev-parse --short HEAD)""
  #       BuildTime    = ""$(get-date)""
  #     )" | Out-File -Encoding Ascii "C:\gopath\src\github.com\docker\cli\cli\version.go"

# build_script:
RUN go env
RUN choco install -y mingw
RUN powershell -File .\scripts\make.ps1 -Binary
#   - copy C:\gopath\src\github.com\docker\cli\build\docker.exe C:\projects\docker-cli-builder\
# 
# test_script:
#   - cd C:\projects\docker-cli-builder
#   - .\docker.exe --version
# 
# artifacts:
# - path: .\docker.exe
#   name: Binary
# 
# deploy:
#   provider: GitHub
#   description: ' '
#   auth_token:
#     secure: hAIMIlM7Gu2wsNymUr0bBGTWE/64xRo4bDHAQkiiSHS8zptfP+CLsjo3G+K1CJrB
#   on:
#     branch: master
#     appveyor_repo_tag: true

