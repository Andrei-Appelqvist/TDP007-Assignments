# coding: utf-8
require 'rexml/document'
include REXML

class Event
  def initialize(title, desc, local, region, address,
                 publisher, date, link)
    @title = title
    @desc = desc
    @local = local
    @region = region
    @address = address
    @publisher = publisher
    @date = date
    @link = link
  end

  def printer()
    puts "--------------------------"
    puts "Start of object"
    puts "Title: #{@title}"
    puts "Description: #{@desc}"
    puts "Local: #{@local}"
    puts "Region: #{@region}"

    if @address.length != 0
      #Kollar så att det finns addressinformation att skriva ut
      puts "Address: #{@address}"
    end

    puts "Publisher: #{@publisher}"
    puts "Date: #{@date}"

    if @link.length != 0
      #Kollar så att det finns länkinformation att skriva ut
      puts "Link: #{@link}"
    end

    puts "End of object"
  end
end

def clean(mtch)
  #Rensar bort alla taggar och tar ut den informationen vi är intresserade av.
  String(mtch).match(/(?<=>).*(?=<)/).to_s
end

def main
  object_array = Array.new
  file = File.new("events.html")
  doc = REXML::Document.new file
  #Detta matchar till varje event section går går därefter genom varje element

  section = doc.elements.each(".//div[@class = 'vevent']"){|s|
    title =  s.elements[".//span[@class = 'summary']"]
    title = clean(title)
    desc =  s.elements[".//td[@class = 'description']"]
    desc = clean(desc)

    #Ifall description innehåller ordet quot matchar vi istället innanför dessa.
    if desc.include? "quot"
      desc = String(desc).match(/(?<=\&quot;)(.*)(?=&quot)/)
    end

    local = s.elements[".//span[@class = 'locality']"]
    local = clean(local)
    region = s.elements[".//span[@class = 'region']"]
    region = clean(region)
    address = s.elements[".//span[@class = 'street-address']"]
    address = clean(address)
    publisher = s.elements[".//td/a[@class = 'userLink ']"]
    publisher = clean(publisher)
    date = s.elements[".//td/span[@class = 'dtstart']"]
    date = clean(date)
    link = s.elements[".//td/a[@target = '_NEW']"]
    link = clean(link)

    #Skapar ett eventobjekt
    obj = Event.new(title, desc, local, region, address, publisher, date, link)
    object_array << obj
  }

  object_array.each { | o | o.printer }
  return object_array
end

main
