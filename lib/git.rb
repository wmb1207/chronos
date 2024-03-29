module Git

  DEFAULT_TARGET_BRANCH = "main"
  #@@fallback_target_branch = "master"

  def update_branch_with(target_branch)
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
  end

  def stash
    `git stash`
  end

  def apply
    `git stash apply`
  end

  def pull
    `git pull`
  end

  def merge(branch)
    `git merge #{branch} -m 'up to date with #{branch}'`
  end

end