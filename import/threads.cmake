find_package(Threads REQUIRED)
set(THREADS_PREFER_PTHREAD_FLAG ON)

add_library(threads ALIAS Threads::Threads)

# set export variables
set(THREADS_LIBRARY threads)

message(STATUS "[THREADS] settings")
message(STATUS "    THREADS_LIBRARY = ${THREADS_LIBRARY}")