==============
用salt安装kolla
==============
当前仅支持mitaka的安装
# 安装salt
```bash
yum install -y http://repo.saltstack.com/yum/redhat/salt-repo-2016.3-1.el7.noarch.rpm
yum install -y salt-ssh
```

# 下载kolla-salt
```bash
git clone https://github.com/wlhyl/kolla-salt.git
```

# 复制kolla-salt配置文件到/srv
```bash
cp -r kolla-salt/pillar /srv/
cp -r kolla-salt/kolla  /srv/
```

# 编辑/srv/pillar/openstack.sls
```bash
cat /srv/pillar/openstack.sls
openstack:
  version: mitaka
```
# 安装 kolla
```bash
salt-ssh '*' state.sls kolla
```