#ifndef HEADUNITAPP_H
#define HEADUNITAPP_H

#include <QObject>
#include <QString>
#include <QTimer>

class HeadUnitApp : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(int rpm READ rpm WRITE setRpm NOTIFY rpmChanged)
    Q_PROPERTY(double fuelLevel READ fuelLevel WRITE setFuelLevel NOTIFY fuelLevelChanged)
    Q_PROPERTY(double temperature READ temperature WRITE setTemperature NOTIFY temperatureChanged)
    Q_PROPERTY(QString currentProfile READ currentProfile NOTIFY profileChanged)
    Q_PROPERTY(bool systemReady READ systemReady NOTIFY systemReadyChanged)

public:
    explicit HeadUnitApp(QObject *parent = nullptr);
    ~HeadUnitApp();

    // Property getters
    int speed() const { return m_speed; }
    int rpm() const { return m_rpm; }
    double fuelLevel() const { return m_fuelLevel; }
    double temperature() const { return m_temperature; }
    QString currentProfile() const { return m_currentProfile; }
    bool systemReady() const { return m_systemReady; }

    // Property setters
    void setSpeed(int speed);
    void setRpm(int rpm);
    void setFuelLevel(double level);
    void setTemperature(double temp);

public slots:
    void initializeSystem();
    void shutdownSystem();
    void switchProfile(const QString &profile);
    void updateSimulation();

signals:
    void speedChanged();
    void rpmChanged();
    void fuelLevelChanged();
    void temperatureChanged();
    void profileChanged();
    void systemReadyChanged();
    void systemMessage(const QString &message);

private:
    int m_speed;
    int m_rpm;
    double m_fuelLevel;
    double m_temperature;
    QString m_currentProfile;
    bool m_systemReady;
    QTimer *m_simulationTimer;
    
    void detectProfile();
};

#endif // HEADUNITAPP_H
