define radvd::rdnss(
	String                                    $interface,
	Array                                     $ip_list,
	Variant[Integer, Enum['infinity'], Undef] $adv_rdnss_lifetime = undef,
	Variant[Boolean, Undef]                   $flush_rdnss        = undef,
) {
	$ips = join($ip_list, " ")

	bitfile::bit { "/etc/radvd.conf:interface=${interface}:rdnss=${ips}":
		path            => "/etc/radvd.conf",
		parent          => "/etc/radvd.conf:interface=${interface}",
		content         => "\trdnss ${ips} {",
		closing_content => "\t};",
	}

	if $adv_rdnss_lifetime != undef {
		bitfile::bit { "/etc/radvd.conf:interface=${interface}:rdnss=${ips}/adv_rdnss_lifetime":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:rdnss=${ips}",
			content => "		AdvRDNSSLifetime ${adv_rdnss_lifetime};"
		}
	}

	if $flush_rdnss != undef {
		$flush_rdnss_value = $flush_rdnss ? {
			true    => 'on',
			false   => 'off',
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:rdnss=${ips}/flush_rdnss":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:rdnss=${ips}",
			content => "		FlushRDNSS ${flush_rdnss_value};"
		}
	}
}
