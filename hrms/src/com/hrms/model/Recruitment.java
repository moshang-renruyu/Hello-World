package com.hrms.model;

import java.util.Date;

public class Recruitment {
    private int id;
    private String title;
    private int deptId;
    private String positionName;
    private int headCount;
    private String education;
    private String experience;
    private String salaryRange;
    private String description;
    private String requirement;
    private int status;
    private String publisher;
    private Date publishDate;
    private Date deadline;
    private Date createTime;
    private String deptName;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public int getDeptId() { return deptId; }
    public void setDeptId(int deptId) { this.deptId = deptId; }
    public String getPositionName() { return positionName; }
    public void setPositionName(String positionName) { this.positionName = positionName; }
    public int getHeadCount() { return headCount; }
    public void setHeadCount(int headCount) { this.headCount = headCount; }
    public String getEducation() { return education; }
    public void setEducation(String education) { this.education = education; }
    public String getExperience() { return experience; }
    public void setExperience(String experience) { this.experience = experience; }
    public String getSalaryRange() { return salaryRange; }
    public void setSalaryRange(String salaryRange) { this.salaryRange = salaryRange; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getRequirement() { return requirement; }
    public void setRequirement(String requirement) { this.requirement = requirement; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    public String getPublisher() { return publisher; }
    public void setPublisher(String publisher) { this.publisher = publisher; }
    public Date getPublishDate() { return publishDate; }
    public void setPublishDate(Date publishDate) { this.publishDate = publishDate; }
    public Date getDeadline() { return deadline; }
    public void setDeadline(Date deadline) { this.deadline = deadline; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public String getDeptName() { return deptName; }
    public void setDeptName(String deptName) { this.deptName = deptName; }
}
