# ubnt_platform_mgmt - UBNT Platform Management Ansible Roll
------------------

An ansible role for managing and providing advanced configuration of [UBNT](https://ubnt.com) [EdgeMAX](https://www.ubnt.com/products/#edgemax) and [UniFI](https://www.ubnt.com/products/#unifi) Network Devices.

## Description
--------------

After doing some research I realized there's a bunch fo scattered material for automating management and taking advantage of the functionatly of these great network devices.
The goal is to consolidate that information and simplify the extension of the core platform to enable things like LetsEncrypt, Easy OpenVPN Connectivity, OSPF, MPLS and Other Advanced Configures.

## Features
-----------

A list features based on the research included here I'm hoping to implement.

| Feature | Ansible Controller | [UniFI CloudKey](https://www.ubnt.com/unifi/unifi-cloud-key/) | [USG4P](https://www.ubnt.com/unifi-routing/unifi-security-gateway-pro-4/) | [USG](https://www.ubnt.com/unifi-routing/usg/) | [EdgeRouterX](https://www.ubnt.com/edgemax/edgerouter-x/) |
| --- | --- | --- | --- | --- | --- |
| [unifi_controller_facts](https://github.com/ppouliot/ansible_module-unifi_controller_facts) | Library | | | |
| Install SSH Keys | | | | | |
| SSH No Passwd Auth | | | | | |
| [LetsEncrypt](https://letsencrypt.org) | | | | | |
| [get-EdgeSwitch-config.sh](templates/get-EdgeSwitch-config.sh.j2) | | | | | | Template Only |


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

## Resources

### Security

* [https://networkjutsu.com/hardening-edgerouter-lite-part-1/](https://networkjutsu.com/hardening-edgerouter-lite-part-1/)
* [https://miketabor.com/enable-ssh-auto-login-ubiquiti-edgerouter-x/](https://miketabor.com/enable-ssh-auto-login-ubiquiti-edgerouter-x/)
* [https://community.ubnt.com/t5/EdgeRouter/ssh-authorized-keys/td-p/458361](https://community.ubnt.com/t5/EdgeRouter/ssh-authorized-keys/td-p/458361)
* [https://community.ubnt.com/t5/UniFi-Stories/Adding-Let-s-Encrypt-certificate-to-UniFi-Cloud-Key-without/cns-p/2222363](https://community.ubnt.com/t5/UniFi-Stories/Adding-Let-s-Encrypt-certificate-to-UniFi-Cloud-Key-without/cns-p/2222363)
* [https://github.com/Ar0xA/USG-DNS-ADBLOCK](https://github.com/Ar0xA/USG-DNS-ADBLOCK)
* [https://github.com/amarcu5/EdgeOS-Blacklist](https://github.com/amarcu5/EdgeOS-Blacklist)

### Cloud DNS

* [Update AWS Route53](https://github.com/claytono/edgerouter-ansible)
* [Install cloudflared on UniFI Controller](https://github.com/Twanislas/ubnt-cloudflared)

### API
* [https://github.com/Art-of-WiFi/UniFi-API-client/](https://github.com/Art-of-WiFi/UniFi-API-client/)
* [https://github.com/tbyehl/edgerouter-backup](https://github.com/tbyehl/edgerouter-backup)
* [https://github.com/syncloudsoft/unifi-client](https://github.com/syncloudsoft/unifi-client)
* [https://github.com/hobbyquaker/unifi2mqtt](https://github.com/hobbyquaker/unifi2mqtt)

* [https://github.com/FierceSoftware/ansible_modules/tree/master/unifi_controller_facts](https://github.com/FierceSoftware/ansible_modules/tree/master/unifi_controller_facts)


### Captive Portal/Wifi Addons
* [https://github.com/davidmaitland/unifi-voucher-generator](https://github.com/davidmaitland/unifi-voucher-generator)

### Scripts
* [https://github.com/stevejenkins/unifi-linux-utils](https://github.com/stevejenkins/unifi-linux-utils)
* [https://github.com/mindc/ubiquiti](https://github.com/mindc/ubiquiti)
* [https://github.com/oldsj/edgerouter-automation](https://github.com/oldsj/edgerouter-automation)
* [https://github.com/brianredbeard/edgeos_setup](https://github.com/brianredbeard/edgeos_setup)
* [kenmoini/unifi_controller_facts](https://github.com/kenmoini/ansible_modules/tree/master/unifi_controller_facts)



### Backup

* [https://github.com/tbyehl/edgerouter-backup](https://github.com/tbyehl/edgerouter-backup)

### Monitoring & Alerting

* [Nagios Plugin to check Unifi Controller](https://github.com/msweetser/check_unifi)
* [Sensu plugin that polls metrics from UBNT Unifi wireless controllers](https://github.com/sensu-plugins/sensu-plugins-ubiquiti)
* [Collect your Unifi Controller Data and send it to an InfluxDB instance. Grafana dashboards included](https://github.com/davidnewhall/unifi-poller)
* [Periodic monitoring of UBNT EdgeRouter metrics not otherwise available via SNMP and logging to InfluxDB/Grafana](https://github.com/WaterByWind/monitoring-utilities)
* [Simple web server that connects to a Ubiquiti Edge Router to show who is using a substantial amount of data](https://github.com/declanwoods/WhosTheHog)

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
