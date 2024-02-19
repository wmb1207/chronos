require './project'

puts "HELLO WORLD!"

project = Project.new("personal/chronos", "A time tracking application - don't waste time", "wmb")
project.describe
project.cd
