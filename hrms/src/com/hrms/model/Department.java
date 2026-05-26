package com.hrms.model;

import java.util.Date;

public class Department {
    private int id;
    private String name;
    private String code;
    private String manager;
    private String phone;
    private String description;
    private int parentId;
    private int sortOrder;
    private int status;
    private Date createTime;
    private int empCount;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public String getManager() { return manager; }
    public void setManager(String manager) { this.manager = manager; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public int getParentId() { return parentId; }
    public void setParentId(int parentId) { this.parentId = parentId; }
    public int getSortOrder() { return sortOrder; }
    public void setSortOrder(int sortOrder) { this.sortOrder = sortOrder; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public int getEmpCount() { return empCount; }
    public void setEmpCount(int empCount) { this.empCount = empCount; }
}
