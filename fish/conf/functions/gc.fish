function gc 
   set parts (string split / $argv)
   set repoParts (string split . $parts[-1])
   rm -rf ~/dev/tests/$repoParts[1] 
   git clone $argv ~/dev/tests/$repoParts[1]
   cd ~/dev/tests/$repoParts[1]
end
