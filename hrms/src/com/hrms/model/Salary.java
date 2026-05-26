package com.hrms.model;

import java.util.Date;

public class Salary {
    private int id;
    private int empId;
    private String month;
    private double baseSalary;
    private double bonus;
    private double allowance;
    private double overtimePay;
    private double deduction;
    private double insurance;
    private double tax;
    private double actualSalary;
    private int status;
    private String remark;
    private Date createTime;
    private String empName;
    private String empNo;
    private String deptName;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }
    public String getMonth() { return month; }
    public void setMonth(String month) { this.month = month; }
    public double getBaseSalary() { return baseSalary; }
    public void setBaseSalary(double baseSalary) { this.baseSalary = baseSalary; }
    public double getBonus() { return bonus; }
    public void setBonus(double bonus) { this.bonus = bonus; }
    public double getAllowance() { return allowance; }
    public void setAllowance(double allowance) { this.allowance = allowance; }
    public double getOvertimePay() { return overtimePay; }
    public void setOvertimePay(double overtimePay) { this.overtimePay = overtimePay; }
    public double getDeduction() { return deduction; }
    public void setDeduction(double deduction) { this.deduction = deduction; }
    public double getInsurance() { return insurance; }
    public void setInsurance(double insurance) { this.insurance = insurance; }
    public double getTax() { return tax; }
    public void setTax(double tax) { this.tax = tax; }
    public double getActualSalary() { return actualSalary; }
    public void setActualSalary(double actualSalary) { this.actualSalary = actualSalary; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public String getEmpName() { return empName; }
    public void setEmpName(String empName) { this.empName = empName; }
    public String getEmpNo() { return empNo; }
    public void setEmpNo(String empNo) { this.empNo = empNo; }
    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }
}
