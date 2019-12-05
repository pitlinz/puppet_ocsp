/**
 * install php composer
 */
class pitlinz_ocsp::php::composer(
	$instdir	= "/usr/local/bin/"
) {
	if !defined(Package["curl"]) {
	    package{"curl":
	        ensure => latest,
		}
	}

	exec{"install_composer":
	    command	=> "/usr/bin/curl -sS https://getcomposer.org/installer | php -- --install-dir=${instdir} --filename=composer",
	    creates => "${instdir}composer",
		require => Package["curl","php-cli"],
		user	=> "root",
		environment => ["COMPOSER_HOME=${instdir}"],
	}
}
