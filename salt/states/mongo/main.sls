mongodb-install:
  file.managed:
    - name: /usr/local/src/mongodb-linux-x86_64-2.4.6.tgz
    - source: salt://mongo/file/mongodb-linux-x86_64-2.4.6.tgz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf mongodb-linux-x86_64-2.4.6.tgz && ln -s /usr/local/src/mongodb-linux-x86_64-2.4.6/bin/mongo /usr/bin/mongo && ln -s /usr/local/src/mongodb-linux-x86_64-2.4.6/bin/mongos /usr/bin/mongos && ln -s /usr/local/src/mongodb-linux-x86_64-2.4.6/bin/mongod  /usr/bin/mongod 
    - unless: test -e /usr/bin/mongod  
    - require: 
      - file: mongodb-install

mongodb-config:
  file.recurse:
    - name: /etc/mongodb
    - source: salt://mongo/file/mongodb
    - user: root
    - group: root
    - template: jinja
    - defaults:
      SHARD1IP: {{ pillar['shard']['SHARD1IP'] }}
      SHARD2IP: {{ pillar['shard']['SHARD2IP'] }}
      SHARD3IP: {{ pillar['shard']['SHARD3IP'] }}
      KEY: {{ pillar['security']['KEY'] }}
    - require:
      - cmd: mongodb-install
  cmd.run:
    - name: mkdir -p /data/mongodb/mongos/log && mkdir -p /data/mongodb/config/data && mkdir -p /data/mongodb/config/log  && mkdir -p /data/mongodb/shard1/data && mkdir -p /data/mongodb/shard1/log  && mkdir -p /data/mongodb/shard2/data && mkdir -p /data/mongodb/shard2/log  &&  mkdir -p /data/mongodb/shard3/data && mkdir -p /data/mongodb/shard3/log
    - unless: test -d /data/mongodb/shard3/log
    - require: 
      - file: mongodb-config


mongodb-init:
  file.managed:
    - name: /etc/mongodb/key/security
    - source: salt://mongo/file/mongodb/key/security
    - user: root
    - group: root
    - mode: 600
    - template: jinja
    - defaults:
      KEY: {{ pillar['security']['KEY'] }}
    - require:
      - file: mongodb-config

mongodb-configRun:
  cmd.run:
    - name: bash /etc/mongodb/scripts/config.sh
    - require: 
      - file: mongodb-config


mongodb-mongosRun:
  cmd.run:
    - name: bash /etc/mongodb/scripts/mongosRun.sh
    - require:
      - cmd: mongodb-configRun



mongodb-shard1Run:
  cmd.run:
    - name: bash /etc/mongodb/scripts/shard1Run.sh
    - require:
      - cmd: mongodb-mongosRun

mongodb-shard2Run:
  cmd.run:
    - name: bash /etc/mongodb/scripts/shard2Run.sh
    - require:
      - cmd: mongodb-mongosRun



mongodb-shard3Run:
  cmd.run:
    - name: bash /etc/mongodb/scripts/shard3Run.sh
    - require:
      - cmd: mongodb-mongosRun





