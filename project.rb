class Project
  @@base_path = "/Users/wmb/src"

  attr_accessor :name, :description, :owner

  def initialize(name, description, owner)
    @name = name
    @description = description
    @owner = owner
  end


  def describe
    puts "Project: #{@name}"
    puts "Description: #{@description}"
    puts "Owner: #{@owner}"
  end


  def cd
    namespace_project_name = @name.split("/")
    if namespace_project_name.length == 1
      raise "Invalid project name - must have a namespace"
    end

    namespace = namespace_project_name[0]
    project_name = namespace_project_name[1..].join("/")
    path = "#{@@base_path}/#{namespace}/#{project_name}"

    if Dir.exist?(path)
      Dir.chdir(path)
    else
      raise "Invalid project name - path does not exist"
    end
    puts "Changed to directory: #{path}"
    puts Dir.pwd
  end
end