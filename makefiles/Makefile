
brew-upgrades: brew-update brew-upgrade brew-cask-upgrade

brew-update:
	brew update

brew-upgrade:
	brew upgrade --ignore-pinned --formula

brew-cask-upgrade:
	CASKS_PINNED="dotnet-sdk"; \
	echo "Some casks will not be upgraded: $${CASKS_PINNED}"; \
	APPS=`brew outdated -q --cask | cat | tr "\n" " "`; \
	for app in $${CASKS_PINNED}; \
	do \
		APPS=`echo " $${APPS} " | sed -e "s/ $${app} / /g" -e "s/^ *\(.*\) *$$/\1/g"`; \
	done; \
	if [ ! -z "$${APPS}" ]; then \
		brew upgrade --cask $${APPS}; \
	fi

brew-remove-unused:
	brew bundle dump; \
	brew bundle --force cleanup; \
	rm Brewfile
