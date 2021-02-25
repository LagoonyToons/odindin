$compress = @{
  Path = "C:\Users\logan\Desktop\odindin\exp\settings.cfg", "C:\Users\logan\Desktop\odindin\exp\game.pck", "C:\Users\logan\Desktop\odindin\exp\game.exe"
  CompressionLevel = "Fastest"
  DestinationPath = "C:\Users\logan\Desktop\odindin\exp\windows_port.Zip"
}
Compress-Archive @compress

$compress = @{
  Path = "C:\Users\logan\Desktop\odindin\exp\settings.cfg", "C:\Users\logan\Desktop\odindin\exp\exec.x86_64", "C:\Users\logan\Desktop\odindin\exp\exec.pck"
  CompressionLevel = "Fastest"
  DestinationPath = "C:\Users\logan\Desktop\odindin\exp\linux_port.Zip"
}
Compress-Archive @compress