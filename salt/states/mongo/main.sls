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


