
function(download_spinnaker SPINNAKER_SDK_DIR)
  if(NOT UNIX)
    message(FATAL_ERROR "Downloading libSpinnaker for non-linux systems not supported.")
  endif()

  # First we find out which library version we need (OS version, architecture, SDK version)
  execute_process(
    COMMAND lsb_release -rs
    OUTPUT_VARIABLE OS_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE)

  include(cmake/TargetArch.cmake)
  target_architecture(TARGET_ARCH)

  if("${OS_VERSION}" STREQUAL "16.04")
    set(SDK_VERSION "1.27.0.48")
  else()
    set(SDK_VERSION "2.2.0.48")
  endif()

  if("${TARGET_ARCH}" STREQUAL "i386")
    set(SDK_ARCH i386)
  elseif("${TARGET_ARCH}" STREQUAL "x86_64")
    set(SDK_ARCH "amd64")
  elseif("${TARGET_ARCH}" STREQUAL "armv7")
    set(SDK_ARCH "armhf")
  elseif("${TARGET_ARCH}" STREQUAL "armv8")
    set(SDK_ARCH "arm64")
  else()
    message(FATAL_ERROR "Downloading libSpinnaker for architecture ${TARGET_ARCH} not supported.")
  endif()

  set(SDK_URL "https://packages.clearpathrobotics.com/stable/flir/Spinnaker/Ubuntu${OS_VERSION}/spinnaker-${SDK_VERSION}-Ubuntu${OS_VERSION}-${SDK_ARCH}-pkg.tar.gz")
  file(DOWNLOAD SDK_URL ${CMAKE_BINARY_DIR}/spinnaker-sdk.tar.gz)
  file(ARCHIVE_EXTRACT INPUT spinnaker-sdk.tar.gz VERBOSE)

  # Download and extract tarball with debians
  #  FetchContent_Declare(spinnaker-sdk
  #  PREFIX spinnaker-sdk
  #  BUILD_IN_SOURCE 1
  #  CONFIGURE_COMMAND ""
  #  BUILD_COMMAND dpkg --extract libspinnaker-${SDK_VERSION}_${SDK_ARCH}.deb . && dpkg --extract libspinnaker-${SDK_VERSION}_${SDK_ARCH}-dev.deb .
  #  INSTALL_COMMAND ""
  #)

  # Set output variable
  #FetchContent_Get_Property(spinnaker-sdk SOURCE_DIR)
  set(${SPINNAKER_SDK_DIR} "${SOURCE_DIR}" PARENT_SCOPE)
endfunction()
