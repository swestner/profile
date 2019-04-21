#install chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
#(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex

chocolatey feature enable -n allowGlobalConfirmation

cinst diffmerge
cinst fiddler
cinst Firefox
cinst google-chrome-x64
cinst mRemoteNG
cinst git
cinst nodejs.install
cinst notepadplusplus.install
cinst nuget.commandline
cinst psget
cinst python2
cinst ruby
cinst skype
cinst slack
cinst webpi
cinst webpicmd
cinst vim-dwiw2015
cinst 7zip.install
cinst visualstudiocode

#cinst MsSqlServerManagementStudio2014Express
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module posh-git -Startup:

Install-Module -Name posh-azurecli 
Install-AzureCliCompletion

npm i azure-cli -g
npm i ionic -g
npm i pull-report -g
npm i tsc -g
npm i typings -g
npm i webpack -g
npm i webpack-cli -g
npm i yo -g

