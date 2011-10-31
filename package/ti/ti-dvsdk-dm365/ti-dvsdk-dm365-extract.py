#!/usr/bin/env python
import sys
from subprocess import Popen, PIPE


if len(sys.argv) < 4:
	print "usage: ",
	print sys.argv[0],
	print " <installer> <codesourcery> <destination>"
	print " "
	print "    installer   : the DVSDK installer location "
	print "                   (eg: ~/Downloads/dvsdk_..._setuplinux.bin)"
	print "    codesourcery: location of the CodeSourcery installation" 
	print "                   (eg: ~/CodeSourcery/Sourcery_G++_Lite/bin)"
	print "    destination : where to install the files"
	print "                   (eg: ~/dvsdk)"
	sys.exit(2)
else:
	installer=sys.argv[1]
	codesourcery=sys.argv[2]
	destination=sys.argv[3]
	print "Installer: ",
	print installer
	print "CodeSourcery: ",
	print codesourcery
	print "Destination: ",
	print destination

pb = Popen(installer, shell=False, stdout=PIPE, stdin=PIPE, stderr=PIPE)
question = 0
data = pb.stdout.read(1)
while data:
	sys.stdout.write(data)
	if data == ']':
		if question == 0:
			pb.stdin.write("Y\n")
			question = 1
		elif question == 1:
			pb.stdin.write(codesourcery)
			pb.stdin.write("\n")
			sys.stdout.write(codesourcery)
			sys.stdout.write("\n")
			question = 2
		elif question == 2:
			pb.stdin.write(destination)
			pb.stdin.write("\n")
			sys.stdout.write(destination)
			sys.stdout.write("\n")
			question = 3
	data = pb.stdout.read(1)

sys.exit(pb.wait())