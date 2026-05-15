function(add_project_format_targets)
    find_program(CLANG_FORMAT_EXE NAMES clang-format)

    if (NOT CLANG_FORMAT_EXE)
        add_custom_target(format
                COMMAND ${CMAKE_COMMAND} -E echo "clang-format was not found.
                Install LLVM or add clang-format to PATH."
                COMMAND ${CMAKE_COMMAND} -E false
                VERBATIM
        )

        add_custom_target(format-check
                COMMAND ${CMAKE_COMMAND} -E echo "clang-format was not found.
                Install LLVM or add clang-format to PATH."
                COMMAND ${CMAKE_COMMAND} -E false
                VERBATIM
        )

        return()
    endif ()

    file(GLOB_RECURSE PROJECT_FORMAT_SOURCES
            CONFIGURE_DEPENDS

            "${PROJECT_SOURCE_DIR}/src/*.c"
            "${PROJECT_SOURCE_DIR}/src/*.cc"
            "${PROJECT_SOURCE_DIR}/src/*.cpp"
            "${PROJECT_SOURCE_DIR}/src/*.cxx"

            "${PROJECT_SOURCE_DIR}/src/*.h"
            "${PROJECT_SOURCE_DIR}/src/*.hh"
            "${PROJECT_SOURCE_DIR}/src/*.hpp"
            "${PROJECT_SOURCE_DIR}/src/*.hxx"

            "${PROJECT_SOURCE_DIR}/include/*.c"
            "${PROJECT_SOURCE_DIR}/include/*.cc"
            "${PROJECT_SOURCE_DIR}/include/*.cpp"
            "${PROJECT_SOURCE_DIR}/include/*.cxx"

            "${PROJECT_SOURCE_DIR}/include/*.h"
            "${PROJECT_SOURCE_DIR}/include/*.hh"
            "${PROJECT_SOURCE_DIR}/include/*.hpp"
            "${PROJECT_SOURCE_DIR}/include/*.hxx"
    )

    add_custom_target(format
            COMMAND ${CLANG_FORMAT_EXE}
            -i
            --style=file
            ${PROJECT_FORMAT_SOURCES}
            WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
            COMMENT "Formatting project source files"
            VERBATIM
    )

    add_custom_target(format-check
            COMMAND ${CLANG_FORMAT_EXE}
            --dry-run
            --Werror
            --style=file
            ${PROJECT_FORMAT_SOURCES}
            WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
            COMMENT "Checking project source formatting"
            VERBATIM
    )
endfunction()
