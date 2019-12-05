/**
 * install mod_newsletter src
 */
class pitlinz_ocsp::src::modnewsletter(
  $provider = $::pitlinz_ocsp::src::provider,
  $source = ":pserver:${::pitlinz_ocsp::src::srcusr}@cvs.w4c.at:/root/opencsp",
	$srcusr	  = 'anonymous',
	$srcpwd	  = ''
) {
 	case $provider {
    'cvs': {
      pitlinz_ocsp::src::cvsmodule{"mod_newsletter":
        source => $source
			}
	   }
	}

  ::pitlinz_ocsp::package{['php-mail','php-mail-mime','php-mailparse']:
    ensure => "latest"
	}

}
