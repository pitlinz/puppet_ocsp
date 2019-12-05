/**
 * install a module from cvs
 */
define pitlinz_ocsp::src::cvsmodule(
  $source = ":pserver:${::pitlinz_ocsp::src::srcusr}@opencsp.cvs.sourceforge.net:/cvsroot/opencsp",
) {
  $modpath = "${::pitlinz_ocsp::modulepath}/${name}"

  if !defined(Pitlinz_ocsp::Package["cvs"]) {
    ::pitlinz_ocsp::package{'cvs':
      ensure => latest
		}
	}

  exec{"cvs checkout_opencsp_$name":
    command => "/usr/bin/cvs -d $source checkout $name  ",
    creates => "${modpath}/CVS",
    cwd		=> "${::pitlinz_ocsp::modulepath}",
    require	 => [Package["cvs"],File["${::pitlinz_ocsp::modulepath}"]],
    notify	 => Exec["chown_${modpath}","chmod_${modpath}"]
  }

	exec{"chown_${modpath}":
	    command => "/bin/chown -R ${::pitlinz_ocsp::sftpuser}:www-data ${modpath}",
	    refreshonly => true,
	}

	exec{"chmod_${modpath}":
	    command => "/bin/chmod -R 750 ${modpath}",
	    refreshonly => true,
	}
}
