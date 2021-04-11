push:
	@git add . && git commit -m "update notebook: $(shell date +'%Y/%m/%d %H:%M:%S'), updatefiles: $(shell git diff --name-only)" && git push

