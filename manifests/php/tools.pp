/**
 * some php tools
 */
class pitlinz_ocsp::php::tools(
    $addPhpModules = []
) {

  case $::phpmajorversion {
    5: {
      ::pitlinz_ocsp::package{["php5-readline","php5-curl","php5-mbstring","php5-json","php5-mcrypt"]:
        ensure => latest,
        require => Package["php","apache2"],
        notify  => Service["apache2"]
      }
    }

    default: {
      ::pitlinz_ocsp::package{["php-readline","php-curl","php-mbstring","php-json","php-zip","libmcrypt-dev","php-bcmath"]:
        ensure => latest,
				require => Package["php","apache2"],
				notify  => Service["apache2"]
      }

      ::pitlinz_ocsp::php::peclinstall{'mcrypt':
          ensure => present,
          version => '1.0.2',
          options => '-f'
      }
    }

#
#	    default:  {
#	        notify{"tools unknown phpmajorversion: ${::phpmajorversion}":}
#		}
    }

  ::pitlinz_ocsp::package{["curl"]:
		ensure => latest,
  }

	if size($addPhpModules) {
    ::pitlinz_ocsp::package{$addPhpModules:
      ensure => latest,
      require => Package["php","apache2"],
      notify  => Service["apache2"]
    }
	}
}
