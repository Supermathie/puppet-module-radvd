define radvd::dnssl(
	$interface,
	$suffix_list,
	$adv_dnssl_lifetime = undef,
	$flush_dnssl        = undef,
) {
	$suffixes = join($suffix_list, " ")

	bitfile::bit { "/etc/radvd.conf:interface=${interface}:dnssl=${suffixes}":
		path            => "/etc/radvd.conf",
		parent          => "/etc/radvd.conf:interface=${interface}",
		content         => "\tdnssl ${suffixes} {",
		closing_content => "\t};",
	}

	if $adv_dnssl_lifetime != undef {
		if $adv_dnssl_lifetime !~ /^(\d+|infinity)$/ {
			fail("Invalid value for adv_dnssl_lifetime (got ${adv_dnssl_lifetime}, expected integer or 'infinity')")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:dnssl=${suffixes}/adv_dnssl_lifetime":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:dnssl=${suffixes}",
			content => "		AdvDNSSLLifetime ${adv_dnssl_lifetime};"
		}
	}

	if $flush_dnssl != undef {
		$flush_dnssl_value = $flush_dnssl ? {
			true    => 'on',
			false   => 'off',
			default => fail("Invalid value for flush_dnssl (got ${flush_dnssl}, expected true/false)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:dnssl=${suffixes}/flush_dnssl":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:dnssl=${suffixes}",
			content => "		FlushDNSSL ${flush_dnssl_value};"
		}
	}
}
