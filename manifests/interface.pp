define radvd::interface(
	$ignore_if_missing        = undef,
	$adv_send_advert          = undef,
	$unicast_only             = undef,
	$max_rtr_adv_interval     = undef,
	$min_rtr_adv_interval     = undef,
	$min_delay_between_ras    = undef,
	$adv_managed_flag         = undef,
	$adv_other_config_flag    = undef,
	$adv_link_mtu             = undef,
	$adv_reachable_time       = undef,
	$adv_retrans_timer        = undef,
	$adv_cur_hop_limit        = undef,
	$adv_default_lifetime     = undef,
	$adv_default_preference   = undef,
	$adv_source_ll_address    = undef,
	$adv_home_agent_flag      = undef,
	$adv_home_agent_info      = undef,
	$home_agent_lifetime      = undef,
	$home_agent_preference    = undef,
	$adv_mob_rtr_support_flag = undef,
	$adv_interval_opt         = undef,
	$clients                  = undef,
) {
	bitfile::bit { "/etc/radvd.conf:interface=${name}":
		path            => "/etc/radvd.conf",
		content         => "interface ${name} {",
		closing_content => "};",
	}

	if $ignore_if_missing != undef {
		$ignore_if_missing_value = $ignore_if_missing ? {
			true    => 'on',
			false   => 'off',
			default => fail("Invalid value for ignore_if_missing (got ${ignore_if_missing}, expected true/false)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/ignore_if_missing":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	IgnoreIfMissing ${ignore_if_missing_value};"
		}
	}

	if $adv_send_advert != undef {
		$adv_send_advert_value = $adv_send_advert ? {
			true    => 'on',
			false   => 'off',
			default => fail("Invalid value for adv_send_advert (got ${adv_send_advert}, expected true/false)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_send_advert":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvSendAdvert ${adv_send_advert_value};"
		}
	}

	if $unicast_only != undef {
		$unicast_only_value = $unicast_only ? {
			true    => 'on',
			false   => 'off',
			default => fail("Invalid value for unicast_only (got ${unicast_only}, expected true/false)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/unicast_only":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	UnicastOnly ${unicast_only_value};"
		}
	}

	if $max_rtr_adv_interval != undef {
		if $max_rtr_adv_interval !~ /^\d+(\.\d+)?$/ {
			fail("Invalid value for max_rtr_adv_interval (got ${max_rtr_adv_interval}, expected decimal number)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/max_rtr_adv_interval":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	MaxRtrAdvInterval ${max_rtr_adv_interval};"
		}
	}

	if $min_rtr_adv_interval != undef {
		if $min_rtr_adv_interval !~ /^\d+(\.\d+)?$/ {
			fail("Invalid value for min_rtr_adv_interval (got ${min_rtr_adv_interval}, expected decimal number)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/min_rtr_adv_interval":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	MinRtrAdvInterval ${min_rtr_adv_interval};"
		}
	}

	if $min_delay_between_ras != undef {
		if $min_delay_between_ras !~ /^\d+(\.\d+)?$/ {
			fail("Invalid value for min_delay_between_ras (got ${min_delay_between_ras}, expected decimal number)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/min_delay_between_ras":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	MinDelayBetweenRAs ${min_delay_between_ras};"
		}
	}

	if $adv_managed_flag != undef {
		$adv_managed_flag_value = $adv_managed_flag ? {
			true    => 'on',
			false   => 'off',
			default => fail("Invalid value for adv_managed_flag (got ${adv_managed_flag}, expected true/false)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_managed_flag":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvManagedFlag ${adv_managed_flag_value};"
		}
	}

	if $adv_other_config_flag != undef {
		$adv_other_config_flag_value = $adv_other_config_flag ? {
			true    => 'on',
			false   => 'off',
			default => fail("Invalid value for adv_other_config_flag (got ${adv_other_config_flag}, expected true/false)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_other_config_flag":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvOtherConfigFlag ${adv_other_config_flag_value};"
		}
	}

	if $adv_link_mtu != undef {
		if $adv_link_mtu !~ /^\d+$/ {
			fail("Invalid value for adv_link_mtu (got ${adv_link_mtu}, expected integer)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_link_mtu":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvLinkMTU ${adv_link_mtu};"
		}
	}

	if $adv_reachable_time != undef {
		if $adv_reachable_time !~ /^\d+$/ {
			fail("Invalid value for adv_reachable_time (got ${adv_reachable_time}, expected integer)")
		}

		if $adv_reachable_time > 3600000 {
			fail("adv_reachable_time invalid: must be less than 3,600,000 milliseconds (one hour)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_reachable_time":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvRachableTime ${adv_reachable_time};"
		}
	}

	if $adv_retrans_timer != undef {
		if $adv_retrans_timer !~ /^\d+$/ {
			fail("Invalid value for adv_retrans_timer (got ${adv_retrans_timer}, expected integer)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_retrans_timer":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvRetransTimer ${adv_retrans_timer};"
		}
	}

	if $adv_cur_hop_limit != undef {
		if $adv_cur_hop_limit !~ /^\d+$/ {
			fail("Invalid value for adv_cur_hop_limit (got ${adv_cur_hop_limit}, expected integer)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_cur_hop_limit":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvCurHopLimit ${adv_cur_hop_limit};"
		}
	}

	if $adv_default_lifetime != undef {
		if $adv_default_lifetime !~ /^\d+(\.\d+)?$/ {
			fail("Invalid value for adv_default_lifetime (got ${adv_default_lifetime}, expected decimal number)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_default_lifetime":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvDefaultLifetime ${adv_default_lifetime};"
		}
	}

	if $adv_default_preference != undef {
		if $adv_default_preference != "low" and $adv_default_preference != "medium" and $adv_default_preference != "high" {
			fail("Invalid value for adv_default_preference (got ${adv_default_preference}, expected low|medium|high)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_default_preference":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvDefaultPreference ${adv_default_preference};"
		}
	}

	if $adv_source_ll_address != undef {
		$adv_source_ll_address_value = $adv_source_ll_address ? {
			true    => 'on',
			false   => 'off',
			default => fail("Invalid value for adv_source_ll_address (got ${adv_source_ll_address}, expected true/false)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_source_ll_address":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvSourceLLAddress ${adv_source_ll_address_value};"
		}
	}

	if $adv_home_agent_flag != undef {
		$adv_home_agent_flag_value = $adv_home_agent_flag ? {
			true    => 'on',
			false   => 'off',
			default => fail("Invalid value for adv_home_agent_flag (got ${adv_home_agent_flag}, expected true/false)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_home_agent_flag":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvHomeAgentFlag ${adv_home_agent_flag_value};"
		}
	}

	if $adv_home_agent_info != undef {
		$adv_home_agent_info_value = $adv_home_agent_info ? {
			true    => 'on',
			false   => 'off',
			default => fail("Invalid value for adv_home_agent_info (got ${adv_home_agent_info}, expected true/false)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_home_agent_info":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvHomeAgentInfo ${adv_home_agent_info_value};"
		}
	}

	if $home_agent_lifetime != undef {
		if $home_agent_lifetime !~ /^\d+(\.\d+)?$/ {
			fail("Invalid value for home_agent_lifetime (got ${home_agent_lifetime}, expected decimal number)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/home_agent_lifetime":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	HomeAgentLifetime ${home_agent_lifetime};"
		}
	}

	if $home_agent_preference != undef {
		if $home_agent_preference !~ /^\d+$/ {
			fail("Invalid value for home_agent_preference (got ${home_agent_preference}, expected integer)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/home_agent_preference":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	HomeAgentPreference ${home_agent_preference};"
		}
	}

	if $adv_mob_rtr_support_flag != undef {
		$adv_mob_rtr_support_flag_value = $adv_mob_rtr_support_flag ? {
			true    => 'on',
			false   => 'off',
			default => fail("Invalid value for adv_mob_rtr_support_flag (got ${adv_mob_rtr_support_flag}, expected true/false)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_mob_rtr_support_flag":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvMobRtrSupportFlag ${adv_mob_rtr_support_flag_value};"
		}
	}

	if $adv_interval_opt != undef {
		$adv_interval_opt_value = $adv_interval_opt ? {
			true    => 'on',
			false   => 'off',
			default => fail("Invalid value for adv_interval_opt (got ${adv_interval_opt}, expected true/false)")
		}

		bitfile::bit { "/etc/radvd.conf:interface=${name}/adv_interval_opt":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "	AdvIntervalOpt ${adv_interval_opt_value};"
		}
	}

	if $clients != undef {
		$client_list = join($clients, "\n\t\t")

		bitfile::bit { "/etc/radvd.conf:interface=${name}/clients":
			path    => "/etc/radvd.conf",
			parent  => "/etc/radvd.conf:interface=${name}",
			content => "\tclients {\n\t\t${client_list}\n\t};"
		}
	}
}
