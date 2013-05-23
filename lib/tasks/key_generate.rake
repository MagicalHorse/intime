require 'uuid'
directory "tasks"
namespace :my do
  desc 'generate key'
  task :genkey=>:environment  do
    new_key = AuthKey.create :private=>UUID.new.generate,:publickey=>'intime',:status=>1,:desc=>'intime department key'
    puts "generate public key :#{new_key.publickey}, private key:#{new_key.private}"

  end
end