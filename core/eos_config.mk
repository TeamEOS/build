#
# Copyright (C) 2014 TeamEOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Only set -O3 for thumb cflags if explicitly specified
ifeq ($(ARCH_ARM_HIGH_OPTIMIZATION),true)
  $(combo_2nd_arch_prefix)TARGET_thumb_CFLAGS += -O3
else
  $(combo_2nd_arch_prefix)TARGET_thumb_CFLAGS += -Os
endif

# Only set -O3 for arm cflags if explicitly specified
ifeq ($(ARCH_ARM_HIGH_OPTIMIZATION),true)
  $(combo_2nd_arch_prefix)TARGET_arm_CFLAGS += -O3
else
  $(combo_2nd_arch_prefix)TARGET_arm_CFLAGS += -O2
endif

# A clean way of only disabling a few optimizations that
# cause problems on devices such as Grouper
ifeq ($(ARCH_ARM_HIGH_OPTIMIZATION_COMPAT),true)
  TARGET_EOS_CFLAGS += -fno-tree-vectorize
endif

# Use -O2 for TARGET_arm_CFLAGS for the following devices due to
# "problem" modules until they're discovered
ifneq ($(filter m7att m7spr m7tmo m7wls,$(PRODUCT_DEVICE)),)
  $(combo_2nd_arch_prefix)TARGET_arm_CFLAGS += -O2
else
ifeq ($(TARGET_BUILD_SMALL_SYSTEM),true)
    $(combo_2nd_arch_prefix)TARGET_arm_CFLAGS += -O2
else
    $(combo_2nd_arch_prefix)TARGET_arm_CFLAGS += -O3
endif
endif


ifeq ($(TARGET_QCOM_DISPLAY_VARIANT),legacy)
  TARGET_EOS_CFLAGS += -DLEGACY_QCOM_VARIANT
endif

ifeq ($(TARGET_QCOM_DISPLAY_VARIANT),caf)
  TARGET_EOS_CFLAGS += -DCAF_QCOM_VARIANT
endif

# Global defines for skia neon optimization
ifeq ($(ARCH_ARM_HAVE_NEON),true)
  TARGET_GLOBAL_CFLAGS += -DSKPAINTOPTIONS_OPT
  TARGET_GLOBAL_CPPFLAGS += -DSKPAINTOPTIONS_OPT
endif