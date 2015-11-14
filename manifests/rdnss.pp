define radvd::rdnss(
	$interface,
	$ip_list,
	$adv_rdnss_lifetime = undef,
	$flush_rdnss        = undef,
) {
	$ips = join($ip_list, " ")

	bitfile::bit { "/etc/radvd.conf:interface=${interface}:rdnss=${ips}":
		path            => "/etc/radvd.conf",
		parent          => "/etc/radvd.conf:interface=${interface}",
		content         => "\trdnss ${ips} {",
		closing_content => "\t};",
	}

	if $adv_rdnss_lifetime != undef {
		if $adv_rdnss_lifetime !~ /^(\d+|infinity)$/ {
			fail("Invalid value for adv_rdnss_lifetime (got ${adv_rdnss_lifetime}, expected integer or 'infinity')")
		}

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
			default => fail("Invalid value for flush_rdnss (got ${flush_rdnss}, expected true/false)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:rdnss=${ips}/flush_rdnss":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:rdnss=${ips}",
			content => "		FlushRDNSS ${flush_rdnss_value};"
		}
	}
}
