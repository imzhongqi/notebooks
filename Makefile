push:
	@git add . && git commit -m "update notebook: $(shell date +'%Y/%m/%d %H:%M:%S')" && git push
