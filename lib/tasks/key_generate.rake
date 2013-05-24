require 'uuid'
directory "tasks"
namespace :my do
  desc 'generate key'
  task :genkey=>:environment  do
    public_key = ENV['key']
    public_key ||= 'intime'
    puts "generate key for #{public_key}"
    new_key = AuthKey.create :private=>UUID.new.generate,:publickey=>public_key,:status=>1,:desc=>'intime department key'
    puts "generate public key :#{new_key.publickey}, private key:#{new_key.private}"

  end
end