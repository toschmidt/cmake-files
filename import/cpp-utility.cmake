include(ExternalProject)
find_package(Git REQUIRED)

# library name
set(CPP_UTILITY_LIBRARY cpp-utility)

ExternalProject_Add(
        ${CPP_UTILITY_LIBRARY}_src
        PREFIX external/${CPP_UTILITY_LIBRARY}
        GIT_REPOSITORY https://github.com/toschmidt/cpp-utility.git
        GIT_TAG v1.0
        TIMEOUT 10
        CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/external/${CPP_UTILITY_LIBRARY}
        -DCMAKE_INSTALL_LIBDIR=${CMAKE_BINARY_DIR}/external/${CPP_UTILITY_LIBRARY}/lib
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DENABLE_TESTING=OFF
        -DENABLE_BENCHMARKING=OFF
        BUILD_ALWAYS OFF
        UPDATE_DISCONNECTED ON
)

# path to installed artifacts
ExternalProject_Get_Property(${CPP_UTILITY_LIBRARY}_src install_dir)
set(CPP_UTILITY_INCLUDE_DIR ${install_dir}/include)

# build library from external project
file(MAKE_DIRECTORY ${CPP_UTILITY_INCLUDE_DIR})
add_library(${CPP_UTILITY_LIBRARY} INTERFACE IMPORTED)
set_property(TARGET ${CPP_UTILITY_LIBRARY} APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CPP_UTILITY_INCLUDE_DIR})
add_dependencies(${CPP_UTILITY_LIBRARY} ${CPP_UTILITY_LIBRARY}_src)

message(STATUS "[CPP-UTILITY] settings")
message(STATUS "    CPP_UTILITY_LIBRARY = ${CPP_UTILITY_LIBRARY}")
message(STATUS "    CPP_UTILITY_INCLUDE_DIR = ${CPP_UTILITY_INCLUDE_DIR}")
