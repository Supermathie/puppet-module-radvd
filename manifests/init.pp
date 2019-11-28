class radvd {
	package { "radvd": }

	service { "radvd":
		ensure  => running,
		enable  => true,
		require => Package["radvd"],
	}

	bitfile { "/etc/radvd.conf":
		owner  => "root",
		group  => "root",
		mode   => '0444',
		notify => Service["radvd"],
	}

	bitfile::bit { "/etc/radvd.conf:header":
		path    => "/etc/radvd.conf",
		ordinal => 0,
		content => "# THIS FILE IS MANAGED BY PUPPET\n# DO NOT MODIFY\n#\n",
	}
}
