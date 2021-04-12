include(ExternalProject)
find_package(Git REQUIRED)

# library name
set(GOOGLETEST_LIBRARY googletest)
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(GOOGLETEST_DEBUG_POSTFIX "d")
else ()
    set(GOOGLETEST_DEBUG_POSTFIX "")
endif ()

ExternalProject_Add(
        ${GOOGLETEST_LIBRARY}_src
        PREFIX external/${GOOGLETEST_LIBRARY}
        GIT_REPOSITORY "https://github.com/google/googletest.git"
        GIT_TAG 965f8ecbfd8b91bbd4f5ee4914c028660bb89029
        TIMEOUT 10
        CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/external/${GOOGLETEST_LIBRARY}
        -DCMAKE_INSTALL_LIBDIR=${CMAKE_BINARY_DIR}/external/${GOOGLETEST_LIBRARY}/lib
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DDEBUG_POSTFIX=""
        -DBUILD_GMOCK=OFF
        BUILD_BYPRODUCTS <INSTALL_DIR>/lib/libgtest${GOOGLETEST_DEBUG_POSTFIX}.a
        BUILD_ALWAYS OFF
)

# path to installed artifacts
ExternalProject_Get_Property(${GOOGLETEST_LIBRARY}_src install_dir)
set(GOOGLETEST_INCLUDE_DIR ${install_dir}/include)
set(GOOGLETEST_LIBRARY_PATH ${install_dir}/lib/libgtest${GOOGLETEST_DEBUG_POSTFIX}.a)

# build library from external project
file(MAKE_DIRECTORY ${GOOGLETEST_INCLUDE_DIR})
add_library(${GOOGLETEST_LIBRARY} STATIC IMPORTED)
set_property(TARGET ${GOOGLETEST_LIBRARY} PROPERTY IMPORTED_LOCATION ${GOOGLETEST_LIBRARY_PATH})
set_property(TARGET ${GOOGLETEST_LIBRARY} APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${GOOGLETEST_INCLUDE_DIR})
add_dependencies(${GOOGLETEST_LIBRARY} ${GOOGLETEST_LIBRARY}_src)

message(STATUS "[GOOGLETEST] settings")
message(STATUS "    GOOGLETEST_LIBRARY = ${GOOGLETEST_LIBRARY}")
message(STATUS "    GOOGLETEST_INCLUDE_DIR = ${GOOGLETEST_INCLUDE_DIR}")
message(STATUS "    GOOGLETEST_LIBRARY_PATH = ${GOOGLETEST_LIBRARY_PATH}")
