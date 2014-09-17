require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS
include Serverspec::Helper::Properties

packages = %w(git libao-dev libssl-dev libcrypt-openssl-rsa-perl libio-socket-inet6-perl libwww-perl avahi-utils libmodule-build-perl)
packages.each do |pkg|
  describe package pkg do
    it { should be_installed }
  end
end

describe file '/usr/local/bin/shairport' do
  it { should be_file }
end

describe file '/etc/init.d/shairport' do
  it { should be_file }
  it { should be_owned_by "root" }
  it { should be_grouped_into "root" }
  it { should be_mode "755" }
end

describe service 'shairport' do
  it { should be_enabled }
  it { should be_running }
end
