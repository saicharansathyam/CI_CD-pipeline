set(SOURCES
    main.cpp
    headunitapp.cpp
)

set(HEADERS
    headunitapp.h
)
find_package(Qt6 6.2 REQUIRED COMPONENTS Quick Qml)

qt_add_executable(HeadUnitApp
    ${SOURCES}
    ${HEADERS}
)

# QML resources (adjust paths to your qml files)
qt_add_qml_module(HeadUnitApp
    URI HeadUnit
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/Dashboard.qml
        qml/components/SpeedGauge.qml
)

target_link_libraries(HeadUnitApp
    PRIVATE
        Qt6::Quick
        Qt6::Qml
)
