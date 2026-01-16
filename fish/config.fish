set fish_greeting

if status --is-interactive
  fastfetch
end

eval $(/opt/homebrew/bin/brew shellenv)

abbr -a zj "zellij"
abbr -a lg "lazygit"
abbr -a tf "terraform"
abbr -a oc "opencode"

starship init fish | source
zoxide init fish | source
