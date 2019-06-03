#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>

class FileIO : public QObject
{
    Q_OBJECT

public:
    Q_PROPERTY(QString source
               WRITE setSource)
    explicit FileIO(QObject *parent = 0);

    Q_INVOKABLE QString read();
    Q_INVOKABLE QString lab2zd1();
    Q_INVOKABLE QString lab2zd2();
    Q_INVOKABLE QString lab2zd3();
    Q_INVOKABLE QString lab3zd2();
    Q_INVOKABLE QString lab3zd22();
    Q_INVOKABLE QString lab3zd3();
    Q_INVOKABLE QString lab3zd1();


public slots:
    void setSource(const QString& source) { mSource = source;
    // void buttonClicked(const QString& source) { mSource = source;
                                          };

signals:
    void error(const QString& msg);

private:
    QString mSource;
};

#endif // FILEIO_H
