/**
 * enable apachemode
 */
define pitlinz_ocsp::apache2::enmode(

) {

    if !defined(Exec["a2enmod_${name}"]) {
	    exec{"a2enmod_${name}":
	        command => "/usr/sbin/a2enmod ${name}",
			creates => "/etc/apache2/mods-enabled/${name}.load",
			require => Package["apache2"],
			notify  => Service["apache2"]
		}
    }

}
