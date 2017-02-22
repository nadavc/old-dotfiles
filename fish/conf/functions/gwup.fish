function gwup
   echo "Updating nebula-wrapper..."
   pushd ~/dev/stash/nebula/wrapper
   git pull --rebase
   popd
end
