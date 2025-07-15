#!/bin/bash

# SECTION: special environment variables (normal env vars set in work.nix)

export PATH="/opt/homebrew/bin:$PATH"

# TODO: handle env secrets better (prob sops + age in flake .env)
source "$HOME/.work/env.sh"

# SECTION: functions

function mgke {
  if [ $# -eq 0 ]; then
    echo "Usage: mgke <environment> <region> only specify region if you want to connect to US, default is EU"
    echo "Example: mgke test us"
    return 1
  fi
  if [ $2 = "us" ]; then
    gcloud container clusters get-credentials ccoe-us-central1-$1-1 --region us-central1 --project ingka-managed-gke-$1
    gcloud config set project ingka-managed-gke-$1
    gcloud auth application-default set-quota-project ingka-managed-gke-$1
  else
    gcloud container clusters get-credentials ccoe-europe-west4-$1-1 --region europe-west4 --project ingka-managed-gke-$1
    gcloud config set project ingka-managed-gke-$1
    gcloud auth application-default set-quota-project ingka-managed-gke-$1
  fi
}

# FIXME: implemement this
function ocp_login() {
  if [ -z "$1" ]; then
    echo "Usage: ocp <cluster-name>"
    return 1
  fi

  CLUSTER_NAME="$1"

  # Assuming you have a configuration file or a way to get the cluster details
  # Here, we will use a hypothetical command to get the cluster's API URL and token
  # You may need to adjust this part based on your actual setup

  # Example: Fetching the cluster's API URL and token (replace with your actual method)
  API_URL=$(get_api_url_for_cluster "$CLUSTER_NAME") # Replace with your method
  TOKEN=$(get_token_for_cluster "$CLUSTER_NAME")     # Replace with your method

  if [ -z "$API_URL" ] || [ -z "$TOKEN" ]; then
    echo "Failed to retrieve API URL or token for cluster: $CLUSTER_NAME"
    return 1
  fi

  # Log in to the OpenShift cluster
  oc login "$API_URL" --token="$TOKEN"

  if [ $? -eq 0 ]; then
    echo "Successfully logged into cluster: $CLUSTER_NAME"
  else
    echo "Failed to log into cluster: $CLUSTER_NAME"
  fi
}

# fix home monitor resolution problems
# NOTE: should no longer be a problem with TB4 cable since it enables VRR
function fix_uwd_resolution() {
  screenresolution set 3440x1440x32@144
}

function jira_login() {
  file="$HOME/.work/env.sh"
  # if file exists, source it
  if [ -f "$file" ]; then
    source "$file"
  else
    echo "JIRA environment file not found. Create $file and add JIRA_API_TOKEN."
    return 1
  fi
}
