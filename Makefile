push:
	f=($$(git diff --name-only)); \
	export IFS=$$'\n'; \
	message=$$(echo "update notebook: $$(date +'%Y/%m/%d %H:%M:%S'), update files:\n$${f[*]}"); \
	git commit -am $$message && git push

