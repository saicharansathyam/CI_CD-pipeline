#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QUrl>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // If your qt_add_qml_module URI is "HeadUnit" and Main.qml is at qml/Main.qml,
    // the resource URL becomes: qrc:/qt/qml/HeadUnit/Main.qml
    const QUrl url(u"qrc:/qt/qml/HeadUnit/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);
    return app.exec();
}
