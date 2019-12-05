/**
 * default sftp user allowed to edit source
 *
 * default password: OpenCsp.123
 */
class pitlinz_ocsp::users::sftpuser(
    $login			= "${::pitlinz_ocsp::sftpuser}",
    $password		= '',
	$passwordhash	= '',
) {

    include ::pitlinz_ocsp

    if $password != '' {
        $pwd_hash = pw_hash($password, 'SHA-512', $::fqdn)
    } else {
        $pwd_hash = $passwordhash
    }

    if $login != '' {
        $_login = $login
    } else {
        $_login = "opencsp"
    }

	if ($pwd_hash != '') and !defined(User[$_login]) {
	 	user{"${_login}":
			password => $pwd_hash,
			home	 => "${::pitlinz_ocsp::basepath}/opencsp",
			shell	 => '/bin/bash',
			require	 => File["${::pitlinz_ocsp::corepath}"],
			groups	 => "www-data"
		}
	}


}
