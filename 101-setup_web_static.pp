# SCRIPT INCOMPLETE. NEEDS SOME MORE THINKING---

# update packages
exec { 'apt-get-update':
  command  => 'sudo apt-get -y update',
  provider => shell,
}

# install nginx
exec {'install nginx':
  command  => 'sudo apt-get -y install nginx',
  provider => shell,
}

# allow HTTP in Nginx
exec {'allow HTTP':
  command  => "sudo ufw allow 'Nginx HTTP'",
  provider => shell,
}

# create the path /data/web_static/releases/test/
exec {'mkdir /test':
  command  => 'sudo mkdir -p /data/web_static/releases/test/',
  provider => shell,
}

# create the path /data/web_static/shared/
exec {'mkdir /shared':
  command  => 'sudo mkdir -p /data/web_static/shared/',
  provider => shell,
}

# create test inex file with temporary content
exec {'create index.html':
  command  => 'echo "Set by puppet manifest of task 5 from project 0X03 AirBnB" > /data/web_static/releases/test/index.html',
  provider => shell,
}
