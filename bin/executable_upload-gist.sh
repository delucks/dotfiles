#!/usr/bin/env bash

error() {
  >&2 echo "$1"
  exit 1
}

for dependency in curl jo jq; do
  hash "$dependency" 2>/dev/null || error "$0 depends on $dependency"
done

# Defaults
PUBLIC=false
DESCRIPTION="Gist uploaded by $0 at $(date)"
USERNAME="${GITHUB_USERNAME:-delucks}"
TOKEN="$GITHUB_TOKEN"

# Argument Parsing
usage() {
  echo "Usage: $0 [OPTIONS] [FILE]..."
  echo "Upload a gist to Github's API using jo, curl, and jq"
  echo
  echo "    -h    --help        View this help message"
  echo "    -p    --public      Make the new gist public"
  echo "    -d/-m --description Set the description for the new gist"
  echo "    -u    --username    Your Github username (\$GITHUB_USERNAME)"
  echo "    -t    --token       A Github personal access token with gist scope (\$GITHUB_TOKEN)"
  echo
  echo "Example: $0 --public -d 'My cool gist'"
}

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    -p|--public)
      PUBLIC=true
      shift
      ;;
    -d|-m|--description)
      DESCRIPTION="$2"
      shift
      shift
      ;;
    -u|--username)
      USERNAME="$2"
      shift
      shift
      ;;
    -t|--token)
      TOKEN="$2"
      shift
      shift
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

set -- "${POSITIONAL[@]}"

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

for path in "$@"; do
  test -f "$path" 2>/dev/null || error "$path is not a valid file"
done

# Prepare a temp directory to dump each file's JSON payload into
tmpdir=$(mktemp -d)
cleanup() {
  rm -r "$tmpdir"
}
trap cleanup EXIT

for f in "$@"; do
  b=$(basename "$f")
  jo content="@$f" > "$tmpdir/$b"
done

# Assemble a set of arguments that create the "files" object in the main jo invocation
file_arguments=$(for f in "$@"; do b=$(basename "$f"); echo "files[$b]=:${tmpdir}/${b}"; done)
# Generate the full JSON payload
# shellcheck disable=SC2086
PAYLOAD=$(jo description="$DESCRIPTION" public="$PUBLIC" $file_arguments)

# Upload to the API
RESPONSE=$(curl -s -u "${USERNAME}:${TOKEN}" -X POST "https://api.github.com/gists" -d "$PAYLOAD")

# Error handling
error=$(jq -r .message <<< "$RESPONSE")
if [[ "$error" == "null" ]]; then
  echo "Gist uploaded to $(echo "$RESPONSE" | jq -r .html_url)"
elif [[ "$error" == *"Requires authentication"* ]]; then
  error "Authentication failed! Username: $USERNAME, Token: $GITHUB_TOKEN"
else
  error "Upload failed! $error"
fi
