Introduction
============

ALPS Gateway

Developed By Anas Muhammad Tukur
------------------------------
**Authored BY Anas Muhammad Tukur**

```
import this file into Virtual Box routeros-x86-6.0.ova
File - Import Applicances
Re-initialize all mac address
Settings - Nework - Enable Adapter 1 and 2
Adapter 1 = Bridge Adapter - en0 wifi
Adapter 2 = Bridge Adapter - en1 lan

Start the vm
Login=admin, password BLANK

interface print
/interface enable ether2
/interface enable ether3
/ip address add address=192.168.0.100/24 interface=ether2
/ip service enable ssh
/ip service enable api
/ip service enable ftp
/ip service enable www

ssh admin@192.168.0.100

/ip address add address=10.0.0.10/24 interface=ether1



system reset-configuration
interface print
/interface enable ether2
/ip address add address=172.17.8.1/24 interface=ether2
/ip service enable ssh



interface enable ether2
interface enable ether3

/ip address add address=192.168.0.10/24 interface=ether3
/ip address add address=10.0.0.10/24 interface=ether1


MIKROTIK SNIPPETS
Open Virtualbox
File - Import Apliance
select routeros-x86-6.0.ova
Re-Initialzed the mac address
Settings - Network
Adapter 3 - Enable Network Adapter - Host-only Adapter - vboxnet0
Adapter 4 - Enable Network Adapter - Host-only Adapter - vboxnet1
Start the VM
login=admin, password=<BLANK>

vboxnet0 = 172.17.8.1

system reset

interface print
ether4 = 172.17.8.1
ether5 = 192.168.59.3

/ip address add address=172.17.8.100/24 interface=ether2
/ip service enable ssh
ssh admin@172.17.8.100

/ip service enable ftp
/ip service enable api
/ip address add address=192.168.59.100/24 interface=ether3

