/**
 * install opencsp core
 */
class pitlinz_ocsp (
    $ensure 	= present,
    $basepath	= "/srv/www",
    $sftpuser	= "opencsp",
) {

  $corepath	= "${basepath}/opencsp/core"
	$modulepath	= "${basepath}/opencsp/modules"
	$toolspath  = "${basepath}/opencsp/tools"

	if $ensure == present {
    $pkg_ensure = latest
	}


	if !defined(Exec["mkdir_${basepath}"]) {
    exec{"mkdir_${basepath}":
      command => "/bin/mkdir -p ${basepath}",
			creates	=> "${basepath}"
		}
	}

	if !defined(Exec["mkdir_${corepath}"]) {
    exec{"mkdir_${corepath}":
      command => "/bin/mkdir -p ${corepath}",
			creates	=> "${corepath}"
		}
	}

	if !defined(File["${corepath}"]) {
    file{"${corepath}":
      ensure  => directory,
      group => "www-data",
      mode  => "755",
			require => Exec["mkdir_${corepath}"]
    }
	}

	if !defined(Exec["mkdir_${modulepath}"]) {
    exec{"mkdir_${modulepath}":
      command => "/bin/mkdir -p ${modulepath}",
			creates	=> "${modulepath}"
		}
	}

	if !defined(File["${modulepath}"]) {
    file{"${modulepath}":
      ensure  => directory,
      group => "www-data",
      mode  => "755",
			require => Exec["mkdir_${modulepath}"]
    }
	}

	if !defined(Exec["mkdir_${toolspath}"]) {
    exec{"mkdir_${toolspath}":
      command => "/bin/mkdir -p ${toolspath}",
			creates	=> "${toolspath}"
		}
	}

	if !defined(File["${toolspath}"]) {
    file{"${toolspath}":
      ensure  => directory,
      group => "www-data",
      mode  => "755",
			require => Exec["mkdir_${toolspath}"]
    }
	}

	if !defined(File["${toolspath}/config"]) {
    file{"${toolspath}/config":
      ensure  => directory,
      mode  => "755",
			require => File["${toolspath}"]
    }
	}


	include ::pitlinz_ocsp::users::sftpuser
	include ::pitlinz_ocsp::apache2
	include ::pitlinz_ocsp::php

	include ::pitlinz_ocsp::src

}
