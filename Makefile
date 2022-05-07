push:
	@f=($$(git diff --name-only)); \
	export IFS=$$'\n'; \
	git commit -am "update notebook: $(shell date +'%Y/%m/%d %H:%M:%S'), update files: \n\n $${f[*]}"&& git push

