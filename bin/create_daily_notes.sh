#!/bin/bash

# Ensure rbenv's bin is in PATH
export PATH="$HOME/.rbenv/bin:$PATH"

# Initialize rbenv; this sets up shims for Ruby versions
if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

cd /Users/gall/workspace/daily-notes
bundle exec bin/create_daily_notes.rb "/users/gall/Documents/Notes/Daily/"