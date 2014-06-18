require 'fileutils'
require 'redcarpet'

#FIXME - Make non-unix specific
`cd 18xx-rules-differences; rake`
`rm -rf ./games`

FileUtils::mkdir_p 'games'

renderer = Redcarpet::Render::HTML.new
markdown = Redcarpet::Markdown.new renderer

games = []

Dir.glob('18xx-rules-differences/build/*.md') do |file|
  game_file_name = "games/" + file.split('/').last.gsub('.md', '').gsub(' ', '_') + ".html"

  File.open(game_file_name, 'w') do |file|
    file.write(markdown.render File.read(file))
  end
  games << game_file_name
end

File.open('index.html', 'w') do |file|
  games.each do |game|
    file.write "<a href='#{game}'>#{game.gsub('games/', '')}</a>\n"
  end
end
