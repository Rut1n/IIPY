#ifndef MOUSEMEMORY_H
#define MOUSEMEMORY_H

#include <QObject>
#include <QDebug>
#include <QPoint>

class DmesgCall : public QObject
{
    Q_OBJECT
public:
    explicit DmesgCall(QObject *parent = 0);

    Q_INVOKABLE QString call(QString URL);
    Q_INVOKABLE QString call_dev();
    Q_INVOKABLE QString call_cpu();
    Q_INVOKABLE QString call_mem();
    Q_INVOKABLE void revert_led();
    Q_INVOKABLE void blink_led();
    Q_INVOKABLE bool check_status(bool led);
    Q_INVOKABLE QString booltostring(bool i);
signals:

public slots:
};

#endif // MOUSEMEMORY_H
