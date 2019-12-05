/**
 * install xml module
 */
class pitlinz_ocsp::php::xml (

) {

  case $::operatingsystemmajrelease {
    '16.04': {
      ::pitlinz_ocsp::package{["php-xml","php-xml-serializer"]:
        ensure => latest,
    		require => Package["php","apache2"],
    		notify  => Service["apache2"]
    	}

    	# pear packages
      ::pitlinz_ocsp::package{["php-xml-parser"]:
        ensure => latest,
        require => Package["php-pear"],
    	}
    }
  }
}
