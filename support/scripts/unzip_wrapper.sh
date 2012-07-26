#!/bin/sh 
 
ZIP_TMP_DIR=`mktemp -d` 
 
unzip -q $1 -d $ZIP_TMP_DIR 
tar -cC $ZIP_TMP_DIR `ls $ZIP_TMP_DIR` 
rm -rf $ZIP_TMP_DIR 
