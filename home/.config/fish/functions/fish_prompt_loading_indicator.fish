function fish_prompt_loading_indicator
    set -l last_status 0
    if set -q __prompt_last_status[1]
        set last_status $__prompt_last_status
    end

    # Path dimmed to signal that git info is still loading
    set_color --dim $fish_color_cwd
    echo -n (prompt_pwd --dir-length 1)
    set_color --dim
    echo -n " …"
    set_color normal

    echo

    # Prompt character — reliable here since we're synchronous
    if test $last_status -eq 0
        set_color $fish_color_operator
        echo -n "❯ "
    else
        set_color $fish_color_error
        echo -n "✘ "
    end
    set_color normal
end
