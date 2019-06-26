import-module posh-docker
Import-Module persistenthistory

set-alias npp "\Program Files\Notepad++\notepad++.exe"
set-alias ex explorer.exe
set-alias ss select-string
set-alias d dir
set-alias doc docker.exe
set-alias kbl kubectl.exe
set-alias kb kubectl.exe


$cc = "careercruising"
$ccgit = "https://github.com/CareerCruising"
Remove-Item alias:curl

$curlFormat = "time_namelookup:  %{time_namelookup}`n"
$curlFormat += "time_connect:  %{time_connect}`n"
$curlFormat += "time_appconnect:  %{time_appconnect}`n"
$curlFormat += "time_pretransfer:  %{time_pretransfer}`n"
$curlFormat += "time_redirect:  %{time_redirect}`n"
$curlFormat += "time_starttransfer:  %{time_starttransfer}`n"
$curlFormat += "----------`n"
$curlFormat += "time_total:  %{time_total}`n"


Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
	param($commandName, $wordToComplete, $cursorPosition)
	        
	dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
		[System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
	}
}


function path{
	$env:path.split(";");
}


function crr($repo){

	$gitAddress = $repo
		$dir = $repo

		if($gitAddress -notmatch 'github.com'){
			$gitAddress = "https://github.com/careercruising/$repo"	
		}
		else{
			$dir = split-path $dir -leaf		
		}

	write-output "repository : $gitaddress"
		write-output "directory : $dir"

		md $dir
		cd $dir
		git init
		git remote add origin $gitAddress
		git fetch
		git pull origin master
}



function dd{
	Param([String] $folder)
		$tempdir = [system.guid]::newguid().tostring()
		$tempdir = 'c:\' + $tempdir
		md $tempdir | Out-Null

		robocopy $tempdir $folder /mir /njh /njs /ndl /nc /ns | Out-Null
		del $folder -force -recurse | Out-Null
		del $tempdir -force | Out-Null
		write 'done!'
}


function trigger{

	Param($branch, $remote)


		if(!$branch){
			$branch = (git rev-parse --abbrev-ref HEAD)
		}

	if(!$remote){
		$remote = (git remote)
	}

	$file = './test.txt';

	if(!(test-path $file)){
		ni $file -type file
			git add --all
	}
	else
	{
		ri $file
	}

	git commit -am 'test trigger'
		git push $remote $branch

}

function prr{
	get-date
		if(-not (npm list --depth=0 -g | select-string "pull-report")){
			npm install pull-report -g
		}

	$netrc = "$home\_netrc"
		$regex = '(?:.*login\s)([^\r\n$]+)[\r\n$]*.*password\s([^\r\n$]+)'

		if([IO.File]::ReadAllText($netrc) -match $regex){
			$user = $matches[1]
				$pass = $matches[2]
		}

	pull-report --org CareerCruising --gh-user $user --gh-pass $pass
}


function add-path{
	Param([String] $path)

		if(!(test-path $path -pathType container)){
			return "$path is not a folder"
		}

	$Env:Path += ";$path"

		[System.Environment]::SetEnvironmentVariable("PATH", $Env:Path, "Machine")


}


function git-report{
	dir \workspace  -directory | % {git --git-dir=\workspace\$_\.git --work-tree=\workspace\$_ status}
}

function install-toggl{

	if(!(test-path /tools/toggl-cli -pathType container)){
		git clone "https://github.com/drobertadams/toggl-cli.git" "/tools/toggl-cli"
			$env:path += ";C:\tools\python2;C:\tools\python2\Scripts"
			cinst pip
			pip install iso8601 pytz requests python-dateutil
			python /tools/toggl-cli/toggl.py > $null
			write-output "dont forget to update ~/.togglrc"

			if($env:path -notmatch '/tools/toggl-cli'){
				add-path "/tools/toggl-cli"
			}
#new-item "/tools/toggl-cli/tg.bat" -force | out-null
		set-content /tools/toggl-cli/tg.bat "@echo off`npython /tools/toggl-cli/toggl.py %*" -Encoding ASCII 
	}

}

function Set-OctoConn{
	Set-OctopusConnectionInfo -URL "http://cd.careercruising.com" -APIKey "API-BC7PU0QPDBDJLPUAWKCXH6VU4"
}                                            

function Wait-OctoDeploy{                                                                        
	param([string]$project)                                                                  

		while(1){                                                                                
			$v = Get-OctopusDashboard -ProjectName $project;                                 
			if($v.IsCompleted -eq 'True'){                                                   
				Write-Output "done!"                                                     
				$v                                                                       
				break                                                                    
			};                                                                               

			write-output 'still running'; sleep 10}                                          


	}   

function jenkins{

	$jenkins_url = Get-Variable -Name jenkins_url -ErrorAction SilentlyContinue -ValueOnly

	if(!$jenkins_url){
		$jenkins_url = 'http://ci.careercruising.com:8080/'
		Set-Variable -Name jenkins_url -Value  $jenkins_url -Scope global
	}

	$jenkins_auth = Get-Variable -Name jenkins_auth -ErrorAction SilentlyContinue -ValueOnly

	if(!$jenkins_auth){
		if(!$jenkins_name){
			$jenkins_name = Read-Host -Prompt "Enter Name"
		}

		if(!$jenkins_password){
			$p = Read-Host -Prompt "Enter Password" -AsSecure
			$jenkins_password = [System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($p)) 
		}

		$jenkins_auth = "${jenkins_name}:${jenkins_password}"
		Set-Variable -Name "jenkins_auth" -Value $jenkins_url -Scope global
	}

	Write-Output "java -jar c:\tools\jenkins\jenkins-cli.jar -auth $jenkins_auth -s $jenkins_url @args"
	java -jar "c:\tools\jenkins\jenkins-cli.jar" -auth $jenkins_auth -s $jenkins_url @args
}


Function locks 
{
    	Param
    	(
	[Parameter(Mandatory=$true)]
	[String] $FileOrFolderPath
	)
	
	IF((Test-Path -Path $FileOrFolderPath) -eq $false) {
		Write-Warning "File or directory does not exist."       
	}
	Else {
		$LockingProcess = CMD /C "openfiles /query /fo table | find /I ""$FileOrFolderPath"""
		Write-Host $LockingProcess
	}
									  
	
}


install-toggl



# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
}

# Load posh-azurecli example profile
Import-Module posh-azurecli


$buildOctoVars = @{
	
version = "0.0.058"                                                                                 
root = "C:\Jenkins\jobs\CC3.API.Branch\workspace"                                                
octo_channel = "QA"                                                                                      
build_config  =  "Octo"     
	
}

$buildLibVars = @{                              
	                                                 
  version = "0.0.000"                              
  root = "C:\workspace\cc.common"
  build_config  =  "Release"                          
							                                                  
}                                                
