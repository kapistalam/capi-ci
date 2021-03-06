#!/usr/bin/env bash

set -e

source ~/.bashrc

function setup_git_user() {
  pushd api-docs
    git config user.name "${GIT_COMMIT_USERNAME}"
    git config user.email "${GIT_COMMIT_EMAIL}"
  popd
}

function update_versions_json() {
  capi-ci/ci/docs/update_docs_v2.rb
}

function copy_to_output_dir() {
  cp -ar api-docs updated-api-docs/
}

function commit_updated_versions() {
  pushd api-docs
    if [[ -n $(git status --porcelain) ]]; then
      git add -A
      git commit -m "Update cf-deployment-api-versions"
    fi
  popd
}

function main() {
  setup_git_user
  update_versions_json
  commit_updated_versions
  copy_to_output_dir
}

main
