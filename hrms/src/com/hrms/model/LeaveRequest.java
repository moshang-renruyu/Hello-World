package com.hrms.model;

import java.util.Date;

public class LeaveRequest {
    private int id;
    private int empId;
    private int type;
    private Date startDate;
    private Date endDate;
    private double days;
    private String reason;
    private String attachment;
    private int status;
    private int approverId;
    private Date approveTime;
    private String approveRemark;
    private Date createTime;
    private String empName;
    private String empNo;
    private String deptName;
    private String approverName;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }
    public int getType() { return type; }
    public void setType(int type) { this.type = type; }
    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }
    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }
    public double getDays() { return days; }
    public void setDays(double days) { this.days = days; }
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
    public String getAttachment() { return attachment; }
    public void setAttachment(String attachment) { this.attachment = attachment; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    public int getApproverId() { return approverId; }
    public void setApproverId(int approverId) { this.approverId = approverId; }
    public Date getApproveTime() { return approveTime; }
    public void setApproveTime(Date approveTime) { this.approveTime = approveTime; }
    public String getApproveRemark() { return approveRemark; }
    public void setApproveRemark(String approveRemark) { this.approveRemark = approveRemark; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public String getEmpName() { return empName; }
    public void setEmpName(String empName) { this.empName = empName; }
    public String getEmpNo() { return empNo; }
    public void setEmpNo(String empNo) { this.empNo = empNo; }
    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }
    public String getApproverName() { return approverName; }
    public void setApproverName(String approverName) { this.approverName = approverName; }
}
