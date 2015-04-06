################################################################################
#
# sam-ba
#
################################################################################

SAM_BA_SITE    = http://www.atmel.com/Images/
SAM_BA_VERSION = 2.15
## was: SAM_BA_VERSION = 2.12 -- 2015-04-06 RGO Filmetrics Inc.
SAM_BA_SOURCE  = sam-ba_$(SAM_BA_VERSION).zip
## was: SAM_BA_PATCH = patch6.gz -- 2015-04-06 RGO Filmetrics Inc.
## was: SAM_BA_PATCH = sam-ba_$(SAM_BA_VERSION)_patch5.gz
SAM_BA_LICENSE = BSD-like (partly binary-only)
SAM_BA_LICENSE_FILES = doc/readme.txt

define HOST_SAM_BA_EXTRACT_CMDS
        unzip -d $(BUILD_DIR) $(DL_DIR)/$(SAM_BA_SOURCE)

        # Between revisions 2.12 and 2.15, Atmel changed the top level directory
        # in the zip archive from sam-ba_cdc_cdc_linux to sam-ba_cdc_linux.
        # 2015-04-06 RGO Filmetrics Inc.
        # Was : mv $(BUILD_DIR)/sam-ba_cdc_cdc_linux/* $(@D)
        # Was : rmdir $(BUILD_DIR)/sam-ba_cdc_cdc_linux/
        mv $(BUILD_DIR)/sam-ba_cdc_linux/* $(@D)
        rmdir $(BUILD_DIR)/sam-ba_cdc_linux/
endef

# Since it's a prebuilt application and it does not conform to the
# usual Unix hierarchy, we install it in $(HOST_DIR)/opt/sam-ba and
# then create a symbolic link from $(HOST_DIR)/usr/bin to the
# application binary, for easier usage.

define HOST_SAM_BA_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/opt/sam-ba/
	cp -a $(@D)/* $(HOST_DIR)/opt/sam-ba/
	ln -sf ../../opt/sam-ba/sam-ba $(HOST_DIR)/usr/bin/sam-ba

        # Version 2.15 has a sam-ba_64 executable also, so we link to it also.
        # 2015-04-06 RGO Filmetrics Inc.
        ln -sf ../../opt/sam-ba/sam-ba_64 $(HOST_DIR)/usr/bin/sam-ba_64
endef

$(eval $(host-generic-package))
