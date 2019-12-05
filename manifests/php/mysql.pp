/**
 * install mysql module
 */
class pitlinz_ocsp::php::mysql (

) {
    ::pitlinz_ocsp::package{"php-mysql":
        ensure => latest,
		require => Package["php","apache2"],
		notify  => Service["apache2"]
	}

	# pear packages
    ::pitlinz_ocsp::package{["php-db"]:
        ensure => latest,
        require => Package["php-pear"],
	}

}
