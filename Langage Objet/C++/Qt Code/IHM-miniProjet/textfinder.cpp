#include "textfinder.h"
#include "ui_textfinder.h"
#include "darkstyle.h"
#include <QDebug>
#include <QFileDialog>
#include <QtCore/QFile>
#include <QtCore/QTextStream>
#include <QMessageBox>
#include <QVector>
#include <QDragEnterEvent>
#include <QMimeData>

TextFinder::TextFinder(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::TextFinder)
{
    ui->setupUi(this);
    CDarkStyle::assign();
    ui->showText->setAcceptDrops(false);
    setAcceptDrops(true);
    loadTextFile(":/README.txt");
}

TextFinder::~TextFinder()
{
    delete ui;
}

void TextFinder::loadTextFile(QString fileName)
{
    QFile inputFile(fileName);
    QFileInfo fileInfo(fileName);
    inputFile.open(QIODevice::ReadOnly);

    QTextStream in(&inputFile);
    QString line = in.readAll();
    inputFile.close();

    ui->showText->setPlainText(line);

    currentFileName=fileInfo.fileName();
    ui->currentloadedfile->setEnabled(true);
    ui->currentloadedfile->setText(currentFileName);

    currentFile=nullptr;
    comptRecentFiles++;
    if(fileName!=currentPath1
            && fileName!=currentPath2
            && fileName!=currentPath3
            && fileName!=currentPath4
            && fileName!=currentPath5
            && fileName!="C:/Users/erik.courtecuisse/Documents/Qt/IHM-miniProjet-1/README.txt")
    {
        if(comptRecentFiles==1)
        {
            ui->actionRecent1_2->setVisible(true);
            ui->actionRecent1_2->setText("1 : " + fileName);
            currentPath1=fileName;
        }
        if(comptRecentFiles==2)
        {
            ui->actionRecent2_2->setVisible(true);
            ui->actionRecent2_2->setText("2 : " + fileName);
            currentPath2=fileName;
        }
        if(comptRecentFiles==3)
        {
            ui->actionRecent3_2->setVisible(true);
            ui->actionRecent3_2->setText("3 : " + fileName);
            currentPath3=fileName;
        }
        if(comptRecentFiles==4)
        {
            ui->actionRecent4->setVisible(true);
            ui->actionRecent4->setText("4 : " + fileName);
            currentPath4=fileName;
        }
        if(comptRecentFiles==5)
        {
            ui->actionRecent5->setVisible(true);
            ui->actionRecent5->setText("5 : " + fileName);
            currentPath5=fileName;
            comptRecentFiles=0;
        }
    }
}

void TextFinder::saveToFile()
{
    fileName = QFileDialog::getSaveFileName(this,tr("Save Address Book"), "",tr("All Files (*.txt)"));
    currentFile = fileName;
    if (fileName.isEmpty())
        return;
    else
    {
        QFile file(fileName);
        if (!file.open(QIODevice::WriteOnly))
        {
            QMessageBox::information(this, tr("Impossible d'ouvrir le fichier"), file.errorString());
            return;
        }

        text = ui->showText->toPlainText();

        QTextStream out(&file);
        out << text;
        file.close();

        QMessageBox::information(this, tr("Fichier sauvegardé"), tr("Votre texte a correctement été sauvegardé"));
    }
}

void TextFinder::on_nextButton_clicked()
{
    QString searchString = ui->chooseWordLine->text();

    if(fullWordSearch==true)
        ui->showText->find(searchString, QTextDocument::FindWholeWords);
    else
        ui->showText->find(searchString);

    if(comptCursor>=numberWord)
    {
        ui->nextButton->setEnabled(false);
        QMessageBox::information(this, tr("Recherche terminée"), tr("Vous avez parcouru la totalité du texte."));
    }
    if(comptCursor>1)
        ui->previousButton->setEnabled(true);
    showComptCursor();
}

void TextFinder::on_previousButton_clicked()
{
    QString searchString = ui->chooseWordLine->text();

    if(fullWordSearch==true)
        ui->showText->find(searchString, QTextDocument::FindBackward);
    else
        ui->showText->find(searchString, QTextDocument::FindBackward);

    if(comptCursor==1)
    {
        ui->previousButton->setEnabled(false);
        QMessageBox::information(this, tr("Premier mot"), tr("Vous êtes revenu au premier mot recherché."));
    }
    if(comptCursor<numberWord)
        ui->nextButton->setEnabled(true);
    showComptCursor();
}

