desc 'prepare release to stage'
task :release_stage do
  Rake::Task[:clean_cert].invoke!
  
end

desc 'prepare release to production'
task :release_production do
  
end

desc 'clean cert'
task :clean_cert do
  Dir.chdir("D:/RubyPros/IntimeService/.elasticbeanstalk")
  Dir.glob("*").each do |f|
    File.delete(f) unless File.directory? f
  end
  Dir.chdir("C:/Users/yi/.elasticbeanstalk")
  Dir.glob("*").each do |f|
    File.delete(f) unless File.directory? f
  end
end

