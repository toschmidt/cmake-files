include(FetchContent)

FetchContent_Declare(
        Catch2
        GIT_REPOSITORY https://github.com/catchorg/Catch2.git
        GIT_TAG v2.13.1
)

FetchContent_MakeAvailable(Catch2)
add_library(catch2 ALIAS Catch2)

# set export variables
set(CATCH2_LIBRARY catch2)
set(CATCH2_SOURCE_DIR ${Catch2_SOURCE_DIR})

message(STATUS "[CATCH2] settings")
message(STATUS "    CATCH2_LIBRARY = ${CATCH2_LIBRARY}")
message(STATUS "    CATCH2_SOURCE_DIR = ${CATCH2_SOURCE_DIR}")