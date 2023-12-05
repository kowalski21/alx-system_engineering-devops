# nginx_setup.pp

# Install Nginx
class nginx {
  package { 'nginx':
    ensure  => 'installed',
    require => Apt::Update,
  }

  service { 'nginx':
    ensure  => 'running',
    enable  => true,
    require => Package['nginx'],
  }
}

# Create Nginx site configuration
file { '/etc/nginx/sites-available/default':
  content => @(EOL),
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $hostname;
    root   /var/www/html;
    index  index.html index.htm;

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=ErJYBFcMBgw.com/;
    }

    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}
EOL
  notify  => Service['nginx'],
  require => Class['nginx'],
}

# Create index.html and 404.html
file { '/var/www/html/index.html':
  content => 'Hello World',
}

file { '/var/www/html/404.html':
  content => "Ceci n'est pas une page",
}

# Notify Nginx to restart when the configuration changes
Service['nginx'] ~> File['/etc/nginx/sites-available/default']
