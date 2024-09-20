#!/bin/bash

unset GUM_CHOOSE_HEADER_FOREGROUND
unset GUM_CHOOSE_CURSOR_FOREGROUND
unset GUM_CHOOSE_SELECTED_FOREGROUND
# TODO: Going for catppuccin colours, but something looks a bit off
# export GUM_CHOOSE_HEADER_FOREGROUND="#74c7ec" # blue
# export GUM_CHOOSE_HEADER_FOREGROUND="#f38ba8" # red
#
# export GUM_CHOOSE_CURSOR_FOREGROUND="b9baff"  # lavender
# export GUM_CHOOSE_SELECTED_FOREGROUND=$GUM_CHOOSE_CURSOR_FOREGROUND

# create a new Tab (in existing zellij session) with the specified layout
_zlo-t() {
  local wanted_layout=""
  local confirmed_layout=""

  # Check for options
  while [[ "$1" != "" ]]; do
    case $1 in
    --list | -l | --help | -h)
      # TODO: use gum for formatting list
      ls "$ZELLIJ_LAYOUTS" | sed 's/\.kdl$//' | sed 's/^/- /'
      return 0
      ;;
    *)
      wanted_layout=$1
      ;;
    esac
    shift
  done

  # if layout is specified and it exists, use it
  if [ "$wanted_layout" ]; then
    if [ -f "$ZELLIJ_LAYOUTS/$wanted_layout.kdl" ]; then
      confirmed_layout="$ZELLIJ_LAYOUTS/$wanted_layout.kdl"
    else
      gum style --foreground 1 --bold "Error: $ZELLIJ_LAYOUTS/$wanted_layout.kdl does not exist." >&2
    fi
  fi

  if [ -z "$wanted_layout" ]; then
    files=("$ZELLIJ_LAYOUTS"/*.kdl)
    confirmed_layout=$(gum choose --header="Choose a Tab layout:" "${files[@]}")
  fi

  # TODO: zellij --layout creates a NEW session, so shouldn't be used in an existing session
  zellij action new-tab --layout "$confirmed_layout"
}

# create a new Session (in existing zellij session) with the specified layout
_zlo-s() {
  local wanted_layout=""
  local confirmed_layout=""

  # Check for options
  while [[ "$1" != "" ]]; do
    case $1 in
    --list | -l | --help | -h)
      # TODO: use gum for better list
      ls "$ZELLIJ_SESSION_LAYOUTS" | sed 's/\.kdl$//' | sed 's/^/- /'
      return 0
      ;;
    *)
      wanted_layout=$1
      ;;
    esac
    shift
  done

  # if layout is specified and it exists, use it
  if [ "$wanted_layout" ]; then
    if [ -f "$ZELLIJ_SESSION_LAYOUTS/$wanted_layout.kdl" ]; then
      confirmed_layout="$ZELLIJ_SESSION_LAYOUTS/$wanted_layout.kdl"
    else
      gum style --foreground 1 --bold "Error: $ZELLIJ_SESSION_LAYOUTS/$wanted_layout.kdl does not exist." >&2
    fi
  fi

  if [ -z "$confirmed_layout" ]; then
    files=("$ZELLIJ_SESSION_LAYOUTS"/*.kdl)
    confirmed_layout=$(gum choose --header="Choose a Session layout:" "${files[@]}")
  fi

  session_name=$(basename "$confirmed_layout" .kdl)

  zellij --layout "$confirmed_layout" attach --create "$session_name"
}

_zlo-h() {
  gum style --bold --foreground 2 "Usage: zlo [OPTIONS]"
  echo
  gum style --italic "Options:"
  gum style --italic "  -h (--help)            Show this help"
  echo
  gum style --italic "Description:"
  gum style --italic "  zlo is a wrapper around zellij that allows creation of sessions and tabs with a specified layout."

  echo
  gum style --italic "Commands:"
  gum style --italic "  (t)ab <filename>       Create new zellij tab in the current session, using specified layout"
  gum style --italic "  (s)ession <filename>   Start new zellij session with specified layout (use filename as session name)"
}

# create a new zellij session or tab with the specified layout
zlo() {
  if [ $# -lt 1 ]; then
    _zlo-h
    return 1
  fi

  # Check for options
  while [[ "$1" != "" ]]; do
    case $1 in
    --help | -h)
      _zlo-h
      return 0
      ;;
    session | s)
      _zlo-s "$2"
      return 0
      ;;
    tab | t)
      _zlo-t "$2"
      return 0
      ;;
    *)
      gum style --foreground 1 "Error: Invalid option '$1'" >&2
      _zlo-h
      return 1
      ;;
    esac
    shift
  done
}
