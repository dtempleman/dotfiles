
# Setting PATH for Python 3.11
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
export PATH


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/danielt/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/danielt/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/danielt/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/danielt/google-cloud-sdk/completion.zsh.inc'; fi
export KUBECONFIG="/Users/danielt/.kube/dev.config"
export PATH="/usr/local/bin/:$PATH"
