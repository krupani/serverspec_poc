#MUST BE ON burkulesanju network to run this file
require 'spec_helper_opex'

describe port(22) do
  it { should be_listening }
end

describe file('/etc/hosts') do
  it { should exist }
  it { should be_file }
end

describe command("whoami") do
	its(:stdout){should match "root"}
end

describe command("ifconfig") do
	its(:stdout){should match "192.168.1.10"}
end