
def get_score(file)
  text = File.open(file).read
  re = /[0-9]{2}\s+-\s+[0-9]{2}/
  scores = text.scan(re)
  scores = scores.each do|s|
    s.gsub!(/[\s]/,'')
  end
  return scores
end

def get_teams(file)
  text = File.open(file).read
  re_team = /(\.\s[a-zA-Z]{3,}_[a-zA-Z]+|\.\s[a-zA-Z]{3,})/
  teams = text.scan(re_team)
  teams = teams.each do|s|
    s[0].gsub!(/.\s|\[|\]/,'')
  end
  return teams
end

def make_hash(scores, teams)
  table = Hash.new
  for i in 0..(teams.length - 1)
    a = scores[i][0..1].to_i
    b = scores[i][3..4].to_i
    c = a - b
    name = teams[i][0]
    table[name] = c.abs
  end
  table
end

def print_min(table)
  print "Laget med minst skillnad mellan gjorda och mottagna mål är: "
  asdf = table.min_by {|k,v| v}
  puts asdf[0] + " " + asdf[1].to_s
  return asdf
end

def print_ordered(table)
  puts "Rangordningen med avseende på målskillnad(absolutvärde) ser ut såhär:"
  puts " "
  table = table.sort_by {|k,v| -v}
  table.each do |team, diff|
    print team + " "
    puts diff
  end
  return table
end
=begin
scores = get_score("football.txt")
teams = get_teams("football.txt")

table = make_hash(scores, teams)
print_min(table)
print_ordered(table)
=end 
