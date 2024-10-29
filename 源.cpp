#include <iostream>
#include<fstream>
#include<cstring>
#include<vector>
#include<easyx.h>
using namespace std;
#include<graphics.h>
#include<conio.h>
#define FILENAME "stdFILE.txt" //���������ļ�����
//ѧ����(������)
class Student
{
public:
    //���麯�� 
    virtual void showPersonal() = 0; //��ʾ������Ϣ
    virtual ~Student() = 0;      //���崿������������֤�ͷŶ����ڴ�ʱ���ᷢ���ڴ�й©
    string S_number;     //ѧ��
    string S_name;  //����
    string S_college;//ѧԺ רҵ
    string S_Duty;  //ְ��
};
//��ͨѧ����
class Normalstudent : public Student
{
public:
    Normalstudent(string number, string name, string college, string duty); //���캯��
    void showPersonal(); //��ʾ������Ϣ
    ~Normalstudent()
    {
        cout << "��ͨѧ����ɾ����" << endl;
    }
};
//�೤��
class ClassPresident : public Student
{
public:
    ClassPresident(string number, string name, string college, string duty);
    void showPersonal();
    ~ClassPresident()
    {
        cout << "�೤��ɾ����" << endl;
    }
};
//��֧��
class Classleague :public Student
{
public:
    Classleague(string number, string name, string college, string duty);
    void showPersonal();
    ~Classleague()
    {
        cout << "��֧�鱻ɾ����" << endl;
    }
};
//��ɲ���
class Classleader : public Student
{
public:
    Classleader(string number, string name, string college, string duty);
    void showPersonal();
    ~Classleader()
    {
        cout << "��ɲ���ɾ����" << endl;
    }
};
//����Ա��
class StudentManager
{
public:
    StudentManager();//���캯��
    void Show_Menu(); //��ӡ�˵�����
    void Exit_System();//�˳�ϵͳ
    void Addinfo();    //����ѧ����Ϣ
    void save();       //��ѧ����Ϣ���浽�ļ���
    void init_Std();   //��ʼ��ѧ��
    void show_Std();   //��ʾѧ����Ϣ
    void del_Std();    //ɾ��ѧ����Ϣ
    void mod_Std();    //�޸�ѧ����Ϣ
    void find_Std();   //����ѧ����Ϣ
    void clean_File(); //����ļ�
    int IsExist(string id);     //�ж�ѧ��Ϊid��ѧ����Ϣ�Ƿ���ڣ������ظ�ѧ���±�
    ~StudentManager();//��������
    vector<Student*>* m_StdArray; //������ӵ�ѧ����Ϣ
    bool m_fileIsEmpty;     //����ļ��Ƿ�Ϊ��
};
//ѧ���ി���������ⲿʵ��
Student :: ~Student()
{
    cout << "ѧ���౻ɾ����" << endl;
}
//����Ա����ʵ�� ���캯��
StudentManager::StudentManager()
{
    ifstream ifs;
    ifs.open(FILENAME, ios::in);
    //����ļ�������
    if (!ifs.is_open())
    {
        cout << "���ļ������ڣ�" << endl;
        this->m_fileIsEmpty = true;
        this->m_StdArray = NULL;
        ifs.close();
        return;
    }
    //�ļ����ڵ�������Ϊ��
    char ch;
    ifs >> ch;       //�ȶ�ȡһ���ַ�
    if (ifs.eof())
    {
        cout << "���ļ�Ϊ�գ�" << endl;
        this->m_fileIsEmpty = true;
        this->m_StdArray = NULL;
        ifs.close();
        return;
    }
    cout << "StudentManager���캯��" << endl;
    cout << "�ļ����ڲ��м�¼" << endl;
    //�ļ����ڣ�����¼��ʼ����
    this->m_StdArray = new vector<Student*>;
    if (this->m_StdArray)
    {
        cout << "m_StdArrayָ�����" << endl;
    }
    this->init_Std();
}
void StudentManager::Show_Menu()
{
    cout << "--------------------------------------------" << endl;
    cout << "-----------  ��ӭʹ��ѧ������ϵͳ�� --------" << endl;
    cout << "-------------  0.�˳��������  -------------" << endl;
    cout << "-------------  1.����ѧ����Ϣ  -------------" << endl;
    cout << "-------------  2.��ʾѧ����Ϣ  -------------" << endl;
    cout << "-------------  3.ɾ��ѧ����Ϣ  -------------" << endl;
    cout << "-------------  4.�޸�ѧ����Ϣ  -------------" << endl;
    cout << "-------------  5.����ѧ����Ϣ  -------------" << endl;
    cout << "-------------  6.�����������  -------------" << endl;
    cout << "--------------------------------------------" << endl;
}
void StudentManager::Exit_System()
{
    cout << "��л����ʹ�ã�" << endl;
    return;  //�˳�ϵͳ
}
void StudentManager::Addinfo()
{
    //������������ڣ����½�����
    if (!this->m_StdArray)
        this->m_StdArray = new vector<Student*>;
    cout << "ѧ����Ϣ��ʼ¼��" << endl;
    int i = 1;
    while (true)
    {
        char flag;
        string number;    //ѧ��
        string name; //����
        string college;//ѧԺ רҵ
        string duty;  //ְλ
        cout << "�������" << i << "��ѧ��ѧ�ţ�" << endl;
        cin >> number;
        cout << "�������" << i << "��ѧ��������" << endl;
        cin >> name;
        cout << "�������" << i << "��ѧ��ѧԺ�༶��" << endl;
        cin >> college;
        cout << "�������" << i << "��ѧ��ְλ��(�೤or��֧��or��ɲ�or��ͨѧ��)" << endl;
        cin >> duty;
        Student* std = NULL;
        if (duty == "�೤")
        {
            std = new ClassPresident(number, name, college, duty);
        }
        else if (duty == "��֧��")
        {
            std = new Classleague(number, name, college, duty);
        }
        else if (duty == "��ɲ�")
        {
            std = new Classleader(number, name, college, duty);
        }
        else if (duty == "��ͨѧ��")
        {
            std = new Normalstudent(number, name, college, duty);
        }
        else
        {
            cout << "��ѧ��ְλ�����ڣ���Ϣ¼�������" << endl;
            break;
        }
        //����ӵ�ѧ�� �Ž�������
        this->m_StdArray->push_back(std);
        i++; //ѧ������++
        this->m_fileIsEmpty = false;   //�����ļ��ǿձ��
        cout << "�Ƿ����¼����Ϣ��(y����¼��,n����¼��)" << endl;
        cin >> flag;
        if (flag == 'y') continue;
        else break;
    }
    cout << "�ɹ������" << i - 1 << "��ѧ����Ϣ!" << endl;
    this->save();
    
}
void StudentManager::save()
{
    ofstream ofs;
    ofs.open(FILENAME, ios::out); //���´��ļ����Ը��ǵķ�ʽ�����ļ������֮ǰ����Ϣ��
    for (int i = 0; i < this->m_StdArray->size(); ++i)
    {
        ofs << this->m_StdArray->at(i)->S_number << " "
            << this->m_StdArray->at(i)->S_name << " "
            << this->m_StdArray->at(i)->S_college << " "
            << this->m_StdArray->at(i)->S_Duty << endl;
    }
    ofs.close();
}
//��ʼ��ѧ���������е�ѧ�����ص�������
void StudentManager::init_Std()
{
    ifstream ifs;
    ifs.open(FILENAME, ios::in);
    string number;
    string name;
    string college;
    string duty;
    while (ifs >> number && ifs >> name && ifs >> college && ifs >> duty)
    {
        Student* std = NULL;
        if (duty == "�೤")
        {
            std = new ClassPresident(number, name, college, duty);
        }
        else if (duty == "��֧��")
        {
            std = new Classleague(number, name, college, duty);
        }
        else if (duty == "��ɲ�")
        {
            std = new Classleader(number, name, college, duty);
        }
        else if (duty == "��ͨѧ��")
        {
            std = new Normalstudent(number, name, college, duty);
        }
        this->m_StdArray->push_back(std);
    }
    this->m_fileIsEmpty = false;
    // �������
    cout << "�ļ���ȡ����" << endl;
    cout << "ifs.eof() = " << ifs.eof() << endl;
    cout << "m_StdArray size = " << this->m_StdArray->size() << endl;
    this->save();
}
//��ʾѧ����Ϣ
void StudentManager::show_Std()
{
    if (this->m_fileIsEmpty)
    {
        cout << "�ļ������ڻ����ļ�Ϊ�գ�" << endl;
    }
    else
    {
        for (int i = 0; i < this->m_StdArray->size(); ++i)
        {
            this->m_StdArray->at(i)->showPersonal();
        }
    }

}
//ɾ��ѧ��
void StudentManager::del_Std()
{
    if (this->m_fileIsEmpty)
    {
        cout << "�ļ������ڻ����ļ�Ϊ�գ�" << endl;
    }
    else
    {
        cout << "��������Ҫɾ����ѧ��ѧ�ţ�" << endl;
        string number;
        cin >> number;
        int index = this->IsExist(number); //����ֵ��ѧ���������е��±�
        if (index != -1)
        {
            this->m_StdArray->erase(this->m_StdArray->begin() + index);
            this->save();
            cout << "ɾ���ɹ���" << endl;
        }
        else
        {
            cout << "ɾ��ʧ�ܣ������ڸ�ѧ�ŵ�ѧ����" << endl;
        }
    }

}
//�������У�Ѱ��ָ���±��ѧ�� ����ѧ���±�
int StudentManager::IsExist(string number)
{
    int len = this->m_StdArray->size();
    int index = -1;
    for (int i = 0; i < len; ++i)
    {
        if (this->m_StdArray->at(i)->S_number == number)
        {
            index = i;
            break;
        }
    }
    return index;
}
//�޸�ѧ��
void StudentManager::mod_Std()
{
    if (this->m_fileIsEmpty)
    {
        cout << "�ļ������ڻ����ļ�Ϊ��" << endl;
    }
    else
    {
        cout << "��������Ҫ�޸ĵ�ѧ��ѧ�ţ�" << endl;
        string number;
        cin >> number;
        int index = this->IsExist(number); //���ﲻ��Ҫ����ѭ�����룬
        if (index != -1)
        {
            // ɾ��ԭ����ѧ������
            delete this->m_StdArray->at(index);
            this->m_StdArray->at(index) = nullptr; // ��ָ������Ϊ nullptr
            string newnumber;
            string newname;
            string newcollege;
            string newduty;
            Student* std = NULL;
            cout << "������ѧ��Ϊ" << number << "��ѧ������������ѧ�ţ�" << endl;
            cin >> newnumber;
            cout << "��������������" << endl;
            cin >> newname;
            cout << "��������ѧԺ��༶";
            cin >> newcollege;
            cout << "��������ְ��" << endl;
            cin >> newduty;
            if (newduty == "�೤")
            {
                std = new ClassPresident(newnumber, newname, newcollege, newduty);
            }
            else if (newduty == "��֧��")
            {
                std = new Classleague(newnumber, newname, newcollege, newduty);
            }
            else if (newduty == "��ɲ�")
            {
                std = new Classleader(newnumber, newname, newcollege, newduty);
            }
            else if (newduty == "��ͨѧ��")
            {
                std = new Normalstudent(newnumber, newname, newcollege, newduty);
            }
            this->m_StdArray->at(index) = std;
            cout << "�޸ĳɹ���" << endl;
            this->save();
        }
        else
        {
            cout << "�޸�ʧ�ܣ������ڸ�ѧ�ŵ�ѧ����" << endl;
        }
    }

}
//����ѧ��������ѧ���������е��±�
void StudentManager::find_Std()
{
    if (this->m_fileIsEmpty)
    {
        cout << "�ļ������ڻ����ļ�Ϊ��" << endl;
    }
    else
    {
        cout << "��������Ҫ���ҵ�ѧ��ѧ�ţ�" << endl;
        string number;
        cin >> number;
        int index = this->IsExist(number);
        if (index != -1)
        {
            cout << "���ҳɹ�����ѧ����Ϣ���£�" << endl;
            this->m_StdArray->at(index)->showPersonal();
        }
        else
        {
            cout << "����ʧ�ܣ���ѧ�������ڣ�" << endl;
        }
    }
}
//��������ļ�
void StudentManager::clean_File()
{
    cout << "ȷ������������ݣ�" << endl;
    cout << "1,ȷ��" << endl;
    cout << "2,����" << endl;
    int selet = 0;
    cin >> selet;
    if (selet == 1)
    {
        ofstream ofs(FILENAME, ios::trunc);//����Ϊ FILENAME ���ļ���ʹ�� ios::trunc ģʽ���ض�ģʽ��
        //�򿪣��������ļ��е��������ݡ�
        ofs.close();
        if (this->m_StdArray)
        {
            // �������
            for (auto student : *this->m_StdArray)
            {
                delete student; // ɾ��ѧ������
            }
            this->m_StdArray->clear(); // �����������
            delete this->m_StdArray;  // ɾ����������
            this->m_StdArray = nullptr; // ������ָ����Ϊ nullptr
            this->m_fileIsEmpty = true;
            cout << "��ճɹ���" << endl;
        }
    }

}
//��������������
StudentManager :: ~StudentManager()
{
    if (this->m_StdArray)
    {
        // �������
        for (auto student : *this->m_StdArray)
        {
            delete student; // ɾ��ѧ������
        }
        this->m_StdArray->clear(); // �����������
        delete this->m_StdArray;  // ɾ����������
        this->m_StdArray = nullptr; // ������ָ����Ϊ nullptr
    }
}
//��ͨѧ������ʵ��
Normalstudent::Normalstudent(string number, string name, string college, string duty)
{
    this->S_number = number;
    this->S_name = name;
    this->S_college = college;
    this->S_Duty = duty;
}
//������д�����麯��
void Normalstudent::showPersonal()
{
    cout << "ѧ��ѧ�ţ�" << this->S_number
        << "\tѧ������:" << this->S_name
        << "\t ѧ��ѧԺ�༶��" << this->S_college
        << "\tѧ��ְλ:" << this->S_Duty
        << "\tѧ������:���ذ༶����" << endl;
}
//�೤����ʵ��
ClassPresident::ClassPresident(string number, string name, string college, string duty)
{
    this->S_number = number;
    this->S_name = name;
    this->S_college = college;
    this->S_Duty = duty;
}
//������д�����麯��
void ClassPresident::showPersonal()
{
    cout << "ѧ��ѧ�ţ�" << this->S_number
        << "\tѧ������:" << this->S_name
        << "\t ѧ��ѧԺ�༶��" << this->S_college
        << "\tѧ��ְλ:" << this->S_Duty
        << "\tѧ������:�븨��Ա�Խ�,����༶" << endl;
}
//��֧�麯��ʵ��
Classleague::Classleague(string number, string name, string college, string duty)
{
    this->S_number = number;
    this->S_name = name;
    this->S_college = college;
    this->S_Duty = duty;
}
void Classleague::showPersonal()
{
    cout << "ѧ��ѧ�ţ�" << this->S_number
        << "\tѧ������:" << this->S_name
        << "\t ѧ��ѧԺ�༶��" << this->S_college
        << "\tѧ��ְλ:" << this->S_Duty
        << "\tѧ������:����֧���Խ�,����༶" << endl;
}
//��ɲ�����ʵ��
Classleader::Classleader(string number, string name, string college, string duty)
{
    this->S_number = number;
    this->S_name = name;
    this->S_college = college;
    this->S_Duty = duty;
}
void Classleader::showPersonal()
{
    cout << "ѧ��ѧ�ţ�" << this->S_number
        << "\tѧ������:" << this->S_name
        << "\t ѧ��ѧԺ�༶��" << this->S_college
        << "\tѧ��ְλ:" << this->S_Duty
        << "\tѧ������:�����Լ���ְ�𣬺͸�����ʦ�Խӣ�����༶ѧ��" << endl;
}
void centertext()
{
    //��һ������
    int rx = 60;
    int ry = 30;
    int rw = 500;
    int rh = 60;
    setfillcolor(RGB(116, 88, 97));
    fillrectangle(rx, ry, rx + rw, ry + rh);
    //��������
    settextcolor(BLUE);
    settextstyle(48, 0, "΢���ź�");
    char str[] = "ѧ����������ϵͳ";
    int hspace = (rw - textwidth(str)) / 2;
    int vspace = (rh - textheight(str)) / 2;
    outtextxy(rx + hspace, ry + vspace, str);
}
void quit()
{
    int rx = 170;
    int ry = 100;
    int rw = 300;
    int rh = 45;
    setfillcolor(RGB(230, 231, 232));
    fillrectangle(rx, ry, rx + rw, ry + rh);
    //��������
    settextcolor(RED);
    settextstyle(40, 0, "����");
    char str[100] = "�˳�ϵͳ�밴0";
    int hspace = (rw - textwidth(str)) / 2;
    int vspace = (rh - textheight(str)) / 2;
    outtextxy(rx + hspace, ry + vspace, str);
}
void add()
{
    int rx = 170;
    int ry = 155;
    int rw = 300;
    int rh = 45;
    setfillcolor(RGB(230, 231, 232));
    fillrectangle(rx, ry, rx + rw, ry + rh);
    //��������
    settextcolor(RED);
    settextstyle(40, 0, "����");
    char str[100] = "���ѧ���밴1";
    int hspace = (rw - textwidth(str)) / 2;
    int vspace = (rh - textheight(str)) / 2;
    outtextxy(rx + hspace, ry + vspace, str);
}
void display()
{
    int rx = 170;
    int ry = 210;
    int rw = 300;
    int rh = 45;
    setfillcolor(RGB(230, 231, 232));
    fillrectangle(rx, ry, rx + rw, ry + rh);
    //��������
    settextcolor(RED);
    settextstyle(40, 0, "����");
    char str[100] = "��ʾѧ���밴2";
    int hspace = (rw - textwidth(str)) / 2;
    int vspace = (rh - textheight(str)) / 2;
    outtextxy(rx + hspace, ry + vspace, str);
}
void cancel()
{
    int rx = 170;
    int ry = 265;
    int rw = 300;
    int rh = 45;
    setfillcolor(RGB(230, 231, 232));
    fillrectangle(rx, ry, rx + rw, ry + rh);
    //��������
    settextcolor(RED);
    settextstyle(40, 0, "����");
    char str[100] = "ɾ��ѧ���밴3";
    int hspace = (rw - textwidth(str)) / 2;
    int vspace = (rh - textheight(str)) / 2;
    outtextxy(rx + hspace, ry + vspace, str);
}
void edit()
{
    int rx = 170;
    int ry = 320;
    int rw = 300;
    int rh = 45;
    setfillcolor(RGB(230, 231, 232));
    fillrectangle(rx, ry, rx + rw, ry + rh);
    //��������
    settextcolor(RED);
    settextstyle(40, 0, "����");
    char str[100] = "�޸�ѧ���밴4";
    int hspace = (rw - textwidth(str)) / 2;
    int vspace = (rh - textheight(str)) / 2;
    outtextxy(rx + hspace, ry + vspace, str);
}
void search()
{
    int rx = 170;
    int ry = 375;
    int rw = 300;
    int rh = 45;
    setfillcolor(RGB(230, 231, 232));
    fillrectangle(rx, ry, rx + rw, ry + rh);
    //��������
    settextcolor(RED);
    settextstyle(40, 0, "����");
    char str[100] = "����ѧ���밴5";
    int hspace = (rw - textwidth(str)) / 2;
    int vspace = (rh - textheight(str)) / 2;
    outtextxy(rx + hspace, ry + vspace, str);
}
void empty()
{
    int rx = 170;
    int ry = 430;
    int rw = 300;
    int rh = 45;
    setfillcolor(RGB(230, 231, 232));
    fillrectangle(rx, ry, rx + rw, ry + rh);
    //��������
    settextcolor(RED);
    settextstyle(40, 0, "����");
    char str[100] = "��������밴6";
    int hspace = (rw - textwidth(str)) / 2;
    int vspace = (rh - textheight(str)) / 2;
    outtextxy(rx + hspace, ry + vspace, str);
}
void background()
{
    float H = 190;		// ɫ��
    float S = 1;		// ���Ͷ�
    float L = 0.7f;		// ����
    for (int y = 0; y < 480; y++)
    {
        L += 0.0005f;
        setlinecolor(HSLtoRGB(H, S, L));
        line(0, y, 639, y);
    }
    // ���ʺ�(ͨ��ɫ��������)
    H = 0;
    S = 1;
    L = 0.5f;
    setlinestyle(PS_SOLID, 2);		// �����߿�Ϊ 2
    for (int r = 400; r > 344; r--)
    {
        H += 5;
        setlinecolor(HSLtoRGB(H, S, L));
        circle(500, 480, r);
    }
}
//������
int main()
{
    initgraph(640, 480, EX_SHOWCONSOLE | EX_DBLCLKS);
    background();
    centertext();
    quit();
    add();
    display();
    cancel();
    edit();
    search();
    empty();
    StudentManager stm;     //ʵ��������Ա
    int choice;             //�洢�û�ѡ��
    bool isRunning = true;
    while (true)
    {
        stm.Show_Menu();
        //���ô�ӡ�����Ա����
        cout << "����������ѡ��" << endl;
        cin >> choice;
        switch (choice)
        {
        case 0:           //�˳�ϵͳ
            isRunning = false;
            stm.Exit_System();
            break;
        case 1:             //����ѧ��
            stm.Addinfo();
            break;
        case 2:             //��ʾѧ��
            stm.show_Std();
            break;
        case 3:             //ɾ��ѧ��
            stm.del_Std();
            break;
        case 4:             //�޸�ѧ��
            stm.mod_Std();
            break;
        case 5:             //����ѧ��
            stm.find_Std();
            break;
        case 6:             //����ĵ�
            stm.clean_File();
            break;
        default:
            system("clear");  //��������
            break;
        }
    }

    getchar();
    closegraph();
    return 0;
}