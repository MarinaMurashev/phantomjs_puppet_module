class phantomjs (
  $package_version = "1.9.2",
  $install_dir = "/usr/local/share"
) {

  $source_url = "https://phantomjs.googlecode.com/files/phantomjs-${package_version}-linux-x86_64.tar.bz2"
  $source_dir = "${install_dir}/phantomjs-${package_version}-linux-x86_64/bin/phantomjs"
  $downloaded_file = "phantomjs-${package_version}-linux-x86_64.tar.bz2"

  exec { 'download-phantomjs':
    command => "wget ${source_url}",
    unless => "grep . ${downloaded_file}",
    cwd => "${install_dir}"
  }

  exec { 'install-phantomjs':
    command => "tar xjf ${downloaded_file}",
    unless => "grep . phantomjs",
    cwd => "${install_dir}",
    require => Exec['download-phantomjs']
  }

  exec { 'symlink-phantomjs-usr-local-share':
    command => "ln -s ${source_dir} ${install_dir}/phantomjs",
    cwd => "${install_dir}",
    unless => "find -L ${install_dir}/phantomjs -samefile ${source_dir}",
    require => Exec['install-phantomjs']
  }

  exec { 'symlink-phantomjs-usr-local-bin':
    command => "ln -s ${source_dir} /usr/local/bin/phantomjs",
    cwd => "${install_dir}",
    unless => "find -L /usr/local/bin/phantomjs -samefile ${source_dir}",
    require => Exec['install-phantomjs']
  }

  exec { 'symlink-phantomjs-usr-bin':
    command => "ln -s ${source_dir} /usr/bin/phantomjs",
    cwd => "${install_dir}",
    unless => "find -L /usr/bin/phantomjs -samefile ${source_dir}",
    require => Exec['install-phantomjs']
  }

}
