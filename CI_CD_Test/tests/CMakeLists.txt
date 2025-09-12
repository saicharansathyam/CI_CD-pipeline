find_package(Qt6 REQUIRED COMPONENTS QuickTest)


# Example QtTest-based unit test
add_executable(sample_test sample_test.cpp)
target_link_libraries(sample_test PRIVATE Qt6::Test)

add_test(NAME sample_test COMMAND sample_test)

# Qt Quick Test runner
qt_add_executable(qml_tests tests_qml_runner.cpp)
target_link_libraries(qml_tests PRIVATE Qt6::QuickTest Qt6::Qml Qt6::Quick)
add_test(NAME qml_tests COMMAND qml_tests)



