# create image-pull-secret for k8s artifactory
function create_ImagePullSecret() {
  username=$1
  namespace=$2

  # if username or namespace not set, error message
  if [ -z "$username" ] || [ -z "$namespace" ]; then
    echo "Usage: create_ImagePullSecret <username> <namespace>"
    return 1
  fi

  docker login artifactory.build.ingka.ikea.com -u "$username" &&
    kubectl -n $namespace create secret docker-registry image-pull-secret --from-file=~/.docker/config.json

  # if that doesnt work, try this:
  # kubectl -n <namespace> create secret docker-registry image-pull-secret --docker-server=artifactory.build.ingka.ikea.com \
  #   --docker-username=<username> --docker-password=<password> \
  #   --docker-email=dl.eventmanagement.platform.se@ingka.com

}
