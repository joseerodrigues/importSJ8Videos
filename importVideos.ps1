function copyFromDrive([string]$driveLetter, [string]$destDir)
{
    $localVideoDir = $destDir + "\" + (Get-Date).ToString("dd-MM-yyyy - new")     
    $videoDir = $driveLetter + ":\DCIM\100MEDIA"

    if ( Test-Path -Path $videoDir -PathType Container ) { 
        "Found videos in " + $videoDir

        if (-not (Test-Path -Path $localVideoDir -PathType Container)){
            mkdir $localVideoDir
        }        

        $exclude = @('*.LRV','*.THM')
        Copy-Item -Path ($videoDir + "\*") -Destination $localVideoDir -Exclude $exclude
    }
}

function main(){
    $drives = (Get-PSDrive).Name -match '^[a-z]$'
    $current_dir = Get-Location

    foreach ($drive in $drives) {
        copyFromDrive $drive $current_dir
    }
}

#---
main