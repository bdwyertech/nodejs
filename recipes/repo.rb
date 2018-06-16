case node['platform_family']
when 'debian'
  package 'nodejs-apt-transport-https' do
    package_name 'apt-transport-https'
  end

  apt_repository 'node.js' do
    uri node['nodejs']['repo'] % { major_ver: node['nodejs']['version'].to_i }
    distribution node['lsb']['codename']
    components ['main']
    keyserver node['nodejs']['keyserver']
    key node['nodejs']['key']
  end
when 'rhel', 'amazon'
  yum_repository 'node.js' do
    description 'nodesource.com nodejs repository'
    baseurl node['nodejs']['repo'] % { major_ver: node['nodejs']['version'].to_i }
    gpgkey node['nodejs']['key']
  end
end
