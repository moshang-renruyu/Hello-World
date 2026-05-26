-- ============================================
-- HRMS 人事管理系统 数据库初始化脚本
-- ============================================

CREATE DATABASE IF NOT EXISTS hrms DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE hrms;

-- 系统用户表
CREATE TABLE sys_user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    real_name VARCHAR(50),
    role INT DEFAULT 0 COMMENT '0-普通用户 1-管理员',
    avatar VARCHAR(200),
    email VARCHAR(100),
    phone VARCHAR(20),
    status INT DEFAULT 1 COMMENT '0-禁用 1-启用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_login DATETIME
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 部门表
CREATE TABLE department (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(50),
    manager VARCHAR(50),
    phone VARCHAR(20),
    description TEXT,
    parent_id INT DEFAULT 0,
    sort_order INT DEFAULT 0,
    status INT DEFAULT 1 COMMENT '0-停用 1-正常',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 职位表
CREATE TABLE position_info (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(50),
    dept_id INT,
    level INT DEFAULT 1 COMMENT '1-初级 2-中级 3-高级 4-专家',
    salary_min DECIMAL(10,2) DEFAULT 0,
    salary_max DECIMAL(10,2) DEFAULT 0,
    description TEXT,
    status INT DEFAULT 1,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dept_id) REFERENCES department(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 员工表
CREATE TABLE employee (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_no VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    gender INT DEFAULT 1 COMMENT '1-男 2-女',
    birth_date DATE,
    id_card VARCHAR(18),
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(200),
    photo VARCHAR(200),
    dept_id INT,
    position_id INT,
    hire_date DATE,
    leave_date DATE,
    status INT DEFAULT 1 COMMENT '1-在职 2-离职 3-试用期',
    education VARCHAR(50),
    university VARCHAR(100),
    major VARCHAR(100),
    emergency_contact VARCHAR(50),
    emergency_phone VARCHAR(20),
    contract_start DATE,
    contract_end DATE,
    remark TEXT,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dept_id) REFERENCES department(id) ON DELETE SET NULL,
    FOREIGN KEY (position_id) REFERENCES position_info(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 考勤记录表
CREATE TABLE attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    work_date DATE NOT NULL,
    check_in TIME,
    check_out TIME,
    status INT DEFAULT 1 COMMENT '1-正常 2-迟到 3-早退 4-缺勤 5-请假',
    remark VARCHAR(200),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (emp_id) REFERENCES employee(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 薪资记录表
CREATE TABLE salary (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    month VARCHAR(7) NOT NULL COMMENT '格式: YYYY-MM',
    base_salary DECIMAL(10,2) DEFAULT 0,
    bonus DECIMAL(10,2) DEFAULT 0,
    allowance DECIMAL(10,2) DEFAULT 0,
    overtime_pay DECIMAL(10,2) DEFAULT 0,
    deduction DECIMAL(10,2) DEFAULT 0,
    insurance DECIMAL(10,2) DEFAULT 0,
    tax DECIMAL(10,2) DEFAULT 0,
    actual_salary DECIMAL(10,2) DEFAULT 0,
    status INT DEFAULT 0 COMMENT '0-未发放 1-已发放',
    remark VARCHAR(200),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (emp_id) REFERENCES employee(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 请假申请表
CREATE TABLE leave_request (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT NOT NULL,
    type INT COMMENT '1-事假 2-病假 3-年假 4-婚假 5-产假 6-丧假',
    start_date DATE,
    end_date DATE,
    days DECIMAL(5,1),
    reason TEXT,
    attachment VARCHAR(200),
    status INT DEFAULT 0 COMMENT '0-待审批 1-已批准 2-已拒绝 3-已撤销',
    approver_id INT,
    approve_time DATETIME,
    approve_remark VARCHAR(200),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (emp_id) REFERENCES employee(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 招聘信息表
CREATE TABLE recruitment (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    dept_id INT,
    position_name VARCHAR(100),
    head_count INT DEFAULT 1,
    education VARCHAR(50),
    experience VARCHAR(100),
    salary_range VARCHAR(100),
    description TEXT,
    requirement TEXT,
    status INT DEFAULT 1 COMMENT '1-招聘中 2-已暂停 3-已结束',
    publisher VARCHAR(50),
    publish_date DATE,
    deadline DATE,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dept_id) REFERENCES department(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 培训记录表
CREATE TABLE training (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    type INT COMMENT '1-内部培训 2-外部培训 3-在线培训',
    trainer VARCHAR(50),
    dept_id INT,
    start_date DATE,
    end_date DATE,
    location VARCHAR(200),
    content TEXT,
    max_count INT DEFAULT 0,
    current_count INT DEFAULT 0,
    status INT DEFAULT 1 COMMENT '1-计划中 2-进行中 3-已结束',
    attachment VARCHAR(200),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dept_id) REFERENCES department(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 系统操作日志
CREATE TABLE system_log (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    username VARCHAR(50),
    operation VARCHAR(200),
    module VARCHAR(100),
    ip VARCHAR(50),
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- 初始数据
-- ============================================

INSERT INTO sys_user (username, password, real_name, role, email, phone) VALUES
('admin', 'admin123', '系统管理员', 1, 'admin@hrms.com', '13800000000'),
('zhangsan', '123456', '张三', 0, 'zhangsan@hrms.com', '13800000001');

INSERT INTO department (name, code, manager, phone, description, sort_order) VALUES
('总经办', 'CEO', '张伟', '010-88881111', '公司最高管理层', 1),
('人力资源部', 'HR', '李娜', '010-88882222', '负责人力资源规划与管理', 2),
('技术研发部', 'RD', '王强', '010-88883333', '负责产品技术研发', 3),
('市场营销部', 'MKT', '赵敏', '010-88884444', '负责市场推广与品牌运营', 4),
('财务部', 'FIN', '钱进', '010-88885555', '负责公司财务与资金管理', 5),
('行政后勤部', 'ADM', '孙莉', '010-88886666', '负责行政事务与后勤保障', 6);

INSERT INTO position_info (name, code, dept_id, level, salary_min, salary_max, description) VALUES
('总经理', 'CEO-01', 1, 4, 30000, 50000, '公司总经理'),
('副总经理', 'CEO-02', 1, 4, 25000, 40000, '公司副总经理'),
('HR总监', 'HR-01', 2, 4, 20000, 35000, '人力资源总监'),
('HR主管', 'HR-02', 2, 3, 12000, 20000, '人力资源主管'),
('HR专员', 'HR-03', 2, 2, 6000, 12000, '人力资源专员'),
('技术总监', 'RD-01', 3, 4, 25000, 45000, '技术研发总监'),
('高级工程师', 'RD-02', 3, 3, 15000, 30000, '高级开发工程师'),
('中级工程师', 'RD-03', 3, 2, 10000, 20000, '中级开发工程师'),
('初级工程师', 'RD-04', 3, 1, 6000, 12000, '初级开发工程师'),
('市场经理', 'MKT-01', 4, 3, 12000, 25000, '市场营销经理'),
('市场专员', 'MKT-02', 4, 2, 6000, 12000, '市场营销专员'),
('财务主管', 'FIN-01', 5, 3, 12000, 20000, '财务主管'),
('会计', 'FIN-02', 5, 2, 6000, 12000, '会计专员'),
('行政主管', 'ADM-01', 6, 3, 10000, 18000, '行政主管'),
('行政专员', 'ADM-02', 6, 2, 5000, 10000, '行政专员');

INSERT INTO employee (emp_no, name, gender, birth_date, id_card, phone, email, dept_id, position_id, hire_date, status, education, university, major) VALUES
('EMP20150001', '张伟', 1, '1980-05-15', '110101198005150011', '13800138001', 'zhangwei@hrms.com', 1, 1, '2015-01-01', 1, '硕士', '北京大学', '工商管理'),
('EMP20180001', '李娜', 2, '1988-08-20', '110101198808200022', '13800138002', 'lina@hrms.com', 2, 3, '2018-03-15', 1, '本科', '中国人民大学', '人力资源管理'),
('EMP20170001', '王强', 1, '1990-02-10', '110101199002100033', '13800138003', 'wangqiang@hrms.com', 3, 6, '2017-06-01', 1, '硕士', '清华大学', '计算机科学'),
('EMP20190001', '赵敏', 2, '1992-11-25', '110101199211250044', '13800138004', 'zhaomin@hrms.com', 4, 10, '2019-09-01', 1, '本科', '复旦大学', '市场营销'),
('EMP20160001', '钱进', 1, '1985-07-08', '110101198507080055', '13800138005', 'qianjin@hrms.com', 5, 12, '2016-04-20', 1, '本科', '上海财经大学', '会计学'),
('EMP20200001', '孙莉', 2, '1991-03-18', '110101199103180066', '13800138006', 'sunli@hrms.com', 6, 14, '2020-01-10', 1, '本科', '北京师范大学', '行政管理'),
('EMP20210001', '周杰', 1, '1995-09-22', '110101199509220077', '13800138007', 'zhoujie@hrms.com', 3, 7, '2021-07-01', 1, '硕士', '浙江大学', '软件工程'),
('EMP20210002', '吴芳', 2, '1996-12-05', '110101199612050088', '13800138008', 'wufang@hrms.com', 2, 5, '2021-08-15', 3, '本科', '南京大学', '人力资源管理'),
('EMP20220001', '郑浩', 1, '1997-04-30', '110101199704300099', '13800138009', 'zhenghao@hrms.com', 3, 8, '2022-03-01', 1, '本科', '武汉大学', '计算机科学'),
('EMP20220002', '陈静', 2, '1993-06-14', '110101199306140100', '13800138010', 'chenjing@hrms.com', 4, 11, '2022-05-20', 1, '本科', '中山大学', '广告学'),
('EMP20200002', '刘洋', 1, '1994-01-12', '110101199401120111', '13800138011', 'liuyang@hrms.com', 3, 9, '2020-07-15', 1, '本科', '华中科技大学', '软件工程'),
('EMP20190002', '黄丽', 2, '1990-10-08', '110101199010080122', '13800138012', 'huangli@hrms.com', 5, 13, '2019-04-10', 1, '本科', '中央财经大学', '财务管理'),
('EMP20230001', '林峰', 1, '1998-03-25', '110101199803250133', '13800138013', 'linfeng@hrms.com', 3, 9, '2023-02-20', 3, '本科', '东南大学', '计算机科学'),
('EMP20230002', '何雪', 2, '1997-07-19', '110101199707190144', '13800138014', 'hexue@hrms.com', 2, 4, '2023-03-01', 1, '硕士', '北京师范大学', '心理学'),
('EMP20180002', '马超', 1, '1989-12-03', '110101198912030155', '13800138015', 'machao@hrms.com', 4, 10, '2018-06-15', 2, '本科', '厦门大学', '市场营销'),
('EMP20210003', '杨柳', 2, '1995-05-28', '110101199505280166', '13800138016', 'yangliu@hrms.com', 6, 15, '2021-09-01', 1, '本科', '华东师范大学', '行政管理'),
('EMP20220003', '徐明', 1, '1996-08-15', '110101199608150177', '13800138017', 'xuming@hrms.com', 3, 8, '2022-07-10', 1, '硕士', '同济大学', '人工智能'),
('EMP20190003', '胡蝶', 2, '1991-04-22', '110101199104220188', '13800138018', 'hudie@hrms.com', 5, 12, '2019-11-05', 1, '本科', '西南财经大学', '会计学'),
('EMP20240001', '罗斌', 1, '1999-02-14', '110101199902140199', '13800138019', 'luobin@hrms.com', 3, 9, '2024-01-15', 3, '本科', '哈尔滨工业大学', '计算机科学'),
('EMP20230003', '谢婷', 2, '1998-11-30', '110101199811300200', '13800138020', 'xieting@hrms.com', 6, 15, '2023-06-01', 1, '本科', '四川大学', '公共管理');

-- ============================================
-- 更多用户数据
-- ============================================
INSERT INTO sys_user (username, password, real_name, role, email, phone) VALUES
('lina', '123456', '李娜', 0, 'lina@hrms.com', '13800138002'),
('wangqiang', '123456', '王强', 0, 'wangqiang@hrms.com', '13800138003'),
('zhaomin', '123456', '赵敏', 0, 'zhaomin@hrms.com', '13800138004'),
('qianjin', '123456', '钱进', 0, 'qianjin@hrms.com', '13800138005');

-- ============================================
-- 考勤数据 (2026年4月)
-- ============================================
INSERT INTO attendance (emp_id, work_date, check_in, check_out, status, remark) VALUES
(1, '2026-04-07', '08:25', '17:35', 1, NULL),
(2, '2026-04-07', '08:30', '17:30', 1, NULL),
(3, '2026-04-07', '08:55', '18:20', 1, NULL),
(4, '2026-04-07', '08:45', '17:40', 1, NULL),
(5, '2026-04-07', '08:28', '17:32', 1, NULL),
(6, '2026-04-07', '08:50', '17:30', 1, NULL),
(7, '2026-04-07', '09:15', '18:30', 2, '地铁故障'),
(8, '2026-04-07', '08:20', '17:30', 1, NULL),
(9, '2026-04-07', '08:35', '17:25', 1, NULL),
(10, '2026-04-07', '08:40', '17:30', 1, NULL),
(1, '2026-04-08', '08:30', '17:30', 1, NULL),
(2, '2026-04-08', '08:25', '17:35', 1, NULL),
(3, '2026-04-08', '08:50', '18:10', 1, NULL),
(4, '2026-04-08', '09:05', '17:30', 2, '堵车'),
(5, '2026-04-08', '08:30', '17:30', 1, NULL),
(6, '2026-04-08', '08:45', '17:30', 1, NULL),
(7, '2026-04-08', '08:28', '18:45', 1, NULL),
(8, '2026-04-08', '08:30', '17:30', 1, NULL),
(9, '2026-04-08', '08:30', '17:30', 1, NULL),
(10, '2026-04-08', '08:35', '17:35', 1, NULL),
(1, '2026-04-09', '08:20', '17:40', 1, NULL),
(2, '2026-04-09', '08:30', '17:30', 1, NULL),
(3, '2026-04-09', '08:45', '18:00', 1, NULL),
(4, '2026-04-09', '08:30', '17:30', 1, NULL),
(5, '2026-04-09', '08:25', '17:35', 1, NULL),
(6, '2026-04-09', NULL, NULL, 4, '未打卡'),
(7, '2026-04-09', '08:30', '18:30', 1, NULL),
(8, '2026-04-09', '08:40', '17:30', 1, NULL),
(9, '2026-04-09', '08:30', '16:00', 3, '提前离开'),
(10, '2026-04-09', '08:30', '17:30', 1, NULL),
(1, '2026-04-10', '08:28', '17:32', 1, NULL),
(2, '2026-04-10', '08:30', '17:30', 1, NULL),
(3, '2026-04-10', '08:35', '18:15', 1, NULL),
(4, '2026-04-10', '08:42', '17:38', 1, NULL),
(5, '2026-04-10', '08:30', '17:30', 1, NULL),
(7, '2026-04-10', '08:25', '18:40', 1, NULL),
(8, '2026-04-10', NULL, NULL, 5, '请假'),
(9, '2026-04-10', '08:30', '17:30', 1, NULL),
(10, '2026-04-10', '08:50', '17:30', 1, NULL),
(11, '2026-04-07', '08:30', '17:35', 1, NULL),
(12, '2026-04-07', '08:25', '17:30', 1, NULL),
(11, '2026-04-08', '08:35', '17:30', 1, NULL),
(12, '2026-04-08', '08:30', '17:30', 1, NULL),
(13, '2026-04-08', '09:20', '17:30', 2, '面试迟到'),
(14, '2026-04-08', '08:30', '17:30', 1, NULL),
(11, '2026-04-09', '08:30', '17:30', 1, NULL),
(12, '2026-04-09', '08:30', '17:30', 1, NULL),
(11, '2026-04-10', '08:30', '18:00', 1, NULL),
(12, '2026-04-10', '08:28', '17:30', 1, NULL);

-- ============================================
-- 薪资数据
-- ============================================
INSERT INTO salary (emp_id, month, base_salary, bonus, allowance, overtime_pay, deduction, insurance, tax, actual_salary, status, remark) VALUES
(1, '2026-03', 35000.00, 5000.00, 3000.00, 0.00, 0.00, 3500.00, 4200.00, 35300.00, 1, '3月工资'),
(2, '2026-03', 22000.00, 3000.00, 2000.00, 0.00, 0.00, 2200.00, 2100.00, 22700.00, 1, '3月工资'),
(3, '2026-03', 30000.00, 8000.00, 2500.00, 2000.00, 0.00, 3000.00, 4500.00, 35000.00, 1, '3月工资'),
(4, '2026-03', 18000.00, 5000.00, 2000.00, 0.00, 0.00, 1800.00, 1800.00, 21400.00, 1, '3月工资'),
(5, '2026-03', 16000.00, 2000.00, 1500.00, 0.00, 0.00, 1600.00, 1200.00, 16700.00, 1, '3月工资'),
(6, '2026-03', 14000.00, 1500.00, 1500.00, 0.00, 0.00, 1400.00, 900.00, 14700.00, 1, '3月工资'),
(7, '2026-03', 22000.00, 4000.00, 2000.00, 1500.00, 0.00, 2200.00, 2500.00, 24800.00, 1, '3月工资'),
(8, '2026-03', 8000.00, 500.00, 1000.00, 0.00, 0.00, 800.00, 200.00, 8500.00, 1, '3月工资-试用期'),
(9, '2026-03', 14000.00, 2000.00, 1500.00, 800.00, 0.00, 1400.00, 1100.00, 15800.00, 1, '3月工资'),
(10, '2026-03', 9000.00, 1000.00, 1000.00, 0.00, 200.00, 900.00, 300.00, 9600.00, 1, '3月工资'),
(11, '2026-03', 10000.00, 1000.00, 1000.00, 500.00, 0.00, 1000.00, 500.00, 11000.00, 1, '3月工资'),
(12, '2026-03', 9000.00, 800.00, 1000.00, 0.00, 0.00, 900.00, 300.00, 9600.00, 1, '3月工资'),
(1, '2026-04', 35000.00, 6000.00, 3000.00, 0.00, 0.00, 3500.00, 4500.00, 36000.00, 0, '4月工资-待发放'),
(2, '2026-04', 22000.00, 3500.00, 2000.00, 0.00, 0.00, 2200.00, 2200.00, 23100.00, 0, '4月工资-待发放'),
(3, '2026-04', 30000.00, 10000.00, 2500.00, 3000.00, 0.00, 3000.00, 5200.00, 37300.00, 0, '4月工资-待发放'),
(4, '2026-04', 18000.00, 4000.00, 2000.00, 0.00, 0.00, 1800.00, 1700.00, 20500.00, 0, '4月工资-待发放'),
(5, '2026-04', 16000.00, 2500.00, 1500.00, 0.00, 0.00, 1600.00, 1300.00, 17100.00, 0, '4月工资-待发放'),
(7, '2026-04', 22000.00, 5000.00, 2000.00, 2000.00, 0.00, 2200.00, 2800.00, 26000.00, 0, '4月工资-待发放'),
(9, '2026-04', 14000.00, 1500.00, 1500.00, 600.00, 0.00, 1400.00, 1000.00, 15200.00, 0, '4月工资-待发放');

-- ============================================
-- 请假数据
-- ============================================
INSERT INTO leave_request (emp_id, type, start_date, end_date, days, reason, status, approver_id, approve_time, approve_remark, create_time) VALUES
(8, 2, '2026-04-10', '2026-04-11', 2.0, '感冒发烧，需要休息', 1, 1, '2026-04-09 16:30:00', '注意休息，早日康复', '2026-04-09 14:00:00'),
(7, 1, '2026-04-14', '2026-04-14', 1.0, '家中有事需要处理', 1, 1, '2026-04-10 09:00:00', '同意', '2026-04-09 17:00:00'),
(10, 3, '2026-04-21', '2026-04-25', 5.0, '年假出游', 0, NULL, NULL, NULL, '2026-04-08 10:00:00'),
(6, 1, '2026-04-09', '2026-04-09', 1.0, '个人事务', 1, 1, '2026-04-08 17:00:00', '同意', '2026-04-08 14:00:00'),
(3, 4, '2026-05-01', '2026-05-07', 7.0, '婚假', 0, NULL, NULL, NULL, '2026-04-10 08:30:00'),
(11, 2, '2026-04-11', '2026-04-11', 1.0, '身体不适需就医', 0, NULL, NULL, NULL, '2026-04-10 09:30:00'),
(9, 1, '2026-04-09', '2026-04-09', 0.5, '下午请假办事', 1, 1, '2026-04-09 08:30:00', '同意，注意安排工作交接', '2026-04-08 17:30:00'),
(14, 3, '2026-04-28', '2026-04-30', 3.0, '年假休息', 0, NULL, NULL, NULL, '2026-04-10 11:00:00'),
(2, 1, '2026-03-20', '2026-03-20', 1.0, '处理个人事务', 2, 1, '2026-03-19 17:00:00', '当天工作较多，建议改期', '2026-03-19 15:00:00'),
(5, 2, '2026-03-15', '2026-03-16', 2.0, '牙疼需看牙医', 1, 1, '2026-03-14 16:00:00', '同意', '2026-03-14 10:00:00');

-- ============================================
-- 招聘数据
-- ============================================
INSERT INTO recruitment (title, dept_id, position_name, head_count, education, experience, salary_range, description, requirement, status, publisher, publish_date, deadline) VALUES
('高级Java开发工程师', 3, '高级工程师', 2, '本科', '3-5年', '15K-30K',
 '负责公司核心业务系统的设计与开发，参与技术架构决策。',
 '1. 本科及以上学历，计算机相关专业\n2. 3年以上Java开发经验\n3. 熟悉Spring、MyBatis等主流框架\n4. 熟悉MySQL数据库\n5. 有良好的编码习惯和团队协作能力',
 1, '王强', '2026-03-15', '2026-05-15'),
('前端开发工程师', 3, '中级工程师', 1, '本科', '2-3年', '10K-20K',
 '负责公司Web前端页面的开发与维护。',
 '1. 本科及以上学历\n2. 2年以上前端开发经验\n3. 精通HTML/CSS/JavaScript\n4. 熟悉Vue或React框架\n5. 有移动端开发经验优先',
 1, '王强', '2026-03-20', '2026-05-20'),
('HR招聘专员', 2, 'HR专员', 1, '本科', '1-3年', '6K-12K',
 '负责公司招聘工作，包括简历筛选、面试安排、入职办理等。',
 '1. 本科及以上学历，人力资源或相关专业\n2. 1年以上招聘经验\n3. 熟悉招聘流程和各类招聘渠道\n4. 良好的沟通能力和服务意识',
 1, '李娜', '2026-04-01', '2026-06-01'),
('市场策划经理', 4, '市场经理', 1, '本科', '5年以上', '12K-25K',
 '负责公司品牌推广策划，制定市场营销方案并推动执行。',
 '1. 本科及以上学历，市场营销或相关专业\n2. 5年以上市场策划经验\n3. 有成功的品牌推广案例\n4. 优秀的策划能力和执行力',
 1, '赵敏', '2026-04-05', '2026-06-30'),
('财务实习生', 5, '会计', 2, '本科', '应届毕业生', '4K-6K',
 '协助财务部门日常账务处理和报表编制。',
 '1. 本科在读或应届毕业生\n2. 会计、财务管理相关专业\n3. 熟悉基本会计准则\n4. 熟练使用Excel',
 2, '钱进', '2026-02-01', '2026-04-30'),
('运维工程师', 3, '中级工程师', 1, '本科', '2-4年', '12K-22K',
 '负责公司服务器和网络的日常运维管理。',
 '1. 本科及以上学历\n2. 2年以上运维经验\n3. 熟悉Linux操作系统\n4. 熟悉Docker、K8s等容器技术\n5. 有AWS/阿里云使用经验优先',
 3, '王强', '2025-12-01', '2026-02-28');

-- ============================================
-- 培训数据
-- ============================================
INSERT INTO training (title, type, trainer, dept_id, start_date, end_date, location, content, max_count, current_count, status) VALUES
('新员工入职培训', 1, '李娜', NULL, '2026-04-15', '2026-04-16', '三楼会议室A',
 '1. 公司介绍与企业文化\n2. 规章制度与员工手册\n3. 各部门介绍\n4. IT系统使用培训\n5. 安全与消防知识',
 30, 5, 1),
('Java高级开发技术培训', 1, '王强', 3, '2026-04-20', '2026-04-22', '技术部培训室',
 '1. 设计模式实战\n2. JVM性能调优\n3. 微服务架构设计\n4. 数据库性能优化\n5. 代码审查最佳实践',
 15, 8, 1),
('项目管理PMP认证培训', 2, '外部讲师-陈教授', NULL, '2026-05-10', '2026-05-14', '外部培训中心',
 '1. 项目管理基础知识\n2. 项目范围管理\n3. 项目进度管理\n4. 项目成本管理\n5. 项目风险管理\n6. PMP考试技巧',
 20, 12, 1),
('Excel数据分析技巧', 3, '钱进', NULL, '2026-04-08', '2026-04-08', '线上-腾讯会议',
 '1. 数据透视表高级用法\n2. VLOOKUP与INDEX-MATCH\n3. 条件格式与数据验证\n4. 常用图表制作\n5. 宏与VBA基础',
 50, 35, 3),
('职场沟通与表达技巧', 1, '外部讲师-张老师', NULL, '2026-03-25', '2026-03-25', '五楼报告厅',
 '1. 高效沟通的原则\n2. 职场汇报技巧\n3. 跨部门协作沟通\n4. 冲突处理与协商\n5. 演讲与表达训练',
 40, 38, 3),
('信息安全意识培训', 3, '技术部安全组', NULL, '2026-04-25', '2026-04-25', '线上-钉钉直播',
 '1. 信息安全概述\n2. 密码安全策略\n3. 钓鱼邮件识别\n4. 数据保护与隐私\n5. 安全事件上报流程',
 100, 15, 1),
('领导力发展计划', 2, '外部顾问-王教授', NULL, '2026-05-20', '2026-05-22', '外部酒店会议室',
 '1. 领导力模型\n2. 团队建设与激励\n3. 目标管理与绩效\n4. 变革管理\n5. 教练式领导',
 10, 3, 1);

-- ============================================
-- 系统日志数据
-- ============================================
INSERT INTO system_log (user_id, username, operation, module, ip, create_time) VALUES
(1, 'admin', '用户登录', '系统', '127.0.0.1', '2026-04-10 08:30:00'),
(1, 'admin', '查看仪表盘', '系统', '127.0.0.1', '2026-04-10 08:30:15'),
(1, 'admin', '查看员工列表', '员工', '127.0.0.1', '2026-04-10 08:31:00'),
(1, 'admin', '新增员工：罗斌', '员工', '127.0.0.1', '2026-04-10 08:35:00'),
(1, 'admin', '编辑员工：吴芳', '员工', '127.0.0.1', '2026-04-10 08:40:00'),
(1, 'admin', '查看部门列表', '部门', '127.0.0.1', '2026-04-10 08:45:00'),
(1, 'admin', '查看考勤列表', '考勤', '127.0.0.1', '2026-04-10 09:00:00'),
(1, 'admin', '审批请假：同意周杰的请假申请', '考勤', '127.0.0.1', '2026-04-10 09:05:00'),
(1, 'admin', '查看薪资列表', '薪资', '127.0.0.1', '2026-04-10 09:10:00'),
(2, 'zhangsan', '用户登录', '系统', '192.168.1.100', '2026-04-10 09:15:00'),
(2, 'zhangsan', '查看仪表盘', '系统', '192.168.1.100', '2026-04-10 09:15:10'),
(1, 'admin', '发布招聘：高级Java开发工程师', '招聘', '127.0.0.1', '2026-04-10 09:20:00'),
(1, 'admin', '新增培训：新员工入职培训', '培训', '127.0.0.1', '2026-04-10 09:30:00'),
(1, 'admin', '查看系统日志', '系统', '127.0.0.1', '2026-04-10 09:45:00'),
(1, 'admin', '用户退出', '系统', '127.0.0.1', '2026-04-10 12:00:00'),
(1, 'admin', '用户登录', '系统', '127.0.0.1', '2026-04-10 13:30:00'),
(1, 'admin', '编辑招聘：前端开发工程师', '招聘', '127.0.0.1', '2026-04-10 14:00:00'),
(1, 'admin', '查看培训详情', '培训', '127.0.0.1', '2026-04-10 14:30:00'),
(1, 'admin', '修改个人信息', '系统', '127.0.0.1', '2026-04-10 15:00:00'),
(1, 'admin', '查看用户列表', '系统', '127.0.0.1', '2026-04-10 15:30:00'),
(1, 'admin', '重置用户密码：zhangsan', '系统', '127.0.0.1', '2026-04-09 10:00:00'),
(1, 'admin', '用户登录', '系统', '127.0.0.1', '2026-04-09 08:25:00'),
(1, 'admin', '新增薪资记录', '薪资', '127.0.0.1', '2026-04-09 09:00:00'),
(1, 'admin', '编辑部门：技术研发部', '部门', '127.0.0.1', '2026-04-09 09:30:00'),
(1, 'admin', '删除考勤记录', '考勤', '127.0.0.1', '2026-04-09 10:30:00'),
(2, 'zhangsan', '用户登录', '系统', '192.168.1.100', '2026-04-09 09:00:00'),
(2, 'zhangsan', '查看员工详情', '员工', '192.168.1.100', '2026-04-09 09:10:00'),
(1, 'admin', '用户退出', '系统', '127.0.0.1', '2026-04-09 18:00:00'),
(1, 'admin', '用户登录', '系统', '127.0.0.1', '2026-04-08 08:30:00'),
(1, 'admin', '批量录入考勤', '考勤', '127.0.0.1', '2026-04-08 08:45:00');
