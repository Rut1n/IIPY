#include "DmesgCall.h"
#include <QProcess>
#include <QDebug>
#include "fileio.h"
#include <QFile>
#include <QTextStream>
#include <unistd.h>
#include <iostream>
extern "C" {
#include <xdo.h>
}
DmesgCall::DmesgCall(QObject *parent) : QObject(parent)
{

}

QString DmesgCall::call(QString URL)
{
    QProcess q1;
    q1.setStandardOutputFile(URL.mid(7));
    q1.start("dmesg");
    q1.waitForFinished();
    QString output(q1.readAllStandardOutput());
    qDebug() << output;
    return output;
}

QString DmesgCall::call_dev()
{
    QProcess q1;
    q1.start("cat /proc/devices");
    q1.waitForFinished();
    QString output(q1.readAllStandardOutput());
    qDebug() << output;
    return output;
}

QString DmesgCall::call_cpu()
{
    QProcess q1;
    q1.start("cat /proc/cpuinfo");
    q1.waitForFinished();
    QString output(q1.readAllStandardOutput());
    qDebug() << output;
    return output;
}

QString DmesgCall::call_mem()
{
    QProcess q1;
    q1.start("cat /proc/meminfo");
    q1.waitForFinished();
    QString output(q1.readAllStandardOutput());
    qDebug() << output;
    return output;
}

void DmesgCall::revert_led()
{
    xdo_t * x = xdo_new(NULL);
    xdo_send_keysequence_window(x, CURRENTWINDOW, "Caps_Lock", 0);
    xdo_send_keysequence_window(x, CURRENTWINDOW, "Scroll_Lock", 0);
    xdo_send_keysequence_window(x, CURRENTWINDOW, "Num_Lock", 0);
    //return output;
}
void DmesgCall::blink_led()
{
    xdo_t * x = xdo_new(NULL);
    if(!check_status(0))
    xdo_send_keysequence_window(x, CURRENTWINDOW, "Caps_Lock", 0);
    xdo_send_keysequence_window(x, CURRENTWINDOW, "Scroll_Lock", 0);
    if(!check_status(1))
    xdo_send_keysequence_window(x, CURRENTWINDOW, "Num_Lock", 0);
    usleep(90000);
    xdo_send_keysequence_window(x, CURRENTWINDOW, "Caps_Lock", 0);
    xdo_send_keysequence_window(x, CURRENTWINDOW, "Num_Lock", 0);
    xdo_send_keysequence_window(x, CURRENTWINDOW, "Scroll_Lock", 0);
    //return output;
}

bool DmesgCall::check_status(bool led)
{
 /*   Display d = *QX11Info::display();
    if (d)
    {
     unsigned n;
     XkbGetIndicatorState(d, XkbUseCoreKbd, &n);
     caps_state = (n & 0x01) == 1;
    }*/
    QStringList List;
    QProcess q1;
    q1.start("xset q");
    q1.waitForFinished();
    QString output(q1.readAllStandardOutput());
    List = output.split("\n");
    output = List.at(3);
    List = output.split("   ");
    if(led==0)
    output = List.at(2);
    else
    output = List.at(4);
    qDebug() << output.contains("on");
    return output.contains("on");
}

QString DmesgCall::booltostring(bool i) {
    usleep(140000);
    if(check_status(i)) return "on";
    else return "off";

}
