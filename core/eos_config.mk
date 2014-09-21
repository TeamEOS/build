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

# Only set -O3 cflags if explicitly specified
ifeq ($(ARCH_ARM_HIGH_OPTIMIZATION),true)
  TARGET_thumb_CFLAGS += -O3
  TARGET_arm_CFLAGS += -O3
  $(combo_target)RELEASE_CFLAGS += -O3
else
  TARGET_thumb_CFLAGS += -Os
  TARGET_arm_CFLAGS += -O2
  $(combo_target)RELEASE_CFLAGS += -O2
endif

# Global defines for skia neon optimization
ifeq ($(ARCH_ARM_HAVE_NEON),true)
  TARGET_GLOBAL_CFLAGS += -DSKPAINTOPTIONS_OPT
  TARGET_GLOBAL_CPPFLAGS += -DSKPAINTOPTIONS_OPT
endif
