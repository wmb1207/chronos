require "./git"
require "toml-rb"

class Project
  include Git
  @@base_path = "/Users/wmb/src"

  def initialize(name, description, owner, main_branch = "main")
    @name = name
    @description = description
    @owner = owner
    @main_branch = main_branch
  end

  attr_accessor :name, :description, :owner

  def self.from_configs
    configs = TomlRB.load_file("config.toml")
    projects = configs["projects"]

    projects.map do |cfg|
      Project.new(cfg["name"], cfg["description"], cfg["owner"], cfg["main_branch"])
    end
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
    nil
  end

  def update_branch
    p "Switching to main branch: #{@main_branch}"
    update_branch_with @main_branch
    nil
  end
end