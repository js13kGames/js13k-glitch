import os
import sys
import zipfile
import subprocess

if __name__ == '__main__':
	jsFile = "bin/g.js"
	jsFileMin = "bin/g_min.js"
	indexFile = "bin/index.html"
	indexFileMin = "bin/index_min.html"
	
	#minify javascript
	subprocess.call([
		"uglifyjs",
		"--compress",
		"--mangle",
		"--o", jsFileMin,
		jsFile
	], shell=True)
	
	#inline javascript in index
	jsFileIn = open(jsFileMin, 'r')
	jsData = jsFileIn.read()
	jsFileIn.close()
	
	indexFileIn = open(indexFile, 'r')
	indexData = indexFileIn.read()
	indexFileIn.close()

	inlineIndexData = indexData.replace("{g.js}", jsData)
	
	indexFileOut = open(indexFile, 'w')
	indexFileOut.write(inlineIndexData)
	indexFileOut.close()

	#minify index
	subprocess.call([
		"html-minifier", 
		"--collaspse-boolean-attributes",
		"--collapse-inline-tag-whitespace",
		"--collapse-whitespace",
		"--decode-entities",
		"--html5",
		"--minify-css",
		"--minify-js",
		"--remove-attribute-quotes",
		"--remove-comments",
		"--remove-empty-attributes",
		"--remove-optional-tags",
		"--remove-redundant-attributes",
		"--use-short-doctype",
		"-o", indexFileMin, 
		indexFile
	], shell=True)
	
	zipf = zipfile.ZipFile('util/build.zip', 'w', zipfile.ZIP_DEFLATED)
	zipf.write(indexFileMin, "index.html")
	zipf.close()
	
	statInfo = os.stat("util/build.zip")
	fileSize = statInfo.st_size / 1024.0
	percent = (fileSize / 13.0) * 100.0
	
	print(str(fileSize) + "KB Used (" + str(percent) + "%)")
	
	if fileSize > 13:
		sys.exit("Project Exceeds 13KB!!!");