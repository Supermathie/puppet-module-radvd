define radvd::route(
	String                                        $interface,
	String                                        $prefix,
	Variant[Integer, Enum['infinity'], Undef]     $adv_route_lifetime   = undef,
	Variant[Enum['low', 'medium', 'high'], Undef] $adv_route_preference = undef,
	Variant[Boolean, Undef]                       $remove_route         = undef,
) {
	bitfile::bit { "/etc/radvd.conf:interface=${interface}:route=${prefix}":
		path            => "/etc/radvd.conf",
		parent          => "/etc/radvd.conf:interface=${interface}",
		content         => "\troute ${prefix} {",
		closing_content => "\t};",
	}

	if $adv_route_lifetime != undef {
		bitfile::bit { "/etc/radvd.conf:interface=${interface}:route=${prefix}/adv_route_lifetime":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:route=${prefix}",
			content => "		AdvRouteLifetime ${adv_route_lifetime};"
		}
	}

	if $adv_route_preference != undef {
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
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:route=${prefix}/remove_route":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:route=${prefix}",
			content => "		RemoveRoute ${remove_route_value};"
		}
	}
}
