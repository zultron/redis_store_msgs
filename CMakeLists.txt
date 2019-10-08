cmake_minimum_required(VERSION 3.5)

project(redis_store_msgs)

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()
if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)
# find the ROS message code generators
find_package(rosidl_default_generators REQUIRED)
find_package(std_msgs REQUIRED)

# declare the service files to generate code for
set(srv_files
   "srv/GetParam.srv"
   "srv/ResetParams.srv"
   "srv/SetParam.srv"
   "srv/SaveDeleteParam.srv"
)

rosidl_generate_interfaces(${PROJECT_NAME}
   ${srv_files}
   DEPENDENCIES std_msgs
 )

ament_export_dependencies(rosidl_default_runtime)
ament_package()
