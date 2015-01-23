package {[
    "httpd", "mod_ssl", "postgresql-devel", "unzip",
    ]:
    ensure => present,
    allow_virtual => true,
}

package {["firewalld"]:
    ensure => absent,
    allow_virtual => true,
}


service { "httpd":
    ensure => "running",
    require => Package["httpd"],
    enable => true,
}

file {"/var/www/catshop":
    ensure => "link",
    target => "/vagrant/",
    require => Package["httpd"],
    notify => Service["httpd"],
}

package {["perl-Getopt-Long", "perl-Data-Dumper"]:
    ensure => present,
    allow_virtual => true,
}

#We should change this to use perlbrews version once GH#409 is fixed
exec {"install_perlbrew":
    command => "/usr/bin/su vagrant -c '/usr/bin/curl -L http://install.perlbrew.pl/ | /usr/bin/bash' -",
    creates => "/home/vagrant/perl5",
    cwd     => "/home/vagrant",
    environment => "PERLBREWURL=https://raw.githubusercontent.com/grim8634/App-perlbrew/develop/perlbrew",
    require => Package['perl-Getopt-Long'],
}

exec {"install_perl520":
    command => "/usr/bin/su vagrant -c '~/perl5/perlbrew/bin/perlbrew -n install perl-5.20.1' -",
    timeout => 3600, #Perl takes a long time to compile
    cwd     => "/home/vagrant",
    require => [Exec['install_perlbrew'], Package['perl-Data-Dumper']],
    creates => "/home/vagrant/perl5/perlbrew/perls/perl-5.20.1",
}

file {"bashrc":
    path    => "/home/vagrant/.bashrc",
    ensure  => present,
    owner   => 'vagrant',
    group   => 'vagrant',
}

line { "perlbrew bashrc line":
    line    => "source ~/perl5/perlbrew/etc/bashrc",
    file    => "/home/vagrant/.bashrc",
}

define line($file, $line, $ensure = 'present') {
    case $ensure {
        default : { err ( "unknown ensure value ${ensure}" ) }
        present: {
            exec { "/bin/echo '${line}' >> '${file}'":
                unless => "/bin/grep -qFx '${line}' '${file}'"
            }
        }
        absent: {
            exec { "/usr/bin/perl -ni -e 'print unless /^\\Q${line}\\E\$/' '${file}'":
                onlyif => "/bin/grep -qFx '${line}' '${file}'"
            }
        }
    }
}

exec {"perlbrew_switch_perl520":
    command => "/usr/bin/su vagrant -c '/home/vagrant/perl5/perlbrew/bin/perlbrew switch perl-5.20.1'",
    require => Exec['install_perl520'],
}

exec { "install_cpanm":
    command => "/usr/bin/su vagrant -c '/home/vagrant/perl5/perlbrew/bin/perlbrew install-cpanm'",
    require => Exec['perlbrew_switch_perl520'],
    creates => '/home/vagrant/perl5/perlbrew/bin/cpanm'
}

exec { "install_carton":
    command => "/usr/bin/su vagrant -c '/home/vagrant/perl5/perlbrew/bin/perlbrew exec cpanm Carton'",
    require => Exec['install_cpanm'],
    creates => '/home/vagrant/perl5/perlbrew/bin/carton'
}

class { 'postgresql::server': }

postgresql::server::db { 'catshop-dev':
  user     => 'catshop',
  password => postgresql_password('catshop', 'CatShop'),
}

file {"/etc/httpd/conf.d/catshop.conf":
    content => template('/vagrant/vagrant/templates/catshop.conf.erb'),
    ensure  => file,
    notify => Service["httpd"],
}

file {"/etc/httpd/conf.d/catshop-ssl.conf":
    content => template('/vagrant/vagrant/templates/catshop-ssl.conf.erb'),
    ensure  => file,
    notify  => Service["httpd"],
    require => Package["httpd"],
}

file {"/etc/httpd/ssl":
    ensure  => directory,
    require => Package['httpd']
}

exec {"create_cert":
    command => "/usr/bin/openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
        -days 3650 -subj \"/C=US/ST=Denial/L=Springfield/O=Dis/CN=${fqdn}\" \
        -keyout /etc/httpd/ssl/self-ssl.key -out /etc/httpd/ssl/self-ssl.crt",
    creates => "/etc/httpd/ssl/self-ssl.crt",
    require => File['/etc/httpd/ssl'],
    notify  => Service["httpd"],
}

if defined( "local_config") {
    notify {'defined':}
    include "local_config"
}

