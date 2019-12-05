/**
 * install imagic & grafic modules
 */
class pitlinz_ocsp::php::imagic(

) {
	case $::phpmajorversion {
	    5: {
		    ::pitlinz_ocsp::package{["php5-imagick","php-gd"]:
		        ensure => latest,
				require => Package["php","apache2"],
				notify  => Service["apache2"]
			}
	    }
	    default: {
		    ::pitlinz_ocsp::package{["php-imagick","php-gd"]:
		        ensure => latest,
				require => Package["php","apache2"],
				notify  => Service["apache2"]
			}
	    }

#	    default:  {
#	        notify{"unknown phpmajorversion: ${::phpmajorversion}":}
#		}

	}

	case $::operatingsystemmajrelease {
		'14.04','16.04','18.04': {
			::pitlinz_ocsp::package{["graphicsmagick","graphicsmagick-imagemagick-compat"]:
		    	ensure => latest
			}
		}

	    default:  {
	        notify{"imagic: unknown operatingsystemmajrelease: ${::operatingsystemmajrelease}":}
		}
	}

}
