"package cli
var (
  PlatformName = """"
  Version      = ""$env:DOCKER_VERSION""
  GitCommit    = ""$(git rev-parse --short HEAD)""
  BuildTime    = ""$(get-date)""
)" | Out-File -Encoding Ascii "C:\gopath\src\github.com\docker\cli\cli\version.go"
