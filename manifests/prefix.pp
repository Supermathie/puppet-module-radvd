define radvd::prefix(
	String                                    $interface,
	String                                    $prefix,
	Variant[Boolean, Undef]                   $adv_on_link            = undef,
	Variant[Boolean, Undef]                   $adv_autonomous         = undef,
	Variant[Boolean, Undef]                   $adv_router_addr        = undef,
	Variant[Integer, Enum['infinity'], Undef] $adv_valid_lifetime     = undef,
	Variant[Integer, Enum['infinity'], Undef] $adv_preferred_lifetime = undef,
	Variant[Boolean, Undef]                   $deprecate_prefix       = undef,
	Variant[Boolean, Undef]                   $decrement_lifetimes    = undef,
	Variant[String,  Undef]                   $base6_interface        = undef,
	Variant[String,  Undef]                   $base6to4_interface     = undef,
) {
	bitfile::bit { "/etc/radvd.conf:interface=${interface}:prefix=${prefix}":
		path            => "/etc/radvd.conf",
		parent          => "/etc/radvd.conf:interface=${interface}",
		content         => "\tprefix ${prefix} {",
		closing_content => "\t};",
	}

	if $adv_on_link != undef {
		$adv_on_link_value = $adv_on_link ? {
			true    => 'on',
			false   => 'off',
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:prefix=${prefix}/adv_on_link":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:prefix=${prefix}",
			content => "		AdvOnLink ${adv_on_link_value};"
		}
	}

	if $adv_autonomous != undef {
		$adv_autonomous_value = $adv_autonomous ? {
			true    => 'on',
			false   => 'off',
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:prefix=${prefix}/adv_autonomous":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:prefix=${prefix}",
			content => "		AdvAutonomous ${adv_autonomous_value};"
		}
	}

	if $adv_router_addr != undef {
		$adv_router_addr_value = $adv_router_addr ? {
			true    => 'on',
			false   => 'off',
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:prefix=${prefix}/adv_router_addr":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:prefix=${prefix}",
			content => "		AdvRouterAddr ${adv_router_addr_value};"
		}
	}

	if $adv_valid_lifetime != undef {
		bitfile::bit { "/etc/radvd.conf:interface=${interface}:prefix=${prefix}/adv_valid_lifetime":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:prefix=${prefix}",
			content => "		AdvValidLifetime ${adv_valid_lifetime};"
		}
	}

	if $adv_preferred_lifetime != undef {
		bitfile::bit { "/etc/radvd.conf:interface=${interface}:prefix=${prefix}/adv_preferred_lifetime":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:prefix=${prefix}",
			content => "		AdvPreferredLifetime ${adv_preferred_lifetime};"
		}
	}

	if $deprecate_prefix != undef {
		$deprecate_prefix_value = $deprecate_prefix ? {
			true    => 'on',
			false   => 'off',
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:prefix=${prefix}/deprecate_prefix":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:prefix=${prefix}",
			content => "		DeprecatePrefix ${deprecate_prefix_value};"
		}
	}

	if $decrement_lifetimes != undef {
		$decrement_lifetimes_value = $decrement_lifetimes ? {
			true    => 'on',
			false   => 'off',
		}

		bitfile::bit { "/etc/radvd.conf:interface=${interface}:prefix=${prefix}/decrement_lifetimes":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:prefix=${prefix}",
			content => "		DecrementLifetimes ${decrement_lifetimes_value};"
		}
	}

	if $base6_interface != undef {
		bitfile::bit { "/etc/radvd.conf:interface=${interface}:prefix=${prefix}/base6_interface":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:prefix=${prefix}",
			content => "		Base6Interface ${base6_interface};"
		}
	}

	if $base6to4_interface != undef {
		bitfile::bit { "/etc/radvd.conf:interface=${interface}:prefix=${prefix}/base6to4_interface":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${interface}:prefix=${prefix}",
			content => "		Base6to4Interface ${base6to4_interface};"
		}
	}
}
