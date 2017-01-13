function docker-clean
  docker rm (docker ps -a -q)
  docker rmi -f (docker images -q)
end