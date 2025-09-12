cmake_minimum_required(VERSION 3.22)
project(HeadUnitApp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find Qt modules you use
find_package(Qt6 6.2 COMPONENTS Quick Qml Test REQUIRED)

# If you have Qt 6.2+, this one-liner sets AUTOMOC/AUTORCC/AUTOUIC and nice warnings
include(CheckCXXCompilerFlag)
if (Qt6_FOUND)
  include(${Qt6_DIR}/../Qt6Core/Qt6CoreMacros.cmake OPTIONAL)
endif()

# Preferred (Qt 6.2+):
if (COMMAND qt_standard_project_setup)
  qt_standard_project_setup()
else()
  # Fallback for older setups: enable the automations manually
  set(CMAKE_AUTOMOC ON)
  set(CMAKE_AUTORCC ON)
  set(CMAKE_AUTOUIC ON)
endif()


# App
add_subdirectory(src)

# Tests
enable_testing()
add_subdirectory(tests)
