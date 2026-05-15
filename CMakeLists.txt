cmake_minimum_required(VERSION 3.30)

project(
        hello-opengl
        VERSION 0.1.0
        DESCRIPTION "Learn graphics programming from scratch with OpenGL"
        LANGUAGES C CXX
)

# Prevent accidentally building inside the source directory.
if (PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
    message(FATAL_ERROR "In-source builds are not allowed. Use a separate build directory.")
endif ()

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

include(ProjectFormatting)
include(ProjectWarnings)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

# ------------------------------------------------------------
# GLFW
# ------------------------------------------------------------

set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(GLFW_INSTALL OFF CACHE BOOL "" FORCE)

add_subdirectory(third_party/glfw EXCLUDE_FROM_ALL)

# ------------------------------------------------------------
# GLAD
# ------------------------------------------------------------

add_library(glad STATIC
        third_party/glad/src/glad.c
)

target_include_directories(glad
        SYSTEM
        PUBLIC
        "${PROJECT_SOURCE_DIR}/third_party/glad/include"
)

target_compile_features(glad
        PRIVATE
        c_std_99
)

set_target_properties(glad
        PROPERTIES
        C_EXTENSIONS OFF
)

# ------------------------------------------------------------
# Executable
# ------------------------------------------------------------

add_executable(hello-opengl
        src/main.cpp
)

target_compile_features(hello-opengl
        PRIVATE
        cxx_std_20
)

set_target_properties(hello-opengl
        PROPERTIES
        CXX_EXTENSIONS OFF
)

target_link_libraries(hello-opengl
        PRIVATE
        glad
        glfw
)

target_set_project_warnings(hello-opengl)

add_project_format_targets()
