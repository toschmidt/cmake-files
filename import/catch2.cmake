include(ExternalProject)
find_package(Git REQUIRED)

# library name
set(CATCH2_LIBRARY catch2)

ExternalProject_Add(
        ${CATCH2_LIBRARY}_src
        PREFIX external/${CATCH2_LIBRARY}
        GIT_REPOSITORY https://github.com/catchorg/Catch2.git
        GIT_TAG v2.13.1
        TIMEOUT 10
        CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/external/${CATCH2_LIBRARY}
        -DCMAKE_INSTALL_LIBDIR=${CMAKE_BINARY_DIR}/external/${CATCH2_LIBRARY}/lib
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCATCH_BUILD_TESTING=OFF
        BUILD_ALWAYS OFF
)

# path to installed artifacts
ExternalProject_Get_Property(${CATCH2_LIBRARY}_src install_dir)
set(CATCH2_INCLUDE_DIR ${install_dir}/include)

# build library from external project
file(MAKE_DIRECTORY ${CATCH2_INCLUDE_DIR})
add_library(${CATCH2_LIBRARY} INTERFACE IMPORTED)
set_property(TARGET ${CATCH2_LIBRARY} APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CATCH2_INCLUDE_DIR})
add_dependencies(${CATCH2_LIBRARY} ${CATCH2_LIBRARY}_src)

message(STATUS "[CATCH2] settings")
message(STATUS "    CATCH2_LIBRARY = ${CATCH2_LIBRARY}")
message(STATUS "    CATCH2_INCLUDE_DIR = ${CATCH2_INCLUDE_DIR}")
