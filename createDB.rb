require mysql

my = Mysql::new('localhost', 'user', 'passwd', 'db')
res = my.query("select * from tbl")
res.each do |row|
  col1 = row[0]
  col2 = row[1]
end
