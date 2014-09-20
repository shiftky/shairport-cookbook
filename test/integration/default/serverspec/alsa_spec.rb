require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS
include Serverspec::Helper::Properties

%w(alsa-base alsa-utils).each do |pkg|
  describe package pkg do
    it { should be_installed }
  end
end
