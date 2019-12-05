# configure apache mpm prefork
#
# $start 	=> StartServers: number of server processes to start
# $minspare	=> MinSpareServers: minimum number of server processes which are kept spare
# $maxspare	=> MaxSpareServers: maximum number of server processes which are kept spare
# $maxreq	=> MaxRequestWorkers: maximum number of server processes allowed to start
# $maxcon	=> MaxConnectionsPerChild: maximum number of requests a server process serves
#

class pitlinz_ocsp::apache2::mpm_prefork(
        $start	 	= 20,
        $minspare	= 10,
        $maxspare	= 15,
        $maxreq		= 150,
        $maxcon		= 140
) {
    file{"/etc/apache2/mods-available/mpm_prefork.conf":
        content => template("pitlinz_ocsp/apache2/module_mpm_prefork.conf.erb"),
        require	=> Package["apache2"],
        notify	=> Service["apache2"],
	}

	pitlinz_ocsp::apache2::enmode{"mpm_prefork":

	}
}
