NAME=Cedar
VERSION=0.11.3

GH_REPO=pivotal/cedar

COMPONENTS_BUILD_CACHE_PATH ?= $(HOME)/Library/Caches/Components
COMPONENTS_INSTALL_PATH ?= ./Components

COMPONENT_BUILD_PATH=$(COMPONENTS_BUILD_CACHE_PATH)/$(NAME)
COMPONENT_SOURCE_PATH=$(COMPONENT_BUILD_PATH)/$(NAME)-$(VERSION)
COMPONENT_INSTALL_PATH=$(COMPONENTS_INSTALL_PATH)/$(NAME)/
COMPONENT_FRAMEWORK_PATH=$(COMPONENT_SOURCE_PATH)/$(NAME).framework

COMPONENT_ZIPBALL_PATH=$(COMPONENT_BUILD_PATH)/$(NAME)-$(VERSION).zip

### URLs

COMPONENT_ZIPBALL_URL=https://github.com/$(GH_REPO)/archive/v$(VERSION).zip

### Targets

.PHONY: install update uninstall clean prepare purge

install: $(COMPONENT_INSTALL_PATH)

uninstall:
	rm -rf $(COMPONENT_INSTALL_PATH)

update: uninstall install

clean:
	rm -rf $(COMPONENT_SOURCE_PATH)
	rm -rf $(COMPONENT_ZIPBALL_PATH)

purge: uninstall clean

### Artefacts

$(COMPONENT_INSTALL_PATH): $(COMPONENT_FRAMEWORK_PATH)
	mkdir $(COMPONENT_INSTALL_PATH)

	cp -R $(COMPONENT_FRAMEWORK_PATH) $(COMPONENT_INSTALL_PATH)

$(COMPONENT_FRAMEWORK_PATH): $(COMPONENT_SOURCE_PATH)
	cd $(COMPONENT_SOURCE_PATH)/cedar-$(VERSION) and rake frameworks:osx:build
	cp -Rv $(COMPONENT_SOURCE_PATH)/cedar-$(VERSION)/build/Release/$(NAME).framework $(COMPONENT_FRAMEWORK_PATH)

$(COMPONENT_SOURCE_PATH): $(COMPONENT_ZIPBALL_PATH)
	unzip $(COMPONENT_ZIPBALL_PATH) -d $(COMPONENT_SOURCE_PATH)

	# Unzipping touches $(COMPONENT_BUILD_PATH)
	# so we must touch zipball and then source path to restore logical order
	touch $(COMPONENT_ZIPBALL_PATH)
	touch $(COMPONENT_SOURCE_PATH)

$(COMPONENT_ZIPBALL_PATH): $(COMPONENT_BUILD_PATH)
	wget --no-use-server-timestamps $(COMPONENT_ZIPBALL_URL) -O $(COMPONENT_ZIPBALL_PATH)

$(COMPONENT_BUILD_PATH):
	mkdir $(COMPONENT_BUILD_PATH)
