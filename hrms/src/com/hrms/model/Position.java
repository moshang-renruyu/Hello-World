package com.hrms.model;

import java.util.Date;

public class Position {
    private int id;
    private String name;
    private String code;
    private int deptId;
    private int level;
    private double salaryMin;
    private double salaryMax;
    private String description;
    private int status;
    private Date createTime;
    private String deptName;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public int getDeptId() { return deptId; }
    public void setDeptId(int deptId) { this.deptId = deptId; }
    public int getLevel() { return level; }
    public void setLevel(int level) { this.level = level; }
    public double getSalaryMin() { return salaryMin; }
    public void setSalaryMin(double salaryMin) { this.salaryMin = salaryMin; }
    public double getSalaryMax() { return salaryMax; }
    public void setSalaryMax(double salaryMax) { this.salaryMax = salaryMax; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }
}
