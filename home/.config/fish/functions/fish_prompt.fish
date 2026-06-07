function fish_prompt
    set -l last_status 0
    if set -q __prompt_last_status[1]
        set last_status $__prompt_last_status
    end

    # Path — fish-style, 1 char per dir except the last
    set_color $fish_color_cwd
    echo -n (prompt_pwd --dir-length 1)
    set_color normal

    # Git branch + dirty indicator (this is the slow part; runs async)
    set -l branch (git branch --show-current 2>/dev/null)
    if test -n "$branch"
        echo -n " on "
        set_color $fish_color_param
        echo -n $branch
        set -l dirty (git status --porcelain 2>/dev/null)
        if test -n "$dirty"
            set_color $fish_color_end
            echo -n "*"
        end
        set_color normal
    end

    echo

    if test $last_status -eq 0
        set_color $fish_color_operator
    else
        set_color $fish_color_error
    end
    echo -n "❯ "
    set_color normal
end
