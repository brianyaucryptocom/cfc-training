# Lab 1.1 - Host identification

- [Lab 1.1 - Host identification](#lab-11---host-identification)
  - [Introduction](#introduction)
  - [1 - Identify Network Usage](#1---identify-network-usage)

---

## Introduction

In this lab, you are going to investigate a Windows host, which is reported to be suspicious. Before starting the lab, double click the file in `C:\Users\Administrator\Desktop\payloads\lab1.1\Lab1-Initialize.bat`

![](images/lab-1-1-00.png)

<br/>

---

## 1 - Identify Network Usage

**Task**

- Use `netstat` to check the network usage of the host.
- Find out any unusual network usage

<br/>

<details>
  <summary>**Click to reveal the solution**</summary>

  This first part is a proof-of-concept, which shows you show the Windows commands in this exercise can reveal a listening port and the corresponding process. 

  You can use `netstat` for checking network usage on a Windows host.

  As a baseline, first run `cmd.exe` as admin, and then run `netstat -na`:

  ![01](images/lab-1-1-01.png)

  <br/>

  Next, create a netcat listener on the host. Use the command prompt and enter the following commands:

  - `ubuntu2004`
  - `nc -lp 10000`

  ![02](images/lab-1-1-02.png)

  This command will run in a Ubuntu container and create a TCP listener on tcp/10000.

  <br/>

  Then again, run `netstat -na`:

  ![03](images/lab-1-1-03.png)

  <br/>

  We can also check the process ID for the executables using the TCP/UDP ports using `netstat -ano`:

  ![04](images/lab-1-1-04.png)

  <br/>

  You can also run `netstat -nao 5` to make it refreshes every 5 seconds.

  <br/>

  Next, run `netstat -naob` to see the EXE and DLLs associated with each listening port.

  ![05](images/lab-1-1-05.png)

  <br/>

  As you can see in this exercise, the Ubuntu container's listening port `tcp/10000` is revealed.

  <br/>

  Additionally, you will notice there are some unusual network connections:

  1. `ChromeUpdate.exe` listening on `tcp/2222`
  2. `WindowsDefender.exe` having a connection to `172.31.15.180:4444`

  At this point, you have already identified abnormal network usage on the host.

  <br/>


  You may close all of the command prompts after this.

</details>

<br/>

---