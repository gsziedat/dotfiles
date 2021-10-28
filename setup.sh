if [ "$CODESPACES" = "true" ]; then
  if [ -z "$SSH_AUTH_SOCK" ]; then
    RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
    if [ "$RUNNING_AGENT" = "0" ]; then
      # Launch a new instance of the agent
      mkdir $HOME/.ssh
      ssh-agent -s &> $HOME/.ssh/ssh-agent
    fi
    eval `cat $HOME/.ssh/ssh-agent`
  fi
  # Add my SSH key. 
  if [ -n "${PERSONAL_SSH_KEY+1}" ]; then
    ssh-add - <<< "${PERSONAL_SSH_KEY}"
  fi
fi
