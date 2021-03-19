find_package(Threads REQUIRED)
set(THREADS_PREFER_PTHREAD_FLAG ON)
set_target_properties(Threads::Threads PROPERTIES IMPORTED_GLOBAL TRUE)

add_library(threads ALIAS Threads::Threads)

# set export variables
set(THREADS_LIBRARY threads)

message(STATUS "[THREADS] settings")
message(STATUS "    THREADS_LIBRARY = ${THREADS_LIBRARY}")
