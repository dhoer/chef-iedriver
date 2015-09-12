def iedriver_short_version(version)
  version.slice(0, version.rindex('.'))
end

# Fixes drivers not copied to iedriver directory on Windows 7
def iedriver_powershell_version
  out = shell_out!('powershell.exe $host.version.major')
  out.to_i
rescue # powershell not installed
  -1
end
