/**
 * install apache2 for opencsp
 */
class pitlinz_ocsp::apache2(
  $additonalpkgs = [],
)  {

	::pitlinz_ocsp::package{"apache2":
		ensure => $::pitlinz_ocsp::pkg_ensure
  }

	if !defined(Service["apache2"]) {
    service{"apache2":
      ensure => running,
      require => Package["apache2"]
		}
	}


  ::pitlinz_ocsp::apache2::enmode{"rewrite":
	}

	::pitlinz_ocsp::package{$additonalpkgs:
    ensure => $::pitlinz_ocsp::pkg_ensure,
    require => Package["apache2"]
	}

	include ::pitlinz_ocsp::apache2::mpm_prefork
	include ::pitlinz_ocsp::apache2::headers
	include ::pitlinz_ocsp::apache2::expires

	file{"${::pitlinz_ocsp::basepath}/apache2.conf":
    ensure => directory,
    mode   => '0755'
	}

	file{"${::pitlinz_ocsp::basepath}/apache2.conf/opencsp.include":
    content => template("pitlinz_ocsp/apache2/ocsp.conf.erb"),
    require => File["${::pitlinz_ocsp::basepath}/apache2.conf"]
	}
}
