cmake_minimum_required(VERSION 2.8.3)
project(rti_ros)

find_package(catkin REQUIRED COMPONENTS 
  tf
  geometry_msgs
)

# Make CMake aware of the cmake folder for local FindXXX scripts.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}
                      ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

find_package(RTI REQUIRED)

catkin_package(
  INCLUDE_DIRS include src
  LIBRARIES dds_lib
  DEPENDS nddsc nddscpp nddscore 
)

set(NDDSHOME $ENV{NDDSHOME})

include_directories(
  ${catkin_INCLUDE_DIRS}
  ${NDDSHOME}/include
  ${NDDSHOME}/include/ndds
  include
  src
)

add_definitions(-DRTI_UNIX)

link_directories(
  ${NDDSHOME}/lib/x64Linux3gcc4.8.2
  ${NDDSHOME}/lib/armv6vfphLinux3.xgcc4.7.2
)

add_library(dds_lib
  src/Velocities.cxx
  src/VelocitiesPlugin.cxx
  src/VelocitiesSupport.cxx
)

target_link_libraries(dds_lib
  nddsc
  nddscpp
  nddscore
  ${CMAKE_DL_LIBS}
)

add_executable(ros_to_dds
  src/Velocities_publisher.cxx
)

target_link_libraries(ros_to_dds
  ${catkin_LIBRARIES}
  dds_lib
)

add_executable(odomtest_sub
  src/odomtest_sub.cpp
)

target_link_libraries(odomtest_sub
  ${catkin_LIBRARIES}
)

add_executable(odomtest_pub
  src/odomtest_pub.cpp
)

target_link_libraries(odomtest_pub
  ${catkin_LIBRARIES}
)

add_executable(dds_to_ros
  src/Velocities_subscriber.cxx
)

target_link_libraries(dds_to_ros
  ${catkin_LIBRARIES}
  dds_lib
)