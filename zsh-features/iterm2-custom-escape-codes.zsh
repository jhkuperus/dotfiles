
# iTerm2 Tab Color Helpers

function tab_color_blue() {
  printf "\033]6;1;bg;red;brightness;0\a\033]6;1;bg;green;brightness;0\a\033]6;1;bg;blue;brightness;90\a"
}

function tab_color_yellow() {
  printf "\033]6;1;bg;red;brightness;90\a\033]6;1;bg;green;brightness;90\a\033]6;1;bg;blue;brightness;0\a"
}

function tab_color_default() {
  printf "\033]6;1;bg;*;default\a"
}

