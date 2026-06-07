function fish_right_prompt
    # Background jobs — only show when there are any
    set -l job_count (jobs -p | count)
    if test $job_count -gt 0
        set_color $fish_color_param
        echo -n "$job_count job"
        test $job_count -gt 1; and echo -n s
        set_color normal
        echo -n "  "
    end

    # Command duration — only show if >= 5s (CMD_DURATION is in milliseconds)
    if test $CMD_DURATION -ge 5000
        set -l secs (math --scale=0 "$CMD_DURATION / 1000")
        set_color $fish_color_comment
        if test $secs -ge 3600
            set -l h (math --scale=0 "$secs / 3600")
            set -l m (math --scale=0 "$secs % 3600 / 60")
            echo -n $h"h "$m"m"
        else if test $secs -ge 60
            set -l m (math --scale=0 "$secs / 60")
            set -l s (math --scale=0 "$secs % 60")
            echo -n $m"m "$s"s"
        else
            echo -n $secs"s"
        end
        set_color normal
    end
end
