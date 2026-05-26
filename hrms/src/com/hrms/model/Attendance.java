package com.hrms.model;

import java.util.Date;

public class Attendance {
    private int id;
    private int empId;
    private Date workDate;
    private String checkIn;
    private String checkOut;
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
    public Date getWorkDate() { return workDate; }
    public void setWorkDate(Date workDate) { this.workDate = workDate; }
    public String getCheckIn() { return checkIn; }
    public void setCheckIn(String checkIn) { this.checkIn = checkIn; }
    public String getCheckOut() { return checkOut; }
    public void setCheckOut(String checkOut) { this.checkOut = checkOut; }
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
