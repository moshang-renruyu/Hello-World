#include <iostream>
#include<fstream>
#include<cstring>
#include<vector>
#include<easyx.h>
using namespace std;
#include<graphics.h>
#include<conio.h>
#define FILENAME "stdFILE.txt" //定义生成文件名称
//学生类(抽象类)
class Student
{
public:
    //纯虚函数 
    virtual void showPersonal() = 0; //显示个人信息
    virtual ~Student() = 0;      //定义纯虚析构函数保证释放堆区内存时不会发生内存泄漏
    string S_number;     //学号
    string S_name;  //姓名
    string S_college;//学院 专业
    string S_Duty;  //职责
};
//普通学生类
class Normalstudent : public Student
{
public:
    Normalstudent(string number, string name, string college, string duty); //构造函数
    void showPersonal(); //显示个人信息
    ~Normalstudent()
    {
        cout << "普通学生被删除了" << endl;
    }
};
//班长类
class ClassPresident : public Student
{
public:
    ClassPresident(string number, string name, string college, string duty);
    void showPersonal();
    ~ClassPresident()
    {
        cout << "班长被删除了" << endl;
    }
};
//团支书
class Classleague :public Student
{
public:
    Classleague(string number, string name, string college, string duty);
    void showPersonal();
    ~Classleague()
    {
        cout << "团支书被删除了" << endl;
    }
};
//班干部类
class Classleader : public Student
{
public:
    Classleader(string number, string name, string college, string duty);
    void showPersonal();
    ~Classleader()
    {
        cout << "班干部被删除了" << endl;
    }
};
//管理员类
class StudentManager
{
public:
    StudentManager();//构造函数
    void Show_Menu(); //打印菜单界面
    void Exit_System();//退出系统
    void Addinfo();    //增加学生信息
    void save();       //将学生信息保存到文件中
    void init_Std();   //初始化学生
    void show_Std();   //显示学生信息
    void del_Std();    //删除学生信息
    void mod_Std();    //修改学生信息
    void find_Std();   //查找学生信息
    void clean_File(); //清空文件
    int IsExist(string id);     //判断学号为id的学生信息是否存在，并返回该学生下标
    ~StudentManager();//析构函数
    vector<Student*>* m_StdArray; //存放增加的学生信息
    bool m_fileIsEmpty;     //标记文件是否为空
};
//学生类纯虚析构的外部实现
Student :: ~Student()
{
    cout << "学生类被删除了" << endl;
}
//管理员函数实现 构造函数
StudentManager::StudentManager()
{
    ifstream ifs;
    ifs.open(FILENAME, ios::in);
    //如果文件不存在
    if (!ifs.is_open())
    {
        cout << "该文件不存在！" << endl;
        this->m_fileIsEmpty = true;
        this->m_StdArray = NULL;
        ifs.close();
        return;
    }
    //文件存在但是数据为空
    char ch;
    ifs >> ch;       //先读取一个字符
    if (ifs.eof())
    {
        cout << "该文件为空！" << endl;
        this->m_fileIsEmpty = true;
        this->m_StdArray = NULL;
        ifs.close();
        return;
    }
    cout << "StudentManager构造函数" << endl;
    cout << "文件存在并有记录" << endl;
    //文件存在，并记录初始数据
    this->m_StdArray = new vector<Student*>;
    if (this->m_StdArray)
    {
        cout << "m_StdArray指针存在" << endl;
    }
    this->init_Std();
}
void StudentManager::Show_Menu()
{
    cout << "--------------------------------------------" << endl;
    cout << "-----------  欢迎使用学生管理系统！ --------" << endl;
    cout << "-------------  0.退出管理程序  -------------" << endl;
    cout << "-------------  1.增加学生信息  -------------" << endl;
    cout << "-------------  2.显示学生信息  -------------" << endl;
    cout << "-------------  3.删除学生信息  -------------" << endl;
    cout << "-------------  4.修改学生信息  -------------" << endl;
    cout << "-------------  5.查找学生信息  -------------" << endl;
    cout << "-------------  6.清空所有数据  -------------" << endl;
    cout << "--------------------------------------------" << endl;
}
void StudentManager::Exit_System()
{
    cout << "感谢您的使用！" << endl;
    return;  //退出系统
}
void StudentManager::Addinfo()
{
    //如果容器不存在，就新建容器
    if (!this->m_StdArray)
        this->m_StdArray = new vector<Student*>;
    cout << "学生信息开始录入" << endl;
    int i = 1;
    while (true)
    {
        char flag;
        string number;    //学号
        string name; //姓名
        string college;//学院 专业
        string duty;  //职位
        cout << "请输入第" << i << "个学生学号：" << endl;
        cin >> number;
        cout << "请输入第" << i << "个学生姓名：" << endl;
        cin >> name;
        cout << "请输入第" << i << "个学生学院班级：" << endl;
        cin >> college;
        cout << "请输入第" << i << "个学生职位：(班长or团支书or班干部or普通学生)" << endl;
        cin >> duty;
        Student* std = NULL;
        if (duty == "班长")
        {
            std = new ClassPresident(number, name, college, duty);
        }
        else if (duty == "团支书")
        {
            std = new Classleague(number, name, college, duty);
        }
        else if (duty == "班干部")
        {
            std = new Classleader(number, name, college, duty);
        }
        else if (duty == "普通学生")
        {
            std = new Normalstudent(number, name, college, duty);
        }
        else
        {
            cout << "该学生职位不存在！信息录入结束！" << endl;
            break;
        }
        //把添加的学生 放进容器中
        this->m_StdArray->push_back(std);
        i++; //学生人数++
        this->m_fileIsEmpty = false;   //更新文件非空标记
        cout << "是否继续录入信息？(y继续录入,n结束录入)" << endl;
        cin >> flag;
        if (flag == 'y') continue;
        else break;
    }
    cout << "成功添加了" << i - 1 << "名学生信息!" << endl;
    this->save();
    
}
void StudentManager::save()
{
    ofstream ofs;
    ofs.open(FILENAME, ios::out); //重新打开文件，以覆盖的方式保存文件，清除之前的信息。
    for (int i = 0; i < this->m_StdArray->size(); ++i)
    {
        ofs << this->m_StdArray->at(i)->S_number << " "
            << this->m_StdArray->at(i)->S_name << " "
            << this->m_StdArray->at(i)->S_college << " "
            << this->m_StdArray->at(i)->S_Duty << endl;
    }
    ofs.close();
}
//初始化学生，把已有的学生加载到容器中
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
        if (duty == "班长")
        {
            std = new ClassPresident(number, name, college, duty);
        }
        else if (duty == "团支书")
        {
            std = new Classleague(number, name, college, duty);
        }
        else if (duty == "班干部")
        {
            std = new Classleader(number, name, college, duty);
        }
        else if (duty == "普通学生")
        {
            std = new Normalstudent(number, name, college, duty);
        }
        this->m_StdArray->push_back(std);
    }
    this->m_fileIsEmpty = false;
    // 调试输出
    cout << "文件读取结束" << endl;
    cout << "ifs.eof() = " << ifs.eof() << endl;
    cout << "m_StdArray size = " << this->m_StdArray->size() << endl;
    this->save();
}
//显示学生信息
void StudentManager::show_Std()
{
    if (this->m_fileIsEmpty)
    {
        cout << "文件不存在或者文件为空！" << endl;
    }
    else
    {
        for (int i = 0; i < this->m_StdArray->size(); ++i)
        {
            this->m_StdArray->at(i)->showPersonal();
        }
    }

}
//删除学生
void StudentManager::del_Std()
{
    if (this->m_fileIsEmpty)
    {
        cout << "文件不存在或者文件为空！" << endl;
    }
    else
    {
        cout << "请输入需要删除的学生学号：" << endl;
        string number;
        cin >> number;
        int index = this->IsExist(number); //返回值是学生在容器中的下标
        if (index != -1)
        {
            this->m_StdArray->erase(this->m_StdArray->begin() + index);
            this->save();
            cout << "删除成功！" << endl;
        }
        else
        {
            cout << "删除失败，不存在该学号的学生！" << endl;
        }
    }

}
//在容器中，寻找指定下标的学生 返回学生下标
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
//修改学生
void StudentManager::mod_Std()
{
    if (this->m_fileIsEmpty)
    {
        cout << "文件不存在或者文件为空" << endl;
    }
    else
    {
        cout << "请输入需要修改的学生学号：" << endl;
        string number;
        cin >> number;
        int index = this->IsExist(number); //这里不需要设置循环输入，
        if (index != -1)
        {
            // 删除原来的学生对象
            delete this->m_StdArray->at(index);
            this->m_StdArray->at(index) = nullptr; // 将指针设置为 nullptr
            string newnumber;
            string newname;
            string newcollege;
            string newduty;
            Student* std = NULL;
            cout << "搜索到学号为" << number << "的学生，请输入新学号：" << endl;
            cin >> newnumber;
            cout << "请输入新姓名：" << endl;
            cin >> newname;
            cout << "请输入新学院与班级";
            cin >> newcollege;
            cout << "请输入新职责：" << endl;
            cin >> newduty;
            if (newduty == "班长")
            {
                std = new ClassPresident(newnumber, newname, newcollege, newduty);
            }
            else if (newduty == "团支书")
            {
                std = new Classleague(newnumber, newname, newcollege, newduty);
            }
            else if (newduty == "班干部")
            {
                std = new Classleader(newnumber, newname, newcollege, newduty);
            }
            else if (newduty == "普通学生")
            {
                std = new Normalstudent(newnumber, newname, newcollege, newduty);
            }
            this->m_StdArray->at(index) = std;
            cout << "修改成功！" << endl;
            this->save();
        }
        else
        {
            cout << "修改失败，不存在该学号的学生！" << endl;
        }
    }

}
//查找学生，返回学生在容器中的下标
void StudentManager::find_Std()
{
    if (this->m_fileIsEmpty)
    {
        cout << "文件不存在或者文件为空" << endl;
    }
    else
    {
        cout << "请输入需要查找的学生学号：" << endl;
        string number;
        cin >> number;
        int index = this->IsExist(number);
        if (index != -1)
        {
            cout << "查找成功！该学生信息如下：" << endl;
            this->m_StdArray->at(index)->showPersonal();
        }
        else
        {
            cout << "查找失败！该学生不存在！" << endl;
        }
    }
}
//清空所有文件
void StudentManager::clean_File()
{
    cout << "确定清空所有数据？" << endl;
    cout << "1,确定" << endl;
    cout << "2,返回" << endl;
    int selet = 0;
    cin >> selet;
    if (selet == 1)
    {
        ofstream ofs(FILENAME, ios::trunc);//打开名为 FILENAME 的文件并使用 ios::trunc 模式（截断模式）
        //打开，这会清空文件中的所有内容。
        ofs.close();
        if (this->m_StdArray)
        {
            // 清空容器
            for (auto student : *this->m_StdArray)
            {
                delete student; // 删除学生对象
            }
            this->m_StdArray->clear(); // 清空容器内容
            delete this->m_StdArray;  // 删除容器本身
            this->m_StdArray = nullptr; // 将容器指针置为 nullptr
            this->m_fileIsEmpty = true;
            cout << "清空成功！" << endl;
        }
    }

}
//管理类析构函数
StudentManager :: ~StudentManager()
{
    if (this->m_StdArray)
    {
        // 清空容器
        for (auto student : *this->m_StdArray)
        {
            delete student; // 删除学生对象
        }
        this->m_StdArray->clear(); // 清空容器内容
        delete this->m_StdArray;  // 删除容器本身
        this->m_StdArray = nullptr; // 将容器指针置为 nullptr
    }
}
//普通学生函数实现
Normalstudent::Normalstudent(string number, string name, string college, string duty)
{
    this->S_number = number;
    this->S_name = name;
    this->S_college = college;
    this->S_Duty = duty;
}
//子类重写父类虚函数
void Normalstudent::showPersonal()
{
    cout << "学生学号：" << this->S_number
        << "\t学生姓名:" << this->S_name
        << "\t 学生学院班级：" << this->S_college
        << "\t学生职位:" << this->S_Duty
        << "\t学生任务:遵守班级纪律" << endl;
}
//班长函数实现
ClassPresident::ClassPresident(string number, string name, string college, string duty)
{
    this->S_number = number;
    this->S_name = name;
    this->S_college = college;
    this->S_Duty = duty;
}
//子类重写父类虚函数
void ClassPresident::showPersonal()
{
    cout << "学生学号：" << this->S_number
        << "\t学生姓名:" << this->S_name
        << "\t 学生学院班级：" << this->S_college
        << "\t学生职位:" << this->S_Duty
        << "\t学生任务:与辅导员对接,带领班级" << endl;
}
//团支书函数实现
Classleague::Classleague(string number, string name, string college, string duty)
{
    this->S_number = number;
    this->S_name = name;
    this->S_college = college;
    this->S_Duty = duty;
}
void Classleague::showPersonal()
{
    cout << "学生学号：" << this->S_number
        << "\t学生姓名:" << this->S_name
        << "\t 学生学院班级：" << this->S_college
        << "\t学生职位:" << this->S_Duty
        << "\t学生任务:与团支部对接,引领班级" << endl;
}
//班干部函数实现
Classleader::Classleader(string number, string name, string college, string duty)
{
    this->S_number = number;
    this->S_name = name;
    this->S_college = college;
    this->S_Duty = duty;
}
void Classleader::showPersonal()
{
    cout << "学生学号：" << this->S_number
        << "\t学生姓名:" << this->S_name
        << "\t 学生学院班级：" << this->S_college
        << "\t学生职位:" << this->S_Duty
        << "\t学生任务:履行自己的职责，和各科老师对接，管理班级学生" << endl;
}
void centertext()
{
    //来一个矩形
    int rx = 60;
    int ry = 30;
    int rw = 500;
    int rh = 60;
    setfillcolor(RGB(116, 88, 97));
    fillrectangle(rx, ry, rx + rw, ry + rh);
    //绘制文字
    settextcolor(BLUE);
    settextstyle(48, 0, "微软雅黑");
    char str[] = "学生档案管理系统";
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
    //绘制文字
    settextcolor(RED);
    settextstyle(40, 0, "楷体");
    char str[100] = "退出系统请按0";
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
    //绘制文字
    settextcolor(RED);
    settextstyle(40, 0, "楷体");
    char str[100] = "添加学生请按1";
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
    //绘制文字
    settextcolor(RED);
    settextstyle(40, 0, "楷体");
    char str[100] = "显示学生请按2";
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
    //绘制文字
    settextcolor(RED);
    settextstyle(40, 0, "楷体");
    char str[100] = "删除学生请按3";
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
    //绘制文字
    settextcolor(RED);
    settextstyle(40, 0, "楷体");
    char str[100] = "修改学生请按4";
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
    //绘制文字
    settextcolor(RED);
    settextstyle(40, 0, "楷体");
    char str[100] = "查找学生请按5";
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
    //绘制文字
    settextcolor(RED);
    settextstyle(40, 0, "楷体");
    char str[100] = "清空数据请按6";
    int hspace = (rw - textwidth(str)) / 2;
    int vspace = (rh - textheight(str)) / 2;
    outtextxy(rx + hspace, ry + vspace, str);
}
void background()
{
    float H = 190;		// 色相
    float S = 1;		// 饱和度
    float L = 0.7f;		// 亮度
    for (int y = 0; y < 480; y++)
    {
        L += 0.0005f;
        setlinecolor(HSLtoRGB(H, S, L));
        line(0, y, 639, y);
    }
    // 画彩虹(通过色相逐渐增加)
    H = 0;
    S = 1;
    L = 0.5f;
    setlinestyle(PS_SOLID, 2);		// 设置线宽为 2
    for (int r = 400; r > 344; r--)
    {
        H += 5;
        setlinecolor(HSLtoRGB(H, S, L));
        circle(500, 480, r);
    }
}
//主函数
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
    StudentManager stm;     //实例化管理员
    int choice;             //存储用户选项
    bool isRunning = true;
    while (true)
    {
        stm.Show_Menu();
        //调用打印界面成员函数
        cout << "请输入您的选择：" << endl;
        cin >> choice;
        switch (choice)
        {
        case 0:           //退出系统
            isRunning = false;
            stm.Exit_System();
            break;
        case 1:             //增加学生
            stm.Addinfo();
            break;
        case 2:             //显示学生
            stm.show_Std();
            break;
        case 3:             //删除学生
            stm.del_Std();
            break;
        case 4:             //修改学生
            stm.mod_Std();
            break;
        case 5:             //查找学生
            stm.find_Std();
            break;
        case 6:             //清空文档
            stm.clean_File();
            break;
        default:
            system("clear");  //清屏操作
            break;
        }
    }

    getchar();
    closegraph();
    return 0;
}