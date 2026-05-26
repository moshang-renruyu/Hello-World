package com.hrms.model;

import java.util.Date;

public class SystemLog {
    private int id;
    private int userId;
    private String username;
    private String operation;
    private String module;
    private String ip;
    private Date createTime;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getOperation() { return operation; }
    public void setOperation(String operation) { this.operation = operation; }
    public String getModule() { return module; }
    public void setModule(String module) { this.module = module; }
    public String getIp() { return ip; }
    public void setIp(String ip) { this.ip = ip; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}
