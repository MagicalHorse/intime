namespace :my do
  desc 'export card'
  task :export_card=>:environment  do
    puts "export all binded card"
    
    CSV.open("log/card.csv","wb") do |file|
      puts "total cards:#{Card.where(:isbinded=>true).count}"
      current_index = 1
      Card.where(:isbinded=>true).each do |card|
        file <<[card.utoken,card.decryp_card_no]
        current_index = current_index+1
        puts "write#{current_index}"
      end
    end
  end
end