import os
import sys
import zipfile
import subprocess

def zipdir(path, ziph):
	for root, dirs, files in os.walk(path):
		for file in files:
			fname = file
			if os.path.splitext(file)[1] == ".js":
				fname = os.path.splitext(file)[0] + "_min.js"
				
				#subprocess.call([
				#	"java", "-jar", "util/compiler.jar", 
				#	"--compilation_level", #"SIMPLE_OPTIMIZATIONS", #
				#	"ADVANCED_OPTIMIZATIONS", 
				#	"--js_output_file=" + os.path.join(root, fname), 
				#	os.path.join(root, file)
				#])
				subprocess.call([
					"uglifyjs",
					"--compress",
					"--mangle",
					#"--mangle-props",
					"--o", os.path.join(root, fname),
					os.path.join(root, file)
				], shell=True)
			
			if os.path.splitext(file)[1] == ".html":
				fname = os.path.splitext(file)[0] + "_min.html"
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
					"-o", os.path.join(root, fname), 
					os.path.join(root, file)
				], shell=True)
			
			ziph.write(os.path.join(root, fname), file)

if __name__ == '__main__':
	zipf = zipfile.ZipFile('util/build.zip', 'w', zipfile.ZIP_DEFLATED)
	zipdir('bin/', zipf)
	zipf.close()
	
	statInfo = os.stat("util/build.zip")
	fileSize = statInfo.st_size / 1024.0
	percent = (fileSize / 13.0) * 100.0
	
	print(str(fileSize) + "KB Used (" + str(percent) + "%)")
	
	if fileSize > 13:
		sys.exit("Project Exceeds 13KB!!!");