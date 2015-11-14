define radvd::route(
	$interface,
	$prefix,
	$adv_route_lifetime   = undef,
	$adv_route_preference = undef,
	$remove_route         = undef,
) {
	bitfile::bit { "/etc/radvd.conf:interface=${interface}:route=${prefix}":
		path            => "/etc/radvd.conf",
		parent          => "/etc/radvd.conf:interface=${interface}",
		content         => "\troute ${prefix} {",
		closing_content => "\t};",
	}

	if $adv_route_lifetime != undef {
		if $adv_route_lifetime !~ /^(\d+|infinity)$/ {
			fail("Invalid value for adv_route_lifetime (got ${adv_route_lifetime}, expected integer or 'infinity')")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:route=${prefix}/adv_route_lifetime":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:route=${prefix}",
			content => "		AdvRouteLifetime ${adv_route_lifetime};"
		}
	}

	if $adv_route_preference != undef {
		if $adv_route_preference != "low" and $adv_route_preference != "medium" and $adv_route_preference != "high" {
			fail("Invalid value for adv_route_preference (got ${adv_route_preference}, expected low|medium|high)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:route=${prefix}/adv_route_preference":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}",
			content => "	AdvRoutePreference ${adv_route_preference};"
		}
	}

	if $remove_route != undef {
		$remove_route_value = $remove_route ? {
			true    => 'on',
			false   => 'off',
			default => fail("Invalid value for remove_route (got ${remove_route}, expected true/false)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:route=${prefix}/remove_route":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:route=${prefix}",
			content => "		RemoveRoute ${remove_route_value};"
		}
	}
}
