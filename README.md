# Ansible Role: ubnt_platform_mgmt
------------------

An ansible role for managing and providing advanced configuration of [UBNT](https://ubnt.com) [EdgeMAX](https://www.ubnt.com/products/#edgemax) and [UniFI](https://www.ubnt.com/products/#unifi) Network Devices.

## Description
--------------

After doing some research I realized there's a bunch fo scattered material for automating management and taking advantage of the functionatly of these great network devices.
The goal is to consolidate that information and simplify the extension of the core platform to enable things like LetsEncrypt, Easy OpenVPN Connectivity, OSPF, MPLS and Other Advanced Configures.


| UBNT Device | Install SSH Keys | SSH No Passwd Auth | [LetsEncrypt](https://letsencrypt.org) |
| --- | --- | --- | --- |
| [UniFI CloudKey](https://www.ubnt.com/unifi/unifi-cloud-key/) | | | |
| [USG4P](https://www.ubnt.com/unifi-routing/unifi-security-gateway-pro-4/) | | | |
| [USG](https://www.ubnt.com/unifi-routing/usg/) | | | |
| [EdgeRouterX](https://www.ubnt.com/edgemax/edgerouter-x/) | | | |


## Requirements
------------------

Some UBNT (EdgeRouter/UniFI) Devices to Manage. 

* [unifi_controller_facts](https://github.com/ppouliot/ansible_module-unifi_controller_facts)


## Role Variables
------------------

### Install SSH Authorized Keys
Provide the location for the SSH keys that will be installed for SSH key based authentication to the ubnt device.

```
ubnt_ssh_authorized_key: ~/.ssh/id_ed25519.pub
```

### AWS Route53 DNS Update

AWS Credentials and additional information needed for updating Route53 information.
This is currently untested.

Example Variables:

```
aws_access_key_id: < AWS_ACCESS_KEY_ID >
aws_secret_access_key: < AWS_SECRET_ACCESS_KEY >
aws_route53_domain: pouliot.net
aws_route53_network: 192.168.1.0/24
aws_route53_syslog_facility: local7
aws_route53_exclude_host: nothisone.pouliot.net

```
### Get EdgeSwitch Config
Script template to get ERX config.
* [get-EdgeSwitch-config.sh](templates/get-EdgeSwitch-config.sh.j2)

## Example Playbook
Here is a non-working  example of typical usage.


```
- hosts: localhost
  gather_facts: True
  roles:
    - ppouliot.ubnt_platform_mgmt
```

## Links
* [https://networkjutsu.com/hardening-edgerouter-lite-part-1/](https://networkjutsu.com/hardening-edgerouter-lite-part-1/)
* [https://miketabor.com/enable-ssh-auto-login-ubiquiti-edgerouter-x/](https://miketabor.com/enable-ssh-auto-login-ubiquiti-edgerouter-x/)
* [https://community.ubnt.com/t5/EdgeRouter/ssh-authorized-keys/td-p/458361](https://community.ubnt.com/t5/EdgeRouter/ssh-authorized-keys/td-p/458361)
* [https://github.com/claytono/edgerouter-ansible](https://github.com/claytono/edgerouter-ansible)
* [https://community.ubnt.com/t5/UniFi-Stories/Adding-Let-s-Encrypt-certificate-to-UniFi-Cloud-Key-without/cns-p/2222363](https://community.ubnt.com/t5/UniFi-Stories/Adding-Let-s-Encrypt-certificate-to-UniFi-Cloud-Key-without/cns-p/2222363)
* [https://github.com/Art-of-WiFi/UniFi-API-client/](https://github.com/Art-of-WiFi/UniFi-API-client/)
* [https://github.com/FierceSoftware/ansible_modules/tree/master/unifi_controller_facts](https://github.com/FierceSoftware/ansible_modules/tree/master/unifi_controller_facts)
* [https://github.com/declanwoods/WhosTheHog](https://github.com/declanwoods/WhosTheHog)
* [https://github.com/mindc/ubiquiti](https://github.com/mindc/ubiquiti)
* [https://github.com/davidnewhall/unifi-poller](https://github.com/davidnewhall/unifi-poller)
* [https://github.com/sensu-plugins/sensu-plugins-ubiquiti](https://github.com/sensu-plugins/sensu-plugins-ubiquiti)
* [https://github.com/oldsj/edgerouter-automation](https://github.com/oldsj/edgerouter-automation)

## Contributors
------------

 * Peter Pouliot <peter@pouliot.net>

## Copyright and License
---------------------

Copyright (C) 2018 Peter J. Pouliot

Peter Pouliot can be contacted at: peter@pouliot.net

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
