# IMPORTANT: Before running this script, you might need to change the PowerShell execution policy.
# Open PowerShell as Administrator and run the following command:
# Set-ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
# This allows the script to run if it was downloaded from the internet.
# Use 'Get-ExecutionPolicy -List' to check current policies.

# Windows 11 Initial Setup Script
# This script performs initial configurations, installs Chocolatey, essential software packages,
# enables features like WSL and Telnet, installs runtimes and development tools,
# and initiates the installation of some applications via winget or Microsoft Store.
# Must be run as Administrator immediately after a clean operating system installation.

# Run PowerShell as Administrator
Write-Host "==> Checking for administrator permissions..."
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "This script requires administrator permissions. Please run it again as administrator."
    exit 1
}
Write-Host "Administrator permissions verified successfully."

# 0. Check Windows version
Write-Host "==> Checking Windows version..."
$osVersion = (Get-ComputerInfo).WindowsProductName
if ($osVersion -notlike "*Windows 11 Pro*") {
    Write-Warning "This script is primarily designed for Windows 11 Pro. Current version detected: $osVersion"
    Write-Warning "Some features may not work as expected on other versions."
} else {
    Write-Host "Windows 11 Pro version detected. Continuing..."
}

# 1. Check for pending reboot and abort script if any
Write-Host "==> Checking for pending reboots..."
$rebootPendingCBS = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -ErrorAction SilentlyContinue
$rebootPendingWU = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -ErrorAction SilentlyContinue

if ($rebootPendingCBS -or $rebootPendingWU) {
    Write-Warning "A pending reboot has been detected on the system."
    Write-Warning "Please restart the computer before running this script to avoid issues."
    exit 1
}
Write-Host "No pending reboots detected."

# 2. Detect operating system architecture (more reliable)
Write-Host "==> Detecting operating system architecture..."
$arch = if ([Environment]::Is64BitOperatingSystem) { "x64" } else { "x86" }
Write-Host "Detected architecture: $arch"

# 3. Install Chocolatey if not installed
Write-Host "==> Checking for Chocolatey installation..."
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey not found. Initiating installation..."
    Set-ExecutionPolicy Bypass -Scope Process -Force -ErrorAction SilentlyContinue
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    try {
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        Write-Host "Chocolatey installed successfully."
        # Reloads the PATH environment variable for the current session
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    } catch {
        Write-Error "Failed to install Chocolatey: $($_.Exception.Message)"
        exit 1
    }
} else {
    Write-Host "Chocolatey already installed. Checking for updates..."
    choco upgrade chocolatey -y
    Write-Host "Chocolatey is ready to use and up to date."
}

# Enable global confirmation feature in Chocolatey
choco feature enable -n allowGlobalConfirmation

# 4. Update all applications via winget
Write-Host "==> Updating all applications via winget (including unknown)..."
try {
    winget upgrade --all --include-unknown --accept-package-agreements --accept-source-agreements -h
    Write-Host "Application update via winget completed."
} catch {
    Write-Warning "Failed to run winget upgrade. Check if winget is installed and configured correctly. Error: $($_.Exception.Message)"
}

# 5. Enable Telnet Client
Write-Host "==> Enabling Telnet Client..."
try {
    dism.exe /online /enable-feature /featurename:TelnetClient /all /norestart
    Write-Host "Telnet Client enabled."
} catch {
    Write-Warning "Failed to enable Telnet Client. Error: $($_.Exception.Message)"
}

# 6. Enable WSL, Hyper-v and Virtual Machine Platform
Write-Host "==> Enabling Windows Subsystem for Linux (WSL), Virtual Machine Platform, and Hyper-V..."
try {
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart
    Write-Host "WSL, Virtual Machine Platform, and Hyper-V enabled."
    Write-Warning "A system restart is required for these changes to take effect."
} catch {
    Write-Warning "Failed to enable WSL, Virtual Machine Platform, and/or Hyper-V. Error: $($_.Exception.Message)"
}

# 7. Install Ubuntu via WSL
Write-Host "==> Installing Ubuntu via WSL..."
Write-Warning "This step may take time and requires an internet connection."
try {
    wsl.exe --install -d Ubuntu-24.04
    Write-Host "Ubuntu installation via WSL initiated."
} catch {
    Write-Warning "Failed to initiate Ubuntu installation. Check if WSL was enabled correctly. Error: $($_.Exception.Message)"
}

