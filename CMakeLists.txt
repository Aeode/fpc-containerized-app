cmake_minimum_required(VERSION 3.12)
project(main NONE)

set(PROJECT_NAME "main")
set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(BIN_DIR "${CMAKE_BINARY_DIR}/bin")
set(LIB_DIR "${CMAKE_BINARY_DIR}/lib")
set(MAIN_SRC "${SRC_DIR}/main.pp")

find_program(FPC_EXECUTABLE fpc REQUIRED)

file(GLOB_RECURSE ALL_PASCAL_FILES "${SRC_DIR}/*.pp" "${SRC_DIR}/*.pas")
set(UNIT_PATHS "")

foreach(FILE_PATH ${ALL_PASCAL_FILES})
    get_filename_component(DIR_PATH ${FILE_PATH} DIRECTORY)
    list(APPEND UNIT_PATHS ${DIR_PATH})
endforeach()

list(REMOVE_DUPLICATES UNIT_PATHS)

set(FPC_UNIT_FLAGS "")
foreach(U_PATH ${UNIT_PATHS})
    list(APPEND FPC_UNIT_FLAGS "-Fu${U_PATH}")
endforeach()

set(FPC_COMMON_FLAGS
    "-Mobjfpc"
    "-Sh"
    "-FU${LIB_DIR}"
    "-FE${BIN_DIR}"
)

if(CMAKE_BUILD_TYPE STREQUAL "Release")
    set(FPC_BUILD_FLAGS
        "-O3"
        "-Xs"
        "-XX"
        "-CX"
        "-dRELEASE"
    )
else()
    set(CMAKE_BUILD_TYPE "Debug")
    set(FPC_BUILD_FLAGS
        "-g"
        "-gl"
        "-gh"
        "-Cr"
        "-Co"
        "-Ct"
        "-dDEBUG"
    )
endif()

file(MAKE_DIRECTORY ${BIN_DIR} ${LIB_DIR})

add_custom_command(
    OUTPUT "${BIN_DIR}/${PROJECT_NAME}${CMAKE_EXECUTABLE_SUFFIX}"
    COMMAND ${FPC_EXECUTABLE}
            ${FPC_COMMON_FLAGS}
            ${FPC_UNIT_FLAGS}
            ${FPC_BUILD_FLAGS}
            "${MAIN_SRC}"
            "-o${BIN_DIR}/${PROJECT_NAME}${CMAKE_EXECUTABLE_SUFFIX}"
    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
    DEPENDS "${MAIN_SRC}"
    COMMENT "Building ${PROJECT_NAME} (${CMAKE_BUILD_TYPE}) directly with flags..."
)

add_custom_target(${PROJECT_NAME} ALL
    DEPENDS "${BIN_DIR}/${PROJECT_NAME}${CMAKE_EXECUTABLE_SUFFIX}"
)

add_custom_target(run
    COMMAND "${BIN_DIR}/${PROJECT_NAME}${CMAKE_EXECUTABLE_SUFFIX}"
    DEPENDS ${PROJECT_NAME}
    COMMENT "Running the program..."
)