void TextFinder::on_findButton_clicked()
{
    QString searchString = ui->chooseWordLine->text();
    QTextDocument *document = ui->showText->document();
    numberWord=0;
    comptCursor=0;
    tabPosWord.clear();
    showComptCursor();

    QTextCursor textCursor = ui->showText->textCursor();
    textCursor.movePosition(QTextCursor::Start, QTextCursor::MoveAnchor,1);
    ui->showText->setTextCursor(textCursor);

    document->undo();

    if (searchString.isEmpty())
    {
        numberWord=0;
        showNumberWord();
        QMessageBox::information(this, tr("Erreur, champ de recherche"),
                                 tr("Mot manquant !\n"
                                    "S'il vous plait, entrez un mot et appuyez sur le boutton 'Rechercher'."));
    }
    else
    {
        QTextCursor highlightCursor(document);
        QTextCursor highlightCursorOneWord(document);
        QTextCursor cursor(document);
        //-----------------------------------------------------------------------
        if(fullWordSearch==true)
        {
            cursor.beginEditBlock();

            QTextCharFormat plainFormat(highlightCursor.charFormat());
            QTextCharFormat colorFormat = plainFormat;
            colorFormat.setForeground(Qt::red);

            while (!highlightCursor.isNull() && !highlightCursor.atEnd())
            {
                highlightCursor = document->find(searchString, highlightCursor,QTextDocument::FindWholeWords);
                if (!highlightCursor.isNull())
                {
                    highlightCursor.movePosition(QTextCursor::WordRight,QTextCursor::KeepAnchor);

                    tabPosWord << highlightCursor.position()-1;

                    highlightCursor.mergeCharFormat(colorFormat);
                    numberWord++;
                }
            }

            if(numberWord==0)
                QMessageBox::information(this, tr("Erreur, mot introuvable"),
                                         tr("Le mot saisi n'est pas présent dans le document."));

            cursor.endEditBlock();
            showNumberWord();
        }
        //-----------------------------------------------------------------------
        else
        {
            cursor.beginEditBlock();

            QTextCharFormat plainFormatOneWord(highlightCursorOneWord.charFormat());
            QTextCharFormat colorFormatOneWord = plainFormatOneWord;
            colorFormatOneWord.setForeground(Qt::green);

            while (!highlightCursorOneWord.isNull() && !highlightCursorOneWord.atEnd())
            {
                highlightCursorOneWord = document->find(searchString, highlightCursorOneWord);
                if (!highlightCursorOneWord.isNull())
                {
                    highlightCursorOneWord.movePosition(QTextCursor::NextCharacter,QTextCursor::KeepAnchor,-1);

                    tabPosWord << highlightCursorOneWord.position();

                    highlightCursorOneWord.mergeCharFormat(colorFormatOneWord);
                    numberWord++;
                }
            }

            if(numberWord==0)
                QMessageBox::information(this, tr("Erreur, suite de charactéres introuvable"),
                                         tr("La suite de charactére saisie n'est pas présente dans le document."));
            cursor.endEditBlock();
            showNumberWord();
        }
        //-----------------------------------------------------------------------
    }
    if(numberWord!=0)
        ui->nextButton->setEnabled(true);
}

void TextFinder::on_actionOpen_triggered()
{
    fileName = QFileDialog::getOpenFileName(this,tr("Open Image"), "/", tr("Image Files (*.txt)"));
    if(fileName!=0)
    {
        comptCursor=0;
        numberWord=0;
        tabPosWord.clear();
        showComptCursor();
        showNumberWord();
        ui->nextButton->setEnabled(false);

        QTextCursor textCursor = ui->showText->textCursor();
        textCursor.movePosition(QTextCursor::Start, QTextCursor::MoveAnchor,1);
        ui->showText->setTextCursor(textCursor);

        ui->showText->clear();

        ui->chooseWordLine->clear();

        loadTextFile(fileName);
    }
}

void TextFinder::on_actionSave_triggered()
{
    comptCursor=0;
    numberWord=0;
    showComptCursor();
    showNumberWord();

    QTextCursor textCursor = ui->showText->textCursor();
    textCursor.movePosition(QTextCursor::Start, QTextCursor::MoveAnchor,1);
    ui->showText->setTextCursor(textCursor);

    saveToFile();
}

