CMAKE_MINIMUM_REQUIRED(VERSION 3.5)
PROJECT(RESTServer)

SET(CMAKE_GENERATOR "Unix Makefiles"  CACHE INTERNAL "" FORCE)
SET(CMAKE_VERBOSE_MAKEFILE, ON)

# Required by flatbuffers also
ADD_COMPILE_OPTIONS(-std=c++11)

# Google flatbuffers
#SET(FLATBUFFERS_BUILD_TESTS OFF CACHE BOOL "")
#SET(FLATBUFFERS_INSTALL OFF CACHE BOOL "")
#SET(FLATBUFFERS_BUILD_FLATLIB OFF CACHE BOOL "")
#SET(FLATBUFFERS_BUILD_FLATHASH OFF CACHE BOOL "")
#ADD_SUBDIRECTORY(${PROJECT_SOURCE_DIR}/3rdParty/flatbuffers/)
#INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/3rdParty/flatbuffers/include/)

#SET(FLATC ${PROJECT_BINARY_DIR}/3rdParty/flatbuffers/flatc)
#MESSAGE(STATUS "flatc location: ${FLATC}")

ExternalProject_Get_Property(flatbuffers_project SOURCE_DIR)
MESSAGE(STATUS "flatbuffers source dir: ${SOURCE_DIR}")
include_directories(${SOURCE_DIR}/include)

FILE(GLOB SOURCE_FILES "*.cpp" "*.h")
#    "Adapter/*.cpp" "Adapter/*.h"
#    "API/*.cpp" "API/*.h"
#    "Connection/*.cpp" "Connection/*.h"
#    "Schema/*.cpp" "Schema/*.h" "Schema/*.fbs")

#ADD_CUSTOM_TARGET(flatc_gen 
#                    COMMAND ${FLATC} --scoped-enums --no-prefix --cpp ${PROJECT_SOURCE_DIR}/Schema/axiom_daemon.fbs
#                    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/Schema/
#                    COMMENT "Running PRE_BUILD action" DEPENDS flatc)

ADD_EXECUTABLE(${PROJECT_NAME} ${SOURCE_FILES})

# Used for loading generated headers, e.g. #include <Schema/axiom_daemon_generated.h>
INCLUDE_DIRECTORIES(${CMAKE_BINARY_DIR}/src/)

ADD_DEPENDENCIES(${PROJECT_NAME} flatbuffers_project flatc_cpp_gen)
TARGET_LINK_LIBRARIES(${PROJECT_NAME} pistache)