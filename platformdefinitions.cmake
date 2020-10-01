#------------------------------------
# Definitions (for platform)
#-----------------------------------
if (CLR_CMAKE_PLATFORM_ARCH_AMD64)
  add_definitions(-D_AMD64_)
  add_definitions(-D_WIN64)
  add_definitions(-DAMD64)
  add_definitions(-DBIT64=1)          # CoreClr <= 3.x
  add_definitions(-DHOST_64BIT=1)     # CoreClr > 3.x
elseif (CLR_CMAKE_PLATFORM_ARCH_I386)
  add_definitions(-D_X86_)
elseif (CLR_CMAKE_PLATFORM_ARCH_ARM)
  add_definitions(-D_ARM_)
  add_definitions(-DARM)
elseif (CLR_CMAKE_PLATFORM_ARCH_ARM64)
  add_definitions(-D_ARM64_)
  add_definitions(-DARM64)
  add_definitions(-D_WIN64)
  add_definitions(-DBIT64=1)          # CoreClr <= 3.x
  add_definitions(-DHOST_64BIT=1)     # CoreClr > 3.x
else ()
  clr_unknown_arch()
endif ()

if (CLR_CMAKE_PLATFORM_UNIX)
  if(CLR_CMAKE_PLATFORM_LINUX)
    if(CLR_CMAKE_PLATFORM_UNIX_AMD64)
      message("Detected Linux x86_64")
      add_definitions(-DLINUX64)
    elseif(CLR_CMAKE_PLATFORM_UNIX_ARM)
      message("Detected Linux ARM")
      add_definitions(-DLINUX32)
    elseif(CLR_CMAKE_PLATFORM_UNIX_ARM64)
      message("Detected Linux ARM64")
      add_definitions(-DLINUX64)
    elseif(CLR_CMAKE_PLATFORM_UNIX_X86)
      message("Detected Linux i686")
      add_definitions(-DLINUX32)
    else()
      clr_unknown_arch()
    endif()
  endif(CLR_CMAKE_PLATFORM_LINUX)
endif(CLR_CMAKE_PLATFORM_UNIX)

if (CLR_CMAKE_PLATFORM_UNIX)
  add_definitions(-DPLATFORM_UNIX=1)

  if(CLR_CMAKE_PLATFORM_DARWIN)
    message("Detected OSX x86_64")
  endif(CLR_CMAKE_PLATFORM_DARWIN)

  if(CLR_CMAKE_PLATFORM_FREEBSD)
    message("Detected FreeBSD amd64")
  endif(CLR_CMAKE_PLATFORM_FREEBSD)

  if(CLR_CMAKE_PLATFORM_NETBSD)
    message("Detected NetBSD amd64")
  endif(CLR_CMAKE_PLATFORM_NETBSD)
endif(CLR_CMAKE_PLATFORM_UNIX)

if (WIN32)
  # Define the CRT lib references that link into Desktop imports
  set(STATIC_MT_CRT_LIB  "libcmt$<$<OR:$<CONFIG:Debug>,$<CONFIG:Checked>>:d>.lib")
  set(STATIC_MT_VCRT_LIB  "libvcruntime$<$<OR:$<CONFIG:Debug>,$<CONFIG:Checked>>:d>.lib")
  set(STATIC_MT_CPP_LIB  "libcpmt$<$<OR:$<CONFIG:Debug>,$<CONFIG:Checked>>:d>.lib")
endif(WIN32)

# Architecture specific files folder name
if (CLR_CMAKE_TARGET_ARCH_AMD64)
    set(ARCH_SOURCES_DIR amd64)
elseif (CLR_CMAKE_TARGET_ARCH_ARM64)
    set(ARCH_SOURCES_DIR arm64)
elseif (CLR_CMAKE_TARGET_ARCH_ARM)
    set(ARCH_SOURCES_DIR arm)
elseif (CLR_CMAKE_TARGET_ARCH_I386)
    set(ARCH_SOURCES_DIR i386)
else ()
    clr_unknown_arch()
endif ()
