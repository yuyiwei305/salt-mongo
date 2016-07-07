no-firewalld:
  cmd.run:
    - name: setenforce 0 && sed -i.bak "s/SELINUX=enforcing/SELINUX=permissive/g" /etc/selinux/config && systemctl disable firewalld.service && systemctl stop firewalld.service && iptables --flush
  pkg.installed:
    - name: ntp
  service.running:
    - name: ntpd
    - enable: True
    - require: 
      - pkg: no-firewalld
