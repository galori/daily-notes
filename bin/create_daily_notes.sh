#!/bin/bash
export HOME=/users/gall
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init -)"
fi

cd /Users/gall/workspace/daily-notes
bundle exec "bin/create_daily_notes.rb" "/users/gall/Documents/Notes/Daily/"

#"/users/gall/workspace/daily-notes/bin/create_daily_notes" "/users/gall/Documents/Notes/Daily/"


