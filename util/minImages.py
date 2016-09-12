import os
import shutil
import subprocess

if __name__ == '__main__':
	imageDir = "res/assets/img/"
	minDir = imageDir + "min/"
	
	#empty min dir
	if os.path.isdir(minDir):
		shutil.rmtree(minDir)
		
	subprocess.call([
		"svgo",
		"-f", imageDir,
		"-o", minDir,
		"-p", "0",
		"--enable", "removeTitle",
		"--enable", "removeDesc",
		"--enable", "removeUselessDefs",
		"--enable", "removeEditorsNSData",
		"--enable", "removeViewBox",
		"--enable", "transformsWithOnePath"
	], shell=True)