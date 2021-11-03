push:
	f=$$(git diff --name-only) \
	IFS=$$'\n' echo "update notebook: $(shell date +'%Y/%m/%d %H:%M:%S'), update files: $${f[*]}"&& git push

