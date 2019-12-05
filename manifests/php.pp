/**
 * install php for opencsp
 */
class pitlinz_ocsp::php(

) {
  ::pitlinz_ocsp::package{["php","libapache2-mod-php","php-pear","php-cli"]:
    ensure => $::pitlinz_ocsp::pkg_ensure
	}

	file{"/var/www/html/info.php":
    content => "<?php phpinfo(); ?>\n",
		require => Package["libapache2-mod-php","apache2"],
		notify	=> Service["apache2"],
		mode	=> "0644"
	}

	include ::pitlinz_ocsp::php::mysql
	include ::pitlinz_ocsp::php::cache
	include ::pitlinz_ocsp::php::imagic
	include ::pitlinz_ocsp::php::xml
	include ::pitlinz_ocsp::php::tools
	include ::pitlinz_ocsp::php::composer

}
