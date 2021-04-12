include(ExternalProject)
find_package(Git REQUIRED)

# library name
set(FADEC_LIBRARY fadec)

if (${CMAKE_BUILD_TYPE} MATCHES Debug)
    set(MESON_BUILD_TYPE debug)
elseif (${CMAKE_BUILD_TYPE} MATCHES Release)
    set(MESON_BUILD_TYPE release)
else ()
    set(MESON_BUILD_TYPE debugoptimized)
endif ()

ExternalProject_Add(
        ${FADEC_LIBRARY}_src
        PREFIX external/${FADEC_LIBRARY}
        GIT_REPOSITORY "https://github.com/aengelke/fadec.git"
        GIT_TAG d67eb93148e68c05618ae131f56b30f16b7408eb
        TIMEOUT 10
        CONFIGURE_COMMAND CFLAGS=-fno-stack-protector meson --prefix=/ --libdir=lib --buildtype ${MESON_BUILD_TYPE} <SOURCE_DIR>
        BUILD_COMMAND DESTDIR=<INSTALL_DIR> ninja install
        INSTALL_COMMAND ""
        TEST_COMMAND meson test -v
        BUILD_BYPRODUCTS <INSTALL_DIR>/lib/libfadec.a
        BUILD_ALWAYS OFF
)

# path to installed artifacts
ExternalProject_Get_Property(${FADEC_LIBRARY}_src install_dir)
set(FADEC_INCLUDE_DIR ${install_dir}/include)
set(FADEC_LIBRARY_PATH ${install_dir}/lib/libfadec.a)

# build library from external project
file(MAKE_DIRECTORY ${FADEC_INCLUDE_DIR})
add_library(${FADEC_LIBRARY} STATIC IMPORTED)
set_property(TARGET ${FADEC_LIBRARY} PROPERTY IMPORTED_LOCATION ${FADEC_LIBRARY_PATH})
set_property(TARGET ${FADEC_LIBRARY} APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${FADEC_INCLUDE_DIR})
add_dependencies(${FADEC_LIBRARY} ${FADEC_LIBRARY}_src)

message(STATUS "[FADEC] settings")
message(STATUS "    FADEC_LIBRARY = ${FADEC_LIBRARY}")
message(STATUS "    FADEC_INCLUDE_DIR = ${FADEC_INCLUDE_DIR}")
message(STATUS "    FADEC_LIBRARY_PATH = ${FADEC_LIBRARY_PATH}")
