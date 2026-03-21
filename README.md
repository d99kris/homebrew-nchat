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

By default latest **stable** nchat version is installed. If you want to
install latest development version use:

    brew install nchat --HEAD

Optionally one can disable protocols using `--without-whatsapp` and
`--without-telegram`, for example:

    brew install nchat --without-telegram


Issues
------

If any issues are encountered, please provide full set of logs from homebrew:

    cd ~/Library/Logs/Homebrew
    zip -r ~/homebrew-nchat-logs.zip nchat

Or perform the installation with verbose flag and copy full terminal output:

    brew install nchat -v


Updating Formula
----------------

The repository includes a script which will check latest Github release version
and update the formula accordingly.

    ./make.sh


Testing Formula Locally
-----------------------

When making changes to the formula one can test the local formula by
untapping the public tap and tapping the local one and install, ex:

    brew untap d99kris/nchat
    brew tap d99kris/nchat ~/homebrew-nchat
    brew install d99kris/nchat/nchat -v

Note that any formula changes must be locally committed for brew to pick
them up. Once testing is completed untap it with:

    brew untap d99kris/nchat

