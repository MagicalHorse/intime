require 'uuid'
directory "tasks"
namespace :my do
  desc 'generate key'
  task :genkey=>:environment  do
    new_key = AuthKey.create :private=>UUID.new.generate,:publickey=>'intimedemo',:status=>1,:desc=>'demo only for intime'
    puts "generate public key :#{new_key.publickey}, private key:#{new_key.private}"

  end
end