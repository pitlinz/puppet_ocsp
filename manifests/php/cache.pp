/**
 * install php cache module
 */
class pitlinz_ocsp::php::cache(
	$path = "/var/cache/opencsp"
) {

	file{"${path}":
		ensure => directory,
    owner => "www-data",
		group => "www-data",
		mode  => "3770"
  }

  case $::phpmajorversion {
    5: {
			::pitlinz_ocsp::package{["php5-xcache","php5-memcached"]:
				ensure => latest,
				require => Package["php","apache2"],
				notify  => Service["apache2"]
			}
    }

		default: {
			::pitlinz_ocsp::package{["php-apcu","php-memcached"]:
        ensure => latest,
				require => Package["php","apache2"],
				notify  => Service["apache2"]
      }

      if !defined(Pitlinz_ocsp::Package["git"]) {
        ::pitlinz_ocsp::package{"git":
          ensure => latest
				}
      }

      file{"${::pitlinz_ocsp::toolspath}/apcadmin":
        ensure 	=> directory,
        mode	=> "755",
      }

			vcsrepo {"${::pitlinz_ocsp::toolspath}/apcadmin":
				ensure   => present,
				provider => git,
				source   => "git://github.com/jithinjose2/APC-Admin.git",
			 	require	 => File["${::pitlinz_ocsp::toolspath}/apcadmin"]
			}

			file{"${::pitlinz_ocsp::toolspath}/config/apcadmin.conf":
				content => template("pitlinz_ocsp/apache2/apcadmin.conf.erb"),
				require	=> File["${::pitlinz_ocsp::toolspath}/config"],
				notify	=> Service["apache2"]
			}


    }
	}

  # pear packages
	case $::operatingsystemmajrelease {
		'16.04': {
		  ::pitlinz_common::package{["php-cache"]:
		      ensure => latest,
		      require => Package["php-pear"],
			}
		}
	}
}
