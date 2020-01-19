def get_data(file)
  text = File.open(file).read

  re = /[0-9]{2,3}\W?\s{3,4}[0-9]{2,3}/
  scores = text.scan(re)
  ny_lst = scores.map{|x|
    x.to_s.split(/    |\*   /)}
    ny_lst
end

def make_table(lst)
  table = Hash.new
  for i in 0..(lst.length - 1)
    a = lst[i][1].to_i
    b = lst[i][0].to_i
    c = a - b
    table[i+1] = c.abs
  end
  table
end



def sort_table(table, lst)
  sor_ar = table.sort_by{|k,v| -v}
  dag = sor_ar[(lst.length - 1)][0]
  temp = sor_ar[(lst.length - 1)][1]

  puts "Dagen med minst skillnad mellan minsta och högsta temperatur är dag #{dag} med en skillnad på #{temp} grad(er)."
  puts " "
  sor_ar.each do |d|
    dag = d[0]
    temp = d[1]
    puts "Dag: #{dag.to_s.ljust(2)} - Tempskillnad: #{temp}"
  end
  return sor_ar
end
