include(ExternalProject)
find_package(Git REQUIRED)

# library name
set(XBYAK_LIBRARY xbyak)

ExternalProject_Add(
        ${XBYAK_LIBRARY}_src
        PREFIX external/${XBYAK_LIBRARY}
        GIT_REPOSITORY https://github.com/herumi/xbyak.git
        GIT_TAG v5.991
        TIMEOUT 10
        CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/external/${XBYAK_LIBRARY}
        -DCMAKE_INSTALL_LIBDIR=${CMAKE_BINARY_DIR}/external/${XBYAK_LIBRARY}/lib
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
)

# path to installed artifacts
ExternalProject_Get_Property(${XBYAK_LIBRARY}_src install_dir)
set(XBYAK_INCLUDE_DIR ${install_dir}/include)

# build library from external project
file(MAKE_DIRECTORY ${XBYAK_INCLUDE_DIR})
add_library(${XBYAK_LIBRARY} INTERFACE IMPORTED)
set_property(TARGET ${XBYAK_LIBRARY} APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${XBYAK_INCLUDE_DIR})
add_dependencies(${XBYAK_LIBRARY} ${XBYAK_LIBRARY}_src)

message(STATUS "[XBYAK] settings")
message(STATUS "    XBYAK_LIBRARY = ${XBYAK_LIBRARY}")
message(STATUS "    XBYAK_INCLUDE_DIR = ${XBYAK_INCLUDE_DIR}")
