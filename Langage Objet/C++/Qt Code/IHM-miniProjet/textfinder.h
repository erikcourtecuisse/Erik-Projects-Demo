#ifndef TEXTFINDER_H
#define TEXTFINDER_H

#define MAXRECENTFILE 5;

#include <QMainWindow>

namespace Ui {
class TextFinder;
}

class TextFinder : public QMainWindow
{
    Q_OBJECT

public:
    explicit TextFinder(QWidget *parent = nullptr);
    ~TextFinder();

private slots:
    void on_findButton_clicked();
    void on_actionOpen_triggered();
    void on_actionSave_triggered();
    void on_actionSauvegarder_triggered();
    void on_resetButton_clicked();
    void on_fullWordCheckBox_stateChanged();
    void on_showText_cursorPositionChanged();
    void on_chooseWordLine_textChanged();
    void on_nextButton_clicked();
    void on_previousButton_clicked();
    //-----
    void on_actionRecent1_2_triggered();
    void on_actionRecent2_2_triggered();
    void on_actionRecent3_2_triggered();
    void on_actionRecent4_triggered();
    void on_actionRecent5_triggered();
    //-----
    void showNumberWord();
    void showComptCursor();

protected:
    void dragEnterEvent(QDragEnterEvent *event);
    void dropEvent(QDropEvent *event);

private:
    Ui::TextFinder *ui;
    void loadTextFile(QString fileName);
    void saveToFile();
    QString fileName;
    QString currentFile;
    QString currentPath1;
    QString currentPath2;
    QString currentPath3;
    QString currentPath4;
    QString currentPath5;
    QString currentFileName;
    QString text;
    int numberWord;
    int comptCursor;
    bool fullWordSearch=true;
    QVector<int> tabPosWord;
    int comptRecentFiles=0;
    int posPreviousCursor;

};

#endif // TEXTFINDER_H
