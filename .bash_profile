# Open any file or folder in Sublime Text:
#
# > subl ~/.bash_profile
#
# If no path is provided, it defaults to the current folder.

function subl() {
  open ${1-.}  -a /Applications/Sublime\ Text.app/
}

# If the only MySQL instance is the one that comes
# with MAMP, you'll need to alias it to use it 
# from the command line.

alias mysql=/Applications/MAMP/Library/bin/mysql

# Some rbenv stuff I don't understand

eval "$(rbenv init -)"

# Start a small Python server to serve the files
# from the current folder on http://localhost:8000/

# Python 2.x version
alias pys="python -m SimpleHTTPServer"

# Python 3.x version (commented out for now)
# alias pys="python3 -m http.server"

# Yarn package manager
export PATH="$HOME/.yarn/bin:$PATH"

############################
### Useful Git Functions ###
############################

# Outputs the list of conflicted files after a Git merge operation

function conflicted() {
	git ls-files -u | cut -f 2 | sort -u
}

# When you have shitty conflicts on a merge, use:
#
# > parted branch1 branch2 path/to/some/file.js
#
# to see how the file has changed on each of the two branches
# starting from their closest common ancestor.
#
# If the second branch is ommitted, it is assumed to be HEAD.
#
# If a path to a file is ommitted, the diff runs
# on all the files currently marked as conflicted. 
# 
# If no files are conflicted, or you haven't done a merge,
# it runs on all the files in the repo.
#
# This is currently set up to work with an external diff tool,
# but replacing `difftool` with `diff` will run it through Git's normal diff.

function parted() {
  git difftool --minimal $(git merge-base $1 ${2:-HEAD}) $1 -- ${3:-$(conflicted)}
  git difftool --minimal $(git merge-base $1 ${2:-HEAD}) ${2:-HEAD} -- ${3:-$(conflicted)}
}
