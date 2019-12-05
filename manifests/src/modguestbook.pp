/**
 * install mod_contact src
 */
class pitlinz_ocsp::src::modguestbook(
  $provider = $::pitlinz_ocsp::src::provider,
  $source   = ":pserver:${::pitlinz_ocsp::src::srcusr}@cvs.w4c.at:/root/opencsp",
	$srcusr	  = 'anonymous',
	$srcpwd	  = ''
) {

  case $provider {
    'cvs': {
      pitlinz_ocsp::src::cvsmodule{"mod_guestbook":
        source => $source
			}
    }
	}
}
