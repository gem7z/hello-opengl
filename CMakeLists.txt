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

# ------------------------------------------------------------
# Output directories
# ------------------------------------------------------------

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

foreach (CONFIG_TYPE DEBUG RELEASE RELWITHDEBINFO MINSIZEREL)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CONFIG_TYPE} "${CMAKE_BINARY_DIR}/bin")
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CONFIG_TYPE} "${CMAKE_BINARY_DIR}/bin")
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CONFIG_TYPE} "${CMAKE_BINARY_DIR}/bin")
endforeach ()

# ------------------------------------------------------------
# Project source files
# ------------------------------------------------------------

file(GLOB_RECURSE HELLO_OPENGL_SOURCES
        CONFIGURE_DEPENDS
        "${PROJECT_SOURCE_DIR}/src/*.cpp"
)

file(GLOB_RECURSE HELLO_OPENGL_HEADERS
        CONFIGURE_DEPENDS
        "${PROJECT_SOURCE_DIR}/include/*.hpp"
)

if (NOT HELLO_OPENGL_SOURCES)
    message(FATAL_ERROR "No .cpp source files found in ${PROJECT_SOURCE_DIR}/src")
endif ()

source_group(TREE "${PROJECT_SOURCE_DIR}/src" PREFIX "Source Files" FILES ${HELLO_OPENGL_SOURCES})
source_group(TREE "${PROJECT_SOURCE_DIR}/include" PREFIX "Header Files" FILES ${HELLO_OPENGL_HEADERS})

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
        ${HELLO_OPENGL_SOURCES}
        ${HELLO_OPENGL_HEADERS}
)

target_include_directories(hello-opengl
        PRIVATE
        "${PROJECT_SOURCE_DIR}/include"
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
