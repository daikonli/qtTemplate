cmake_minimum_required(VERSION 3.16)

project(qtTemplate VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appqtTemplate
    main.cpp
)

qt_add_qml_module(appqtTemplate
    URI qtTemplate
    VERSION 1.0
    QML_FILES
        Main.qml
        Router.qml
        components/Card.qml
        components/whiteboard/ToolList.qml
        components/whiteboard/Footer.qml
        components/whiteboard/DrawingCanvas.qml
        pages/HomePage.qml
        pages/AboutPage.qml
        pages/SettingsPage.qml
        pages/WhiteboardPage.qml
    RESOURCES
        assets/icons/whiteboard/undo.svg
        assets/icons/whiteboard/redo.svg
        assets/icons/whiteboard/pencil.svg
        assets/icons/whiteboard/highlighter.svg
        assets/icons/whiteboard/eraser.svg
        assets/icons/whiteboard/colorpicker.svg
        assets/icons/whiteboard/copy.svg
        assets/icons/whiteboard/scale.svg
        assets/icons/whiteboard/save.svg
        assets/icons/whiteboard/folder.svg
        assets/icons/whiteboard/login.svg
        assets/icons/whiteboard/desktop.svg
        assets/icons/whiteboard/settings.svg
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appqtTemplate PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqtTemplate
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appqtTemplate
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appqtTemplate
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
