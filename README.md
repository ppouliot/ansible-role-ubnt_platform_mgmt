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

| Feature | Ansible | [UniFI CloudKey](https://www.ubnt.com/unifi/unifi-cloud-key/) | [USG4P](https://www.ubnt.com/unifi-routing/unifi-security-gateway-pro-4/) | [USG](https://www.ubnt.com/unifi-routing/usg/) | [EdgeRouterX](https://www.ubnt.com/edgemax/edgerouter-x/) |
| --- | --- | --- | --- | --- | --- |
| unifi_controller_facts | [ansible library](https://github.com/ppouliot/ansible_module-unifi_controller_facts) | [*](tasks/all_unifi_controller_facts.yml) | | |
| Install SSH Keys | [ansible role](https://github.com/ppouliot/ansible-role-ubnt_device_bootstrap) | untested | tested | tested| tested |
| SSH No Passwd Auth | task | | | | |
| [LetsEncrypt](https://letsencrypt.org) | [task](tasks/letsencrypt_acme.yml) | | | | |
| Get EdgeSwitch Config | [template](templates/get-EdgeSwitch-config.sh.j2) | n/a | n/a | n/a | untested |
| AWS Route53 DNS Update | [task](tasks/install_sync-hosts-to-route53_binary.yml) | Untested | n/a | n/a | n/a |


## Requirements
------------------

* Some UBNT (EdgeRouter/UniFI) Devices to Manage. 
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

## Cloudflared on Unifi/EdgeRouter Devices

### Building Cloudflared for Unifi USG

```
docker run \
  --rm \
  -v ${PWD}:/usr/src/myapp \
  -w /usr/src/myapp \
  -e GOOS=linux \
  -e GOARCH=mips64 \
  golang bash -c "go get -v github.com/cloudflare/cloudflared/cmd/cloudflared ; GOOS=linux GOARCH=mips64 go build -ldflags='-s -w' -v -x github.com/cloudflare/cloudflared/cmd/cloudflared "
```

### Building Cloudflared for Unifi EdgeRouterX

```
docker run \
  --rm \
  -v ${PWD}:/usr/src/myapp \
  -w /usr/src/myapp \
  -e GOOS=linux \
  -e GOARCH=mipsle \
  golang bash -c "go get -v github.com/cloudflare/cloudflared/cmd/cloudflared ; GOOS=linux GOARCH=mipsle go build -ldflags='-s -w' -v -x github.com/cloudflare/cloudflared/cmd/cloudflared"
```

## Pixiecore on Unifi/Edgerouter Devices

### Building Pixiecore for Unifi USG

```
docker run \
  --rm \
  -v ${PWD}:/usr/src/myapp \
  -w /usr/src/myapp \
  -e GOOS=linux \
  -e GOARCH=mips64 \
  golang bash -c "go get -v go.universe.tf/netboot/cmd/pixiecore ; GOOS=linux GOARCH=mips64 go build -ldflags='-s -w' -v -x go.universe.tf/netboot/cmd/pixiecore"
```

### Building Pixiecore for Unifi EdgeRouterX

```
docker run \
  --rm \
  -v ${PWD}:/usr/src/myapp \
  -w /usr/src/myapp \
  -e GOOS=linux \
  -e GOARCH=mipsle \
  golang bash -c "go get -v go.universe.tf/netboot/cmd/pixiecore ; GOOS=linux GOARCH=mipsle go build -ldflags='-s -w' -v -x go.universe.tf/netboot/cmd/pixiecore"
```

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
* [https://github.com/britannic/blacklist](https://github.com/britannic/blacklist)
* [https://github.com/Ar0xA/USG-DNS-ADBLOCK](https://github.com/Ar0xA/USG-DNS-ADBLOCK)
* [https://bendews.com/posts/implement-dns-over-https/](https://bendews.com/posts/implement-dns-over-https/)
* [https://github.com/j-c-m/ubnt-letsencrypt](https://github.com/j-c-m/ubnt-letsencrypt)
* [https://github.com/neilalexander/vyatta-cjdns](https://github.com/neilalexander/vyatta-cjdns)
* [https://github.com/bettermanbao/erx-shadowsocks-libev](https://github.com/bettermanbao/erx-shadowsocks-libev)
* [https://github.com/cmur2/vyatta-sixxs](https://github.com/cmur2/vyatta-sixxs)
* [A Pi-hole equivalent for the Unifi Security Gateway](https://github.com/ndfred/unifi-pi-hole)
* [pi-hole conditional forwarding and unifi networking](https://www.devwithimagination.com/2019/03/17/pi-hole-conditional-forwarding-and-unifi-networking/)
* [catching naughty devices on my home network](https://scotthelme.co.uk/catching-naughty-devices-on-my-home-network/)
* [https://github.com/brontide/usg-blacklist](https://github.com/brontide/usg-blacklist)

### VPN

* [Pritunl to USG/Unifi](https://docs.pritunl.com/docs/ubiquiti-unifi)
* [https://community.ubnt.com/t5/UniFi-Routing-Switching/OpenVPN-to-Pritunl-using-USG/td-p/2161699](https://community.ubnt.com/t5/UniFi-Routing-Switching/OpenVPN-to-Pritunl-using-USG/td-p/2161699)
* [https://github.com/mafredri/vyatta-wireguard-installer](https://github.com/mafredri/vyatta-wireguard-installer)
* [https://github.com/whiskerz007/ubnt_get_wireguard](https://github.com/whiskerz007/ubnt_get_wireguard)



### Routing

* [https://community.ubnt.com/t5/UniFi-Routing-Switching/USG-PRO-4-amp-MPLS-Outbound-routing-works-but-unable-to-reach/td-p/2450723](https://community.ubnt.com/t5/UniFi-Routing-Switching/USG-PRO-4-amp-MPLS-Outbound-routing-works-but-unable-to-reach/td-p/2450723)
* [https://github.com/basmeerman/unifi-usg-kpn](https://github.com/basmeerman/unifi-usg-kpn)
* [How to build a load balancer with BGP and ECMP](https://gist.github.com/bufadu/0c3ba661c141a2176cd048f65430ae8d)

### Cloud DNS

* [Update AWS Route53](https://github.com/claytono/edgerouter-ansible)
* [Install cloudflared on UniFI Controller](https://github.com/Twanislas/ubnt-cloudflared)
* [Cloudflare DynDNS](https://github.com/ncb000gt/unifi-cloudflare-dyndns)
* [https://github.com/Twanislas/ubnt-cloudflared](https://github.com/Twanislas/ubnt-cloudflared)
* [https://khaz.me/cloudflare-ddns-configuration-for-unifi-usg/](https://khaz.me/cloudflare-ddns-configuration-for-unifi-usg/)
* [ubnt_cloudflared](https://github.com/yon2004/ubnt_cloudflared)
* [https://github.com/kchristensen/udm-le](https://github.com/kchristensen/udm-le)


### API
* [https://github.com/Art-of-WiFi/UniFi-API-client/](https://github.com/Art-of-WiFi/UniFi-API-client/)
* [https://github.com/tbyehl/edgerouter-backup](https://github.com/tbyehl/edgerouter-backup)
* [https://github.com/syncloudsoft/unifi-client](https://github.com/syncloudsoft/unifi-client)
* [https://github.com/hobbyquaker/unifi2mqtt](https://github.com/hobbyquaker/unifi2mqtt)
* [https://github.com/jens-maus/node-unifi](https://github.com/jens-maus/node-unifi)
* [https://github.com/KoenZomers/UniFiApi](https://github.com/KoenZomers/UniFiApi)

### Captive Portal/Wifi Addons
* [https://github.com/davidmaitland/unifi-voucher-generator](https://github.com/davidmaitland/unifi-voucher-generator)
* [https://gist.github.com/troyfontaine/43f4a978418b845cdbb117ffe1fd30e8](https://gist.github.com/troyfontaine/43f4a978418b845cdbb117ffe1fd30e8)
* [https://github.com/bsab/django-unifi-portal](https://github.com/bsab/django-unifi-portal)
* [https://github.com/emanuelepaiano/espresso-portal](https://github.com/emanuelepaiano/espresso-portal)
* [https://github.com/SEQUOIIA/unifi-proper-portal](https://github.com/SEQUOIIA/unifi-proper-portal)
* [https://github.com/kaptk2/portal](https://github.com/kaptk2/portal)
* [http://dl.ubnt.com/unifi/3.2.10/portal_sample_paypal.zip](http://dl.ubnt.com/unifi/3.2.10/portal_sample_paypal.zip)
* [https://github.com/PaintSplasher/unifi-voucher-service](https://github.com/PaintSplasher/unifi-voucher-service)
* [
https://github.com/woodjme/unifi-hotspot](https://github.com/woodjme/unifi-hotspot)
* [https://github.com/batesta/whoshere](https://github.com/batesta/whoshere)

### Scripts
* [https://github.com/stevejenkins/unifi-linux-utils](https://github.com/stevejenkins/unifi-linux-utils)
* [https://github.com/oldsj/edgerouter-automation](https://github.com/oldsj/edgerouter-automation)
* [https://github.com/brianredbeard/edgeos_setup](https://github.com/brianredbeard/edgeos_setup)
* [kenmoini/unifi_controller_facts](https://github.com/kenmoini/ansible_modules/tree/master/unifi_controller_facts)
* [https://github.com/btaub/misc-scripts/blob/master/get-EdgeSwitch-config.sh](https://github.com/btaub/misc-scripts/blob/master/get-EdgeSwitch-config.sh)
* [https://github.com/jaysoffian/eap_proxy](https://github.com/jaysoffian/eap_proxy)
* [https://github.com/ubiquiti/eot-controller](https://github.com/ubiquiti/eot-controller)
* [https://github.com/Enatec/UniFiTooling](https://github.com/Enatec/UniFiTooling)
* [https://github.com/martbrooks/unifi_ssl_certs](https://github.com/martbrooks/unifi_ssl_certs)
* [https://github.com/dmbaturin/scripts/blob/master/usg-config-export.py](https://github.com/dmbaturin/scripts/blob/master/usg-config-export.py)
* [https://github.com/msnelling/ansible-unifi](https://github.com/msnelling/ansible-unifi)
* [https://github.com/boostchicken/udm-utilities](https://github.com/boostchicken/udm-utilities)
* [https://github.com/richardhofman/ansible-role-edgerouter/](https://github.com/richardhofman/ansible-role-edgerouter/)
* [Ansible Example w/ Jinja template](https://gist.github.com/dgengtek/4471642fa4e5e46e2f9056b41fd1a63a)

### surveillance tools

* [https://github.com/unifi-toolbox/unifi-protect-video-downloader](https://github.com/unifi-toolbox/unifi-protect-video-downloader)
* [https://github.com/yuppity/unifi-video-api](https://github.com/yuppity/unifi-video-api)
* [https://github.com/petergeneric/unifi-protect-remux](https://github.com/petergeneric/unifi-protect-remux)

### Backup

* [EdgeRouter to git repo backup scripts.](https://github.com/tbyehl/edgerouter-backup)
* [Oxidized](https://github.com/ytti/oxidized)
* [https://github.com/gebn/unifibackup](https://github.com/gebn/unifibackup)
* [https://github.com/zhangyoufu/unifi-backup-decrypt](https://github.com/zhangyoufu/unifi-backup-decrypt)

### Monitoring, Alerting & Logging

* [Nagios Plugin to check Unifi Controller](https://github.com/msweetser/check_unifi)
* [Sensu plugin that polls metrics from UBNT Unifi wireless controllers](https://github.com/sensu-plugins/sensu-plugins-ubiquiti)
* [Collect your Unifi Controller Data and send it to an InfluxDB instance. Grafana dashboards included](https://github.com/davidnewhall/unifi-poller)
* [Periodic monitoring of UBNT EdgeRouter metrics not otherwise available via SNMP and logging to InfluxDB/Grafana](https://github.com/WaterByWind/monitoring-utilities)
* [Simple web server that connects to a Ubiquiti Edge Router to show who is using a substantial amount of data](https://github.com/declanwoods/WhosTheHog)
* [Perl Module to output UBNT info ](https://github.com/mindc/ubiquiti/blob/master/lib/Ubiquiti.pm)
* [https://github.com/mikeder/edgerouter-graylog-extractors](https://github.com/mikeder/edgerouter-graylog-extractors)
* [https://github.com/lowfive/graylog-grok-edgerouter](https://github.com/lowfive/graylog-grok-edgerouter)
* [https://github.com/Graylog2/graylog-guide-ubiquity-unify-ap](https://github.com/Graylog2/graylog-guide-ubiquity-unify-ap)
* [https://github.com/breakandinspect/graylog](https://github.com/breakandinspect/graylog)
* [https://github.com/loganmarchione/graylog-edgerouter-lite](https://github.com/loganmarchione/graylog-edgerouter-lite)
* [https://github.com/edoput/netjsonconfig-airos](https://github.com/edoput/netjsonconfig-airos)
* [https://github.com/WaterByWind/grafana-dashboards](https://github.com/WaterByWind/grafana-dashboards)
* [https://github.com/zbx-sadman/unifi_miner](https://github.com/zbx-sadman/unifi_miner)
* [https://github.com/zbx-sadman/unifi_proxy](https://github.com/zbx-sadman/unifi_proxy)
* [https://github.com/mdlayher/unifi_exporter](https://github.com/mdlayher/unifi_exporter)
* [https://github.com/caglar10ur/elk-usg](https://github.com/caglar10ur/elk-usg)
* [https://github.com/custom-components/sensor.unifigateway](https://github.com/custom-components/sensor.unifigateway)
* [unifi-poller](https://github.com/unifi-poller/unifi-poller)
* [https://github.com/tusc/ntopng-udm](https://github.com/tusc/ntopng-udm)
* [https://github.com/iobroker-community-adapters/ioBroker.unifi](https://github.com/iobroker-community-adapters/ioBroker.unifi)
* [https://github.com/custom-components/sensor.unifigateway](https://github.com/custom-components/sensor.unifigateway)
* [https://github.com/finish06/Unifi-Metrics-Collector](https://github.com/finish06/Unifi-Metrics-Collector)
* [https://github.com/jcoutch/usg-scripts](https://github.com/jcoutch/usg-scripts)
* [https://github.com/Manawyrm/unifirespondd](https://github.com/Manawyrm/unifirespondd)
* [https://github.com/tborychowski/unifi-event-monitor](
https://github.com/tborychowski/unifi-event-monitor)

### Configuration examples & Documentation

* [https://github.com/stevejenkins/UBNT-EdgeRouter-Example-Configs](https://github.com/stevejenkins/UBNT-EdgeRouter-Example-Configs)
* [https://github.com/ekrunch/ubiquiti_unifi_configs](https://github.com/ekrunch/ubiquiti_unifi_configs)
* [https://github.com/psaintemarie/unifi-bytel](https://github.com/psaintemarie/unifi-bytel)
* [https://github.com/TimoDJatomika/EdgeRouter-Stuff](https://github.com/TimoDJatomika/EdgeRouter-Stuff)
* [Vyatta Network OS High Availability](https://ecl.ntt.com/files/firewall/5.2/vyatta-network-os-5.2r1-high-availability-2.pdf)
* [235723207-UniFi-USG-UDM-Port-Forwarding-Configuration-and-Troubleshooting](https://help.ui.com/hc/en-us/articles/235723207-UniFi-USG-UDM-Port-Forwarding-Configuration-and-Troubleshooting)
* [https://github.com/chashtag/unifi-8021x-setup](https://github.com/chashtag/unifi-8021x-setup)


### PiHole Integration

*  [PiHole - Catching and dealing w/ naughty devices](https://scotthelme.co.uk/catching-naughty-devices-on-my-home-network)
* [Unifi Usg dnat rule for pi-hole or other dns redirection](https://www.missingremote.com/guide/2018/07/unifi-usg-dnat-rule-for-pi-hole-or-other-dns-redirection)
* [How To Enable InterVLAN Routing on the UniFi USG](https://community.ui.com/questions/How-To-Enable-InterVLAN-Routing-on-the-UniFi-USG/cf4a4213-6c6c-4002-8db9-faf941bf21d4)
* [Firewall-rules-DNS-blocking-except-for-my-local-Pi-Hole](https://community.ui.com/questions/Firewall-rules-DNS-blocking-except-for-my-local-Pi-Hole/825cdd29-e33b-4460-9eca-fe93d43c62b5)
* [PiHole across VLANs blocking internet traffic SOLVED](https://community.ui.com/questions/PiHole-across-VLANs-blocking-internet-traffic-SOLVED/6b403c9c-ec57-4449-b20b-c16fca99ad96)

### Unifi Data Sheets

* [Unifi Access Points Data Sheet](https://dl.ubnt.com/datasheets/unifi/UniFi_AC_APs_DS.pdf)
* [Unifi AP Mesh Data Sheet](https://dl.ubnt.com/datasheets/unifi/UniFi_AC_Mesh_DS.pdf)

### Napalm

* [napalm-vyos driver](https://github.com/napalm-automation-community/napalm-vyos) 
* [napalm-edgeos driver older](https://github.com/thomseddon/napalm-edgeos)
* [napalm-edgeos driver newer](https://github.com/barneysowood/napalm-edgeos)


### Troubleshooting

* [cloud key wont start controller web UI we do not support upgrading from 5 11 46](https://community.ui.com/questions/cloud-key-wont-start-controller-web-UI-we-do-not-support-upgrading-from-5-11-46/88a7a0ef-1ba7-4913-ac10-681ff10b5f8c)

### Sonos
* [VLAN inter-accessibility for MultiCast devices (SONOS, Chromecast, Airtame, etc)](https://community.ui.com/questions/VLAN-inter-accessibility-for-MultiCast-devices-SONOS-Chromecast-Airtame-etc/f4d7a07c-d4ea-4238-8265-38ccd6e904c7)
* [EdgeRouter Setup IGMP proxy and statistics](https://help.ubnt.com/hc/en-us/articles/204961854-EdgeRouter-Set-up-IGMP-proxy-and-statistics)
* [Configure Sonos across subnets on USG](https://community.ui.com/questions/Configure-Sonos-across-subnets-on-USG/a758382b-72e4-446b-90cc-ea353482ff1a)
* [Unifi Sonos and VLANs](https://blog.awelswynol.co.uk/2017/11/unifi-sonos-and-vlans)
* [An optimal configuration for a Unifi Managed Network & Sonos](https://community.ui.com/questions/An-optimal-configuration-for-a-Unifi-Managed-Network-and-Sonos/4819df0b-cc15-43b1-8f8f-4ca36c486f1c)
* [Tips Connecting to SONOS speakers on a Unifi Wireless Network.](https://community.ui.com/questions/Tips-Connecting-to-SONOS-speakers-on-a-Unifi-Wireless-Network-/e1efc872-70e8-4d0b-9279-8ae74311798a)
* [Sonos on Unifi Network Gear](https://jekhokie.github.io/unifi/sonos/networking/2020/12/06/sonos-on-unifi.html)
* [How to configure your UniFi network for Sonos](https://github.com/IngmarStein/unifi-sonos-doc)
* [Tips: Running Sonos wired and wireless in a pure Unifi (Ubiquiti) network environment](https://en.community.sonos.com/troubleshooting-228999/tips-running-sonos-wired-and-wireless-in-a-pure-unifi-ubiquiti-network-environment-6813112)
* [Getting Sonos and Ubiquiti to play nice](https://community.ui.com/questions/Getting-Unifi-and-Sonos-to-play-nice/5d3c8cf2-5d11-4aea-ab4c-977736749159)

### Camera's
* [Successfully Installed 2 G4 Doorbells with wiring diagram](https://www.reddit.com/r/Ubiquiti/comments/j5op2q/successfully_installed_2_g4_doorbells_with/)

![Multiple Unifi Doorbell Wiring Diagram](https://media.gioia.cloud/blog/thoughts/doorbells/unifi-doorbell-wiring-diagram@light.png)

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
