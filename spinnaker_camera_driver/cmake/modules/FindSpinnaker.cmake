unset(Spinnaker_FOUND)
unset(Spinnaker_INCLUDE_DIR)
unset(Spinnaker_LIBRARIES)

# Search in Spinnaker_SDK_ROOT if it is set.
if(Spinnaker_SDK_ROOT)
  message("Spinnaker_SDK_ROOT defined as: ${Spinnaker_SDK_ROOT}")
  set(_SPINNAKER_SEARCH_ROOT ${Spinnaker_SDK_ROOT}/usr ${Spinnaker_SDK_ROOT}/opt/spinnaker NO_DEFAULT_PATH)
else()
  message("No Spinnaker_SDK_ROOT defined. Using default locations.")
  set(_SPINNAKER_SEARCH_ROOT /opt/spinnaker /usr /usr/local)
endif()
message("Searching for Spinnaker libraries and includes in: ${_SPINNAKER_SEARCH_ROOT}")

find_path(Spinnaker_INCLUDE_DIR NAMES Spinnaker.h PATHS ${_SPINNAKER_SEARCH_ROOT} PATH_SUFFIXES include include/spinnaker)
find_library(Spinnaker_LIBRARIES NAMES Spinnaker PATHS ${_SPINNAKER_SEARCH_ROOT} PATH_SUFFIXES lib)

if(Spinnaker_INCLUDE_DIR AND Spinnaker_LIBRARIES)
  set(Spinnaker_FOUND 1)
endif()
