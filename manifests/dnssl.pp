define radvd::dnssl(
	String                                    $interface,
	Array                                     $suffix_list,
	Variant[Integer, Enum['infinity'], Undef] $adv_dnssl_lifetime = undef,
	Variant[Boolean, Undef]                   $flush_dnssl        = undef,
) {
	$suffixes = join($suffix_list, " ")

	bitfile::bit { "/etc/radvd.conf:interface=${interface}:dnssl=${suffixes}":
		path            => "/etc/radvd.conf",
		parent          => "/etc/radvd.conf:interface=${interface}",
		content         => "\tdnssl ${suffixes} {",
		closing_content => "\t};",
	}

	if $adv_dnssl_lifetime != undef {
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
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:dnssl=${suffixes}/flush_dnssl":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:dnssl=${suffixes}",
			content => "		FlushDNSSL ${flush_dnssl_value};"
		}
	}
}
