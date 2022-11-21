function git_ahead -a ahead behind diverged none
    not git_is_repo; and return

    set -l commit_count (command git rev-list --count --left-right "@{upstream}...HEAD" 2> /dev/null)

    switch "$commit_count"
        case ""
            # no upstream
        case "0"\t"0"
            test -n "$none"; and echo "$none"; or echo ""
        case "*"\t"0"
            test -n "$behind"; and echo "$behind"; or echo -
        case "0"\t"*"
            test -n "$ahead"; and echo "$ahead"; or echo "+"
        case "*"
            test -n "$diverged"; and echo "$diverged"; or echo "±"
    end
end

function git_branch_name -d "Get current branch name"
    git_is_repo; and begin
        command git symbolic-ref --short HEAD 2>/dev/null
        or command git show-ref --head -s --abbrev | head -n1 2>/dev/null
    end
end

function git_is_dirty -d "Check if there are changes to tracked files"
    git_is_worktree; and not command git diff --no-ext-diff --quiet --exit-code
end

function git_is_repo -d "Check if directory is a repository"
    test -d .git
    or begin
        set -l info (command git rev-parse --git-dir --is-bare-repository 2>/dev/null)
        and test $info[2] = false
    end
end

function git_is_staged -d "Check if repo has staged changes"
    git_is_repo; and begin
        not command git diff --cached --no-ext-diff --quiet --exit-code
    end
end

function git_is_stashed -d "Check if repo has stashed contents"
    git_is_repo; and begin
        command git rev-parse --verify --quiet refs/stash >/dev/null
    end
end

function git_is_touched -d "Check if repo has any changes"
    git_is_worktree; and begin
        # The first checks for staged changes, the second for unstaged ones.
        # We put them in this order because checking staged changes is *fast*.  
        not command git diff-index --cached --quiet HEAD -- >/dev/null 2>&1
        or not command git diff --no-ext-diff --quiet --exit-code >/dev/null 2>&1
    end
end

function git_is_worktree -d "Check if directory is inside the worktree of a repository"
    git_is_repo
    and test (command git rev-parse --is-inside-git-dir) = false
end

function git_untracked -d "Print list of untracked files"
    git_is_worktree; and begin
        command git ls-files --other --exclude-standard
    end
end