void TextFinder::on_actionSauvegarder_triggered()
{
    comptCursor=0;
    numberWord=0;
    showComptCursor();
    showNumberWord();

    QTextCursor textCursor = ui->showText->textCursor();
    textCursor.movePosition(QTextCursor::Start, QTextCursor::MoveAnchor,1);
    ui->showText->setTextCursor(textCursor);

    if(currentFile.isEmpty())
        saveToFile();
    else
    {
        QFile file(currentFile);
        if (!file.open(QIODevice::WriteOnly))
        {
            QMessageBox::information(this, tr("Impossible d'ouvrir le fichier"), file.errorString());
            return;
        }

        text = ui->showText->toPlainText();

        QTextStream out(&file);
        out << text;
        file.close();

        QMessageBox::information(this, tr("Fichier sauvegardé"), tr("Votre texte a correctement été sauvegardé"));
    }

}

void TextFinder::on_resetButton_clicked()
{
    comptCursor=0;
    numberWord=0;
    tabPosWord.clear();
    showComptCursor();
    showNumberWord();
    ui->nextButton->setEnabled(false);
    ui->currentloadedfile->setEnabled(false);

    QTextCursor textCursor = ui->showText->textCursor();
    textCursor.movePosition(QTextCursor::Start, QTextCursor::MoveAnchor,1);
    ui->showText->setTextCursor(textCursor);

    ui->showText->clear();

    ui->chooseWordLine->clear();

    QMessageBox::information(this, tr("Reset effectué"),tr("Reset ok ! Enjoy !"));
}

void TextFinder::showNumberWord()
{
    ui->wordComptLabel->setText(QString("Nombre de mots : %1").arg(numberWord));
}

void TextFinder::showComptCursor()
{
    ui->wordNumberLabel->setText(QString("Mot numéro : %1").arg(comptCursor));
}

void TextFinder::on_showText_cursorPositionChanged()
{
    int x = 0, y = 0;
    QTextCursor cursor = ui->showText->textCursor();
    x = cursor.blockNumber();
    y = cursor.columnNumber();

    ui->cursorLabel->setText(QString("ligne: %1, lettre: %2").arg(x).arg(y));

    for(int i=0; i<tabPosWord.size() ; i++)
    {
        if(tabPosWord[i]==cursor.position())
        {
            comptCursor=i+1;
            showComptCursor();
        }
    }
}

void TextFinder::on_fullWordCheckBox_stateChanged()
{
    if(fullWordSearch==true)
        fullWordSearch=false;
    else
        fullWordSearch=true;
}

//---------------------

void TextFinder::dragEnterEvent(QDragEnterEvent *event)
{
    if(event->mimeData()->hasUrls())
        event->acceptProposedAction();
    else event->ignore();
}

void TextFinder::dropEvent(QDropEvent *event)
{
    comptCursor=0;
    numberWord=0;
    tabPosWord.clear();
    showComptCursor();
    showNumberWord();
    ui->nextButton->setEnabled(false);

    QTextCursor textCursor = ui->showText->textCursor();
    textCursor.movePosition(QTextCursor::Start, QTextCursor::MoveAnchor,1);
    ui->showText->setTextCursor(textCursor);

    ui->showText->clear();

    ui->chooseWordLine->clear();
    //-------
    const QMimeData *mimeData = event->mimeData();
    if(mimeData->hasUrls())
    {
        QList<QUrl> urlList = mimeData->urls();
        QString fileName = urlList.at(0).toLocalFile();
        if(! fileName.isEmpty())
        {
            loadTextFile(fileName);
        }
    }
}

void TextFinder::on_chooseWordLine_textChanged()
{
    ui->nextButton->setEnabled(false);
}

void TextFinder::on_actionRecent1_2_triggered()
{
    loadTextFile(currentPath1);
}

void TextFinder::on_actionRecent2_2_triggered()
{
    loadTextFile(currentPath2);
}

void TextFinder::on_actionRecent3_2_triggered()
{
    loadTextFile(currentPath3);
}

void TextFinder::on_actionRecent4_triggered()
{
    loadTextFile(currentPath4);
}

void TextFinder::on_actionRecent5_triggered()
{
    loadTextFile(currentPath5);
}
