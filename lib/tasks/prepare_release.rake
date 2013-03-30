desc 'prepare release to stage'
task :release_stage do
  Rake::Task[:clean_cert].invoke!
  
end

desc 'prepare release to production'
task :release_production do
  
end

desc 'clean cert'
task :clean_cert do
  Dir.open("D:/RubyPros/IntimeService/.elasticbeanstalk").each do |f|
    File.delete(f) unless File.directory? f
  end
    Dir.open("C:/Users/yi/.elasticbeanstalk").each do |f|
    File.delete(f) unless File.directory? f
  end
end

