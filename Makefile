push:
	f=$$(git diff --name-only) \
	IFS=$$'\n' git commit -am "update notebook: $(shell date +'%Y/%m/%d %H:%M:%S'), update files: \n$${f[*]}"&& git push

