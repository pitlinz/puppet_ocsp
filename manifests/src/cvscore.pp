/**
 * class to checkout the core source from cvs
 */
class pitlinz_ocsp::src::cvscore(
	$cvsserver = "cvs.w4c.at",
) {
    ::pitlinz_ocsp::package{'cvs':
        ensure => latest
	}

#	vcsrepo { "${::pitlinz_ocsp::corepath}":
#		ensure   => present,
#		provider => cvs,
#		source   => ":pserver:${::pitlinz_ocsp::src::srcusr}@${cvsserver}:/cvsroot/opencsp",
#		module   => "opencsp",
#		require	 => [Package["cvs"],File["${::pitlinz_ocsp::corepath}"]],
#		notify	 => Exec["chown_${::pitlinz_ocsp::corepath}","chmod_${::pitlinz_ocsp::corepath}"]
#	}

	exec{"cvs checkout_opencsp_core":
	  command => "/usr/bin/cvs -d :pserver:${::pitlinz_ocsp::src::srcusr}@${cvsserver}:/root/opencsp checkout -d core  opencsp  ",
		creates => "${::pitlinz_ocsp::corepath}/CVS",
		cwd		=> "${::pitlinz_ocsp::corepath}/../",
		require	 => [Package["cvs"],File["${::pitlinz_ocsp::corepath}"]],
		notify	 => Exec["chown_${::pitlinz_ocsp::corepath}","chmod_${::pitlinz_ocsp::corepath}"]
	}

	exec{"chown_${::pitlinz_ocsp::corepath}":
	    command => "/bin/chown -R ${::pitlinz_ocsp::sftpuser}:www-data ${::pitlinz_ocsp::corepath}",
	    refreshonly => true,
	}

	exec{"chmod_${::pitlinz_ocsp::corepath}":
	    command => "/bin/chmod -R 750 ${::pitlinz_ocsp::corepath}/*",
	    refreshonly => true,
	}
}
