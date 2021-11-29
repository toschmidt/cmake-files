include(ExternalProject)
find_package(Git REQUIRED)

# library name
set(CPP_BENCHMARK_LIBRARY cpp-benchmark)

ExternalProject_Add(
        ${CPP_BENCHMARK_LIBRARY}_src
        PREFIX external/${CPP_BENCHMARK_LIBRARY}
        GIT_REPOSITORY https://github.com/toschmidt/cpp-benchmark.git
        GIT_TAG v1.1
        TIMEOUT 10
        CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/external/${CPP_BENCHMARK_LIBRARY}
        -DCMAKE_INSTALL_LIBDIR=${CMAKE_BINARY_DIR}/external/${CPP_BENCHMARK_LIBRARY}/lib
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DENABLE_TESTING=OFF
        -DENABLE_BENCHMARKING=OFF
        -DENABLE_BENCHMARKING=OFF
        BUILD_BYPRODUCTS <INSTALL_DIR>/lib/libcpp-benchmark.a
        BUILD_ALWAYS OFF
)

# path to installed artifacts
ExternalProject_Get_Property(${CPP_BENCHMARK_LIBRARY}_src install_dir)
set(CPP_BENCHMARK_INCLUDE_DIR ${install_dir}/include)
set(CPP_BENCHMARK_LIBRARY_PATH ${install_dir}/lib/libcpp-benchmark.a)

# build library from external project
file(MAKE_DIRECTORY ${CPP_BENCHMARK_INCLUDE_DIR})
add_library(${CPP_BENCHMARK_LIBRARY} STATIC IMPORTED)
set_property(TARGET ${CPP_BENCHMARK_LIBRARY} PROPERTY IMPORTED_LOCATION ${CPP_BENCHMARK_LIBRARY_PATH})
set_property(TARGET ${CPP_BENCHMARK_LIBRARY} APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CPP_BENCHMARK_INCLUDE_DIR})
add_dependencies(${CPP_BENCHMARK_LIBRARY} ${CPP_BENCHMARK_LIBRARY}_src)

message(STATUS "[CPP-BENCHMARK] settings")
message(STATUS "    CPP_BENCHMARK_LIBRARY = ${CPP_BENCHMARK_LIBRARY}")
message(STATUS "    CPP_BENCHMARK_INCLUDE_DIR = ${CPP_BENCHMARK_INCLUDE_DIR}")
message(STATUS "    CPP_BENCHMARK_LIBRARY_PATH = ${CPP_BENCHMARK_LIBRARY_PATH}")
