# tmux-plugin-battery

This plugin let's you add the battery level to tmux status fields.


### Dependencies

This plugin uses `pmset`, `upower`, `acpi` or a custom battery script.

### Usage

Add one of the available values to your existing `status-left` or
`status-right` tmux option.

| Value | Description |
|-------|-------------|
| `#{battery_percentage}` | battery level in percent |

The plugin also has some options to change the indicator.

| Value | Description | Default |
|-------|-------------|---------|
| `@battery_pre_color` | Color code prepended to value | / |
| `@battery_post_color` | Color code appended to value | `#[default]` |
| `@battery_high_color` | Color code prepended for high battery level | `#[fg=colour2]` |
| `@battery_high_percentage` | Value for high battery level |  75 |
| `@battery_mid_color` | Color code prepended for middle battery level | `#[fg=colour3]` |
| `@battery_mid_percentage` | Value for middle battery level |  35 |
| `@battery_low_color` | Color code prepended for low battery level | `#[fg=colour1]` |
| `@battery_error_color` | Color code prepended for error codes | `#[fg=colour0]#[bg=colour1]` |
| `@battery_custom_percentage` | Custom script to get battery level | / |

Example:

    set -g status-right 'Bat:#{battery_percentage}% | %a %h-%d %H:%M '

    set -g @plugin 'GROG/tmux-plugin-battery'
    set -g @battery_high_percentage "50"
    set -g @battery_low_percentage "25"
    set -g @battery_custom_percentage "$HOME/.scripts/battery_percentage.sh"


### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'GROG/tmux-plugin-battery'

Hit `prefix + I` to fetch the plugin and source it.


### Manual Installation

Clone the repo:

    $ git clone https://github.com/GROG/tmux-plugin-battery ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/battery.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf


### Special credit

This plugin is roughly based on the various plugins in
[https://github.com/tmux-plugins](https://github.com/tmux-plugins).


### License

[MIT](LICENSE)


### Contibuting

All assistance, changes or ideas
[welcome](https://github.com/GROG/tmux-plugin-battery/issues)!


### Author

By [G. Roggemans](https://github.com/groggemans)