# 8. Install essential runtimes via Chocolatey
Write-Host "==> Installing .NET Desktop and Visual C++ Redistributable runtimes..."
try {
    choco install dotnet-desktopruntime vcredist140 dotnet-6.0-desktopruntime -y --force-dependencies
    Write-Host "Essential runtimes installed successfully."
} catch {
    Write-Warning "Failed to install essential runtimes. Error: $($_.Exception.Message)"
}

# 9. CONSOLIDATED PACKAGE INSTALLATION
Write-Host "==> Preparing list of packages to install..."
$packagesToInstall = @(
    # Games
    # "discord",
    # "epicgameslauncher",
    # "steam",

    # Work
    "slack",
    "microsoft-teams-new-bootstrapper",
    "microsoftazurestorageexplorer",
    "zoom",

    # DevOps/SRE
    "vscode",
    "git",
    "terraform",
    "vagrant",
    "azurepowershell",
    "azure-cli",
    "awscli",
    "docker-desktop",
    "argocd-cli",
    "k9s",
    "kubernetes-helm"

    # Personal & Others
    "webview2-runtime",
    "googlechrome",
    "googledrive",    
    "flameshot",
    "powertoys",
    "rdm",
    "notion",
    "obs-studio",
    "sublimetext4",
    "oh-my-posh",
    "ccleaner",
    "nvidia-display-driver",
    "nvidia-app",
    "treesizefree" 
)

# Add architecture-specific packages to the list
if ($arch -eq "x64") {
    $packagesToInstall += "virtualbox"
}

Write-Host "==> Starting installation of all selected packages..."
foreach ($package in $packagesToInstall) {
    Write-Host "--- Installing $package ---"
    try {
        $chocoArgs = @('install', $package, '-y', '--force', '--force-dependencies')

        if ($package -in @("notion", "googledrive", "microsoftazurestorageexplorer")) {
            $chocoArgs += '--ignore-checksums'
        }

        choco @chocoArgs

        Write-Host "$package installed successfully."
    } catch {
        Write-Warning "Failed to install package $package. Error: $($_.Exception.Message)"
    }
}

# 10. Update winget (App Installer) itself
Write-Host "==> Updating winget (App Installer)..."
try {
    winget upgrade --id Microsoft.DesktopAppInstaller --accept-package-agreements --accept-source-agreements -h
    Write-Host "winget update completed."
} catch {
    Write-Warning "Failed to update winget. Error: $($_.Exception.Message)"
}

# 11. Install WhatsApp via Microsoft Store (manual interaction)
Write-Host "==> Opening Microsoft Store to install WhatsApp..."
Write-Host "Please complete the installation manually in the Store window."
try {
    Start-Process "ms-windows-store://pdp/?productid=9nksqgp7f2nh"
    Write-Host "Microsoft Store opened for WhatsApp installation."
} catch {
    Write-Warning "Failed to open the Microsoft Store. Please open it manually and search for 'WhatsApp'. Error: $($_.Exception.Message)"
}

# 12. Check and install PowerShell 7
Write-Host "==> Checking if PowerShell 7 (pwsh) is installed..."
if (-not (Get-Command pwsh -ErrorAction SilentlyContinue)) {
    Write-Host "PowerShell 7 not found. Installing via winget..."
    try {
        winget install --id Microsoft.PowerShell --source winget --accept-package-agreements --accept-source-agreements -h
        Write-Host "PowerShell 7 installation requested."
    } catch {
        Write-Warning "Failed to install PowerShell 7 via winget. Error: $($_.Exception.Message)"
    }
} else {
    Write-Host "PowerShell 7 (pwsh) is already installed."
}

# Final message
Write-Host ""
Write-Host "=======================================================" -ForegroundColor Green
Write-Host "  SETUP SCRIPT FINISHED!" -ForegroundColor Green
Write-Host "=======================================================" -ForegroundColor Green
Write-Host ""
Write-Host "ATTENTION:" -ForegroundColor Yellow
Write-Host "- A system RESTART is HIGHLY recommended to apply all changes."
Write-Host "- Complete the WhatsApp installation from the Microsoft Store if you haven't already."
Write-Host ""Write-Host "Thank you for using this setup script!" -ForegroundColor Green


