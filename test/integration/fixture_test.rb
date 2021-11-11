describe file '/etc/systemd/system/chef-client.timer' do
  it { should exist }
end

describe file '/etc/chef/client.rb' do
  its('mode') { should cmp '0640' }
  its('content') { should match /chef_license "accept"/ }
  its('content') { should match /ssl_verify_mode :verify_none/ }
  its('content') { should match /log_location :syslog/ }
end

describe file '/etc/chef/test_file' do
  its('content') { should match /This is some text in a file/ }
  its('mode') { should cmp '0755' }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file '/tmp/super_secret' do
  its('content') { should match /super secret stuff/ }
  its('mode') { should cmp '0755' }
  its('owner') { should eq 'nobody' }
  it { should be_owned_by 'nobody' }
end

describe file '/tmp/super_secret2' do
  its('content') { should match /more secret stuff/ }
  its('mode') { should cmp '0644' }
end
