/**
 * opencsp source
 */
class pitlinz_ocsp::src(
  $provider = 'cvs',
	$srcusr	  = 'anonymous',
	$srcpwd	  = ''
) {

  case $provider {
    'cvs': {
      include ::pitlinz_ocsp::src::cvscore
    }
	}
}
