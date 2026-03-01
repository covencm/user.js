#!/bin/sh
echo "WARNING: This script will:"
echo "1. DELETE ALL data in your Firefox default-release profile"
echo "   This includes bookmarks, passwords, history, extensions, and settings"
echo "2. Download and install uBlock Origin extension"
echo ""
echo "Make sure you have backed up any important Firefox data before proceeding!"
echo ""
read -p "Do you want to continue? (y/N): " confirmation

case $confirmation in
[Yy]*)
  echo "Proceeding with Firefox profile reset..."
  ;;
*)
  echo "Operation cancelled."
  exit 0
  ;;
esac

pkill firefox
rm -rf $HOME/.config/mozilla/firefox/*.default-release/*
cp firefox/* $HOME/.config/mozilla/firefox/*.default-release


read -p  "Privacy Badger or Ublock Origin ? (p/u): " extension

case $extension in 
[pP]*) 
       echo "Installing Privacy Badger..."
       wget -O privacy-badger17.xpi https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17
       setsid -f firefox privacy-badger17.xpi
       ;;
[uU]*)
  echo "Installing Ublock Origin..."
  ublock_version="1.69.0"
  wget -O uBlock0_$ublock_version.firefox.signed.xpi https://github.com/gorhill/uBlock/releases/download/$ublock_version/uBlock0_$ublock_version.firefox.signed.xpi
  setsid -f firefox uBlock0_$ublock_version.firefox.signed.xpi
  ;;
*)
  echo "Operation Cancelled."
  exit 0
  ;;
esac
