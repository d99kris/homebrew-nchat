nchat homebrew tap
==================

This repository contains the [nchat](https://github.com/d99kris/nchat) formula
for Homebrew.


Installation
------------

**Dependencies**
Ensure XCode command line developer tools is installed:

    xcode-select --install

**Brew Install**

    brew tap d99kris/nchat
    brew install nchat


Updating Formula
----------------

The repository includes a script which will check latest Github release version
and update the formula accordingly.

    ./make.sh


Testing Formula Locally
-----------------------

Test run the formula locally with the following command.

    brew install -vd ./Formula/nchat.rb

