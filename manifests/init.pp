# == Class: riak
#
# Deploy and manage Riak.
#
class riak (
  $package_name       = $::riak::params::package_name,
  $service_name       = $::riak::params::service_name,
  $manage_package       = $::riak::params::manage_package,
  $manage_repo          = $::riak::params::manage_repo,
  $version            = $::riak::params::version,
  $ulimits_nofile_soft  = $::riak::params::ulimits_nofile_soft,
  $ulimits_nofile_hard  = $::riak::params::ulimits_nofile_hard,
  $settings = {},
) inherits ::riak::params {
  if $manage_repo and $manage_package {
    include ::riak::repository
  }
  if $manage_package {
    include ::riak::install
    Package[$::riak::package_name] ~> File[$::riak::params::riak_conf]
  }
  class { '::riak::config': } ~>
  class { '::riak::service': } ->
  Class['::riak']
}
