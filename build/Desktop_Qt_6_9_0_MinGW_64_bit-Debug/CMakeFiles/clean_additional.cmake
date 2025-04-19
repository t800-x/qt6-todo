# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appTodo_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appTodo_autogen.dir\\ParseCache.txt"
  "appTodo_autogen"
  )
endif()
