namespace :films do
  task :fast_torrent do
    Mechanize.new do |agent|
      agent.user_agent_alias = 'Mac Firefox'
      agent.follow_meta_refresh = true
      per_page = 1

      ['new-films'].each do |section| # 'new-torrent'
        20.times do
          page =
            if per_page == 1
              agent.get("http://www.fast-torrent.ru/#{section}/")
            else
              agent.get("http://www.fast-torrent.ru/#{section}/#{per_page}.html")
            end

          page.search('.film-item').each do |item|
            download = agent.get(item.search('.film-download').attr('href').value)
            download.search('.torrent-row').each do |row|
              if (row.search('.c3').text.to_f < 3 &&
                  Film.where("title LIKE ?", "%#{item.search('h2').text}%").empty?)
                torrent = row.search('.c7 a').attr('href').value
                Dir.chdir("#{Dir.home}/Downloads")
                system("wget 'http://www.fast-torrent.ru#{torrent}' > /dev/null 2>&1")

                Film.new(title: item.search('h2').text,
                         image: download.search('.film-image a').attr('href').value,
                         genre: item.search('.film-genre').text,
                         announce: item.search('.film-announce').text,
                         torrent_file: torrent.split('/')[-1]).save!
              end
            end
          end

          per_page += 1
        end
      end
    end
  end
end
