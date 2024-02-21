require 'optparse'
require './lib/project'


class Main

  def self.run
    projects = Project.from_configs
    options = parse_options(projects.map(&:name))
    project = projects.find { |p| p.name == options[:project] }
    unless options[:main_branch].nil?
      project.main_branch = options[:main_branch]
    end
    project.cd
    project.update_branch
  end
  def self.parse_options(available_projects)
    options = {}
    OptionParser.new do |opts|
      opts.on("-mb", "--main_branch", "Set a custom main branch") do |v|
        options[:main_branch] = v
      end
      opts.on("-pPROJECT", "--project=PROJECT", "Select an specific project") do |project|
        if project && !available_projects.include?(project)
          raise "Invalid project name"
        end
        p project
        options[:project] = project
      end
    end.parse!
    options
  end
end


Main.run