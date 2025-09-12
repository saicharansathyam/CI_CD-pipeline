#include "headunitapp.h"
#include <QDebug>
#include <QRandomGenerator>

HeadUnitApp::HeadUnitApp(QObject *parent)
    : QObject(parent)
    , m_speed(0)
    , m_rpm(0)
    , m_fuelLevel(75.0)
    , m_temperature(20.0)
    , m_currentProfile("IVI")
    , m_systemReady(false)
    , m_simulationTimer(new QTimer(this))
{
    detectProfile();
    
    // Setup simulation timer for demo
    connect(m_simulationTimer, &QTimer::timeout, this, &HeadUnitApp::updateSimulation);
    
    // Initialize system after a short delay
    QTimer::singleShot(1000, this, &HeadUnitApp::initializeSystem);
}

HeadUnitApp::~HeadUnitApp()
{
    shutdownSystem();
}

void HeadUnitApp::setSpeed(int speed)
{
    if (m_speed != speed) {
        m_speed = qBound(0, speed, 260);
        emit speedChanged();
    }
}

void HeadUnitApp::setRpm(int rpm)
{
    if (m_rpm != rpm) {
        m_rpm = qBound(0, rpm, 8000);
        emit rpmChanged();
    }
}

void HeadUnitApp::setFuelLevel(double level)
{
    if (!qFuzzyCompare(m_fuelLevel, level)) {
        m_fuelLevel = qBound(0.0, level, 100.0);
        emit fuelLevelChanged();
    }
}

void HeadUnitApp::setTemperature(double temp)
{
    if (!qFuzzyCompare(m_temperature, temp)) {
        m_temperature = qBound(-40.0, temp, 50.0);
        emit temperatureChanged();
    }
}

void HeadUnitApp::initializeSystem()
{
    qDebug() << "Initializing DES Head Unit System...";
    emit systemMessage("System initializing...");
    
    // Simulate initialization
    QTimer::singleShot(500, this, [this]() {
        m_systemReady = true;
        emit systemReadyChanged();
        emit systemMessage("System ready");
        qDebug() << "System initialized successfully";
        
        // Start simulation
        m_simulationTimer->start(100);
    });
}

void HeadUnitApp::shutdownSystem()
{
    qDebug() << "Shutting down DES Head Unit System...";
    m_simulationTimer->stop();
    m_systemReady = false;
    emit systemReadyChanged();
    emit systemMessage("System shutdown");
}

void HeadUnitApp::switchProfile(const QString &profile)
{
    if (m_currentProfile != profile) {
        m_currentProfile = profile;
        emit profileChanged();
        emit systemMessage(QString("Switched to %1 profile").arg(profile));
        qDebug() << "Profile switched to:" << profile;
    }
}

void HeadUnitApp::updateSimulation()
{
    // Simple simulation for demo purposes
    static int direction = 1;
    
    // Update speed
    int newSpeed = m_speed + (QRandomGenerator::global()->bounded(5) * direction);
    if (newSpeed > 120 || newSpeed < 0) {
        direction *= -1;
    }
    setSpeed(newSpeed);
    
    // Update RPM based on speed
    setRpm((m_speed * 60) + QRandomGenerator::global()->bounded(500));
    
    // Slowly decrease fuel
    setFuelLevel(m_fuelLevel - 0.01);
    
    // Vary temperature slightly
    double tempChange = (QRandomGenerator::global()->bounded(10) - 5) * 0.1;
    setTemperature(m_temperature + tempChange);
}

void HeadUnitApp::detectProfile()
{
#ifdef IVI_PROFILE_ENABLED
    m_currentProfile = "IVI";
    qDebug() << "IVI Profile enabled";
#elif defined(IC_PROFILE_ENABLED)
    m_currentProfile = "IC";
    qDebug() << "IC Profile enabled";
#else
    m_currentProfile = "Standard";
    qDebug() << "Standard Profile enabled";
#endif
}
