require 'net/http'
require 'json'
require 'mail'

# refer: https://github.com/HackerNews/API
def get(url)
  uri =  URI(url)
  res = Net::HTTP.get(uri)
  return JSON.parse(res)
end

url = "https://hacker-news.firebaseio.com/v0/beststories.json"
stories = get(url)

body = "<ol>"
stories[0...1].each do |story_id|
  p story_id
  story_url = "https://hacker-news.firebaseio.com/v0/item/#{story_id}.json"
  story = get(story_url)
  sleep 1

  body += "<li><a href='#{story['url']}'>#{story['title']}</a><br>" \
    "<p>#{story['score']} points - " \
    "#{story['descendants']} <a href='https://news.ycombinator.com/item?id=#{story_id}'>" \
    "comments</a></p></li>"
end
body += "</ol>"

mail = Mail.new do
  from "localhost"
  to "hiepph@hey.com"
  subject "Hacker News Top Stories"

  html_part do
    content_type "text/html; charset=UTF-8"
    body body
  end
end
mail.delivery_method :sendmail
mail.deliver!
