require 'spec_helper_local'

describe package('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('apache2') do
  it { should be_enabled }
  it { should be_running }
end

%w(80 8080).each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe service('openvpn') do
  it { should be_enabled }
  it { should_not be_running }
end

%w(firefox skype ruby git).each do |pk|
  describe package(pk) do
    it {should be_installed}
  end
end

describe service('tomcat7') do
  it { should be_enabled }
  it { should be_running }
end

%w(/etc/hosts /etc/ssh/ssh_config).each do |f|
  describe file(f) do
    it {should exist}
    it {should be_file}
    it {should_not be_directory}
  end
end

packages_with_version = YAML.load_file(File.dirname(__FILE__) + "/../../data/packages.yml")
packages_with_version.each do |pkg,ver|
  describe package(pkg) do
    it {should be_installed.by('gem').with_version(ver)}
  end
end

packages_only = File.read(File.dirname(__FILE__) + "/../../data/package_name.txt").split("\n")
packages_only.each do |pkg|
  describe package(pkg) do
    it {should be_installed}
  end
end

describe file('/home/kaushal/Desktop/test.txt') do
  txt = "qwerty"
  its(:content){ should match txt}
end