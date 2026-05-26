package com.hrms.model;

import java.util.Date;

public class Training {
    private int id;
    private String title;
    private int type;
    private String trainer;
    private int deptId;
    private Date startDate;
    private Date endDate;
    private String location;
    private String content;
    private int maxCount;
    private int currentCount;
    private int status;
    private String attachment;
    private Date createTime;
    private String deptName;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public int getType() { return type; }
    public void setType(int type) { this.type = type; }
    public String getTrainer() { return trainer; }
    public void setTrainer(String trainer) { this.trainer = trainer; }
    public int getDeptId() { return deptId; }
    public void setDeptId(int deptId) { this.deptId = deptId; }
    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }
    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public int getMaxCount() { return maxCount; }
    public void setMaxCount(int maxCount) { this.maxCount = maxCount; }
    public int getCurrentCount() { return currentCount; }
    public void setCurrentCount(int currentCount) { this.currentCount = currentCount; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    public String getAttachment() { return attachment; }
    public void setAttachment(String attachment) { this.attachment = attachment; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }
}
