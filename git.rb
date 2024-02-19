namespace :git do

  DEFAULT_TARGET_BRANCH = "main"
  #@@fallback_target_branch = "master"
  
  def update_branch(target_branch)
    if target_branch.nil? || target_branch.empty?
      target_branch = DEFAULT_TARGET_BRANCH
    end
    branch = current_branch
    stash
    switch target_branch
    pull
    switch branch
    merge target_branch
    apply
  end

  def current_branch
    `git rev-parse --abbrev-ref HEAD`.strip
  end

  def switch(branch)
    `git switch #{branch}`
    nil
  end

  def stash
    `git stash`
    nil
  end

  def apply
    `git stash apply`
    nil
  end

  def pull
    `git pull`
    nil
  end

  def merge(branch)
    `git merge #{branch}`
    nil
  end

end