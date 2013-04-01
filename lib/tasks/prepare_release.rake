require 'fileutils'
namespace :my do
  desc 'prepare release to stage'
  task :release do
    puts "target release environment:#{ENV['target']}"
    Rake::Task['my:clean_cert'].invoke
    Rake::Task['my:copy_files'].invoke
    
  end
  
  desc 'clean cert'
  task :clean_cert do
    puts 'begin remove cert files'
    Dir.chdir("D:/RubyPros/IntimeService/.elasticbeanstalk")
    Dir.glob("*").each do |f|
      File.delete(f) unless File.directory? f
    end
    puts 'removed cert fiels.'
    puts 'begin remove aws credential'
    Dir.chdir("C:/Users/yi/.elasticbeanstalk")
    Dir.glob("*").each do |f|
      File.delete(f) unless File.directory? f
    end
    puts 'removed aws credential'
  end 
  
  desc 'copy all files under some directory'
  task :copy_files do
    release_env = ENV['TARGET']
    release_env ||= 'stage'
    cert_basedir = 'D:/RubyPros/IntimeService/.elasticbeanstalk'
    Dir.chdir("#{cert_basedir}/#{release_env}")
    Dir.glob("*").each do |f|
      FileUtils.cp(f,cert_basedir) unless File.directory? f
    end
    aws_cre = 'C:/Users/yi/.elasticbeanstalk'
    Dir.chdir("#{aws_cre}/#{release_env}")
    Dir.glob("*").each do |f|
      FileUtils.cp(f,aws_cre) unless File.directory? f
    end
    puts "completed!"
  end
end
