#!/usr/bin/env bash

# make.sh
#
# Copyright (c) 2023 Kristofer Berggren
# All rights reserved.
#
# nchat is distributed under the MIT license.

# This script updates a brew formula to point to latest available Github
# release.

REPOSITORY="https://github.com/d99kris/nchat"

command -v curl > /dev/null
if [[ "${?}" != "0" ]]; then
  echo "curl is not installed."
  exit 1
fi

RELEASE_URL=$(curl -Ls -o /dev/null -w %{url_effective} "${REPOSITORY}/releases/latest")
if [[ "${RELEASE_URL}" == "" ]]; then
  echo "cannot determine release url."
  exit 1
fi

VERSION=$(echo "${RELEASE_URL}" | awk -F/ '{print $NF}')
if [[ "${VERSION}" == "" ]]; then
  echo "cannot determine version."
  exit 1
fi

PACKAGE_URL="${REPOSITORY}/archive/refs/tags/${VERSION}.tar.gz"
PACKAGE_SHA=$(curl -Ls "${PACKAGE_URL}" | sha256sum | cut -d' ' -f1)

[[ "$(uname)" == "Linux" ]] && SEDCMD="sed" || SEDCMD="gsed"
${SEDCMD} -i "s|^  url .*$|  url \"${PACKAGE_URL}\"|g" Formula/nchat.rb && \
${SEDCMD} -i "s/^  sha256 .*$/  sha256 \"${PACKAGE_SHA}\"/g" Formula/nchat.rb
if [[ "${?}" != "0" ]]; then
  echo "formula update failed."
  exit 1
fi

git stage Formula/nchat.rb
if [[ "${?}" != "0" ]]; then
  echo "failed staging formula."
  exit 1
fi

git commit -m "release ${VERSION}"
if [[ "${?}" != "0" ]]; then
  echo "failed committing formula."
  exit 1
fi

echo "success"

echo ""
echo "diff:"
git diff @{u}..

echo ""
echo "log:"
git log @{u}..

echo ""
echo "to push run:"
echo "git push"
echo ""

exit 0
