Write-Host @"
***************************************************************
*
* OpenTTD "Bulgarian Town Names"
* Copyright (c) 2017 Rusi Dimitrov
* This program comes with ABSOLUTELY NO WARRANTY.
* This is free software, and you are welcome to redistribute it
* under certain conditions of GPL v3 license.
*
***************************************************************
"@

# Set variables
$nmlc = "$pwd\..\nmlc.exe"
$tar = "$pwd\utils\7z\7za.exe"
$src = "$pwd\src"
Get-Content "$src\custom_tags-base.txt" | Set-Content "$src\custom_tags.txt"
$version = Select-String "VERSION" "$pwd\src\custom_tags.txt" -ca | select -exp line | %{$_.split(":")[1]}
$name = "bg_names"
$build = "Bulgarian_Town_Names-$version"
$release = "$pwd\build\$build"

# Set start stopwatch
$sw = new-object System.Diagnostics.Stopwatch
$sw.Start()

# Create folder
Write-Host "`n *** Creating folder: \build\$build `n"
New-Item "$release" -ItemType Dir > $null

# Building
Write-Host "`n *** Building from the source, please wait... `n"
$args = @{
	grf = "--grf=$release\$name.grf";
	tags = "--custom-tags=$src\custom_tags.txt";
	lang = "--lang-dir=$src\lang";
	nml = "$src\$name.nml";
	verb = "--verbosity=4"
}
Invoke-Expression "$nmlc $($args.grf) $($args.tags) $($args.lang) $($args.nml) $($args.verb)"

# Copy files
Copy-Item -Path "$pwd\docs\*" -Destination "$release"
Copy-Item -Path "$pwd\LICENSE" -Destination "$release\license.txt"

# Create TAR archive
Write-Host "`n *** Creating archive: $release.tar `n"
Invoke-Expression "$tar a $release.tar $release" > $null

# Cleanup files and dirs
if (Test-Path "$release.tar")
{
	Remove-Item "$pwd\.nmlcache", "$release", "$src\custom_tags.txt" -Recurse
}

# Set stop stopwatch
$sw.Stop()
Write-Host "`n Building finished in" $sw.Elapsed.TotalSeconds "seconds `n"

# Finish
Write-Host @"
`n********************** Building finished ********************** `n
To install copy the NewGRF archive to the OpenTTD NewGRF directory: `n
 * C:\My Documents\newgrf (Win 95, 98, ME)
 * C:\Documents and Settings\<username>\My Documents\OpenTTD\newgrf (Win 2000, XP)
 * C:\Users\<username>\Documents\OpenTTD\newgrf (Win Vista, 7, 8, 8.1, 10)
 * \OpenTTDPortable\Data\OpenTTD\newgrf (Portable version) `n
"@

# Pause
cmd /c pause
