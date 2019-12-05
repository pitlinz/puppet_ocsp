/**
 * install mod_news src
 */
class pitlinz_ocsp::src::modnews(
  $provider = $::pitlinz_ocsp::src::provider,
  $source = ":pserver:${::pitlinz_ocsp::src::srcusr}@cvs.w4c.at:/root/opencsp",
	$srcusr	  = 'anonymous',
	$srcpwd	  = ''
) {
 	case $provider {
	    'cvs': {
	        pitlinz_ocsp::src::cvsmodule{"mod_news":
	            source => $source
			}
	  }
	}
}
