push:
	@git add . && git commit -m "update notebook: $(shell date +'%Y/%m/%d %H:%M:%S'), update files: $(shell git diff --name-only)" && git push

