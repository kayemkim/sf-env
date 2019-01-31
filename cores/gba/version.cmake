if(NOT PROJECT_NAME)
	set(PROJECT_NAME "mGBA")
endif()
set(LIB_VERSION_MAJOR 0)
set(LIB_VERSION_MINOR 7)
set(LIB_VERSION_PATCH 0)
set(LIB_VERSION_ABI 0.7)
set(LIB_VERSION_STRING ${LIB_VERSION_MAJOR}.${LIB_VERSION_MINOR}.${LIB_VERSION_PATCH})
set(SUMMARY "${PROJECT_NAME} Game Boy Advance Emulator")

find_program(GIT git)
if(GIT AND NOT SKIP_GIT)
	execute_process(COMMAND ${GIT} describe --always --abbrev=40 --dirty WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}" OUTPUT_VARIABLE GIT_COMMIT ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)
	execute_process(COMMAND ${GIT} describe --always --dirty WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}" OUTPUT_VARIABLE GIT_COMMIT_SHORT ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)
	execute_process(COMMAND ${GIT} symbolic-ref --short HEAD WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}" OUTPUT_VARIABLE GIT_BRANCH ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)
	execute_process(COMMAND ${GIT} rev-list HEAD --count WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}" OUTPUT_VARIABLE GIT_REV ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)
	execute_process(COMMAND ${GIT} describe --tag --exact-match WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}" OUTPUT_VARIABLE GIT_TAG ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()

if(NOT GIT_REV)
	set(GIT_REV -1)
endif()
if(GIT_TAG)
	set(VERSION_STRING ${GIT_TAG})
elseif(NOT GIT_BRANCH)
	set(VERSION_STRING ${LIB_VERSION_STRING})
else()
	if(GIT_BRANCH STREQUAL "master" OR NOT GIT_BRANCH)
		set(VERSION_STRING ${GIT_REV}-${GIT_COMMIT_SHORT})
	else()
		set(VERSION_STRING ${GIT_BRANCH}-${GIT_REV}-${GIT_COMMIT_SHORT})
	endif()

	if(NOT LIB_VERSION_ABI STREQUAL GIT_BRANCH)
		set(VERSION_STRING ${LIB_VERSION_ABI}-${VERSION_STRING})
	endif()
endif()

if(NOT GIT_COMMIT)
	set(GIT_COMMIT "(unknown)")
endif()
if(NOT GIT_COMMIT_SHORT)
	set(GIT_COMMIT_SHORT "(unknown)")
endif()
if(NOT GIT_BRANCH)
	set(GIT_BRANCH "(unknown)")
endif()

if(DEFINED PRINT_STRING)
	message("${${PRINT_STRING}}")
elseif(NOT VERSION_STRING_CACHE OR NOT VERSION_STRING STREQUAL VERSION_STRING_CACHE)
	set(VERSION_STRING_CACHE ${VERSION_STRING} CACHE STRING "" FORCE)

	if(CONFIG_FILE AND OUT_FILE)
		configure_file("${CONFIG_FILE}" "${OUT_FILE}")
	endif()
endif()
