# script to install php modules via pecl
#
define pitlinz_ocsp::php::peclinstall(
    $ensure = present,
    $version = '',
    $updatechanel = false,
    $options = ''
  ) {

    if (!defined(Package['php-dev'])) {
      package{'php-dev':
        ensure => latest,
        require => Package["php","apache2"],
      }
    }

    if (!defined(Package['php-pear'])) {
      package{'php-pear':
        ensure => latest,
        require => Package["php","apache2"],
      }
    }

    if (!defined(Package['build-essential'])) {
      package{'build-essential':
        ensure => latest
      }
    }

    if $updatechanel {
      if !defined(Exec['/usr/bin/pecl channel-update pecl.php.net']) {
        exec{'/usr/bin/pecl channel-update pecl.php.net':
          command => '/usr/bin/pecl channel-update pecl.php.net'
        }
      }
    }

    exec {"/usr/bin/pecl install $name-$version":
      command => "/usr/bin/pecl install $options $name-$version",
      creates => "$::phpextensiondir/$name.so"
    }

    $_phpetcpath = "/etc/php/$::phpmajorversion.$::phpminorversion"

    file{"${_phpetcpath}/mods-available/${name}.ini":
      content => "extension=${name}.so\n",
      ensure  => $ensure
    }

    exec{"phpenmod ${name}":
      command  => "/usr/sbin/phpenmod $name",
      creates => "$_phpetcpath/apache2/conf.d/20-${name}.ini"
    }

  }
