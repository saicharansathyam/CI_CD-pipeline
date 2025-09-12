#include <QtTest>

class SampleTest : public QObject {
    Q_OBJECT
private slots:
    void mathWorks() {
        QCOMPARE(2 + 2, 4);
    }
};

QTEST_MAIN(SampleTest)
#include "sample_test.moc"
