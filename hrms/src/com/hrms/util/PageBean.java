package com.hrms.util;

import java.util.List;

public class PageBean<T> {

    private int pageNum;
    private int pageSize;
    private int totalCount;
    private int totalPage;
    private List<T> list;

    public PageBean() {
        this.pageSize = 10;
    }

    public PageBean(int pageNum, int pageSize) {
        this.pageNum = pageNum;
        this.pageSize = pageSize;
    }

    public int getPageNum() { return pageNum; }
    public void setPageNum(int pageNum) { this.pageNum = pageNum; }

    public int getPageSize() { return pageSize; }
    public void setPageSize(int pageSize) { this.pageSize = pageSize; }

    public int getTotalCount() { return totalCount; }
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        this.totalPage = (totalCount + pageSize - 1) / pageSize;
    }

    public int getTotalPage() { return totalPage; }
    public void setTotalPage(int totalPage) { this.totalPage = totalPage; }

    public List<T> getList() { return list; }
    public void setList(List<T> list) { this.list = list; }

    public int getStartIndex() {
        return (pageNum - 1) * pageSize;
    }

    public boolean hasPrev() { return pageNum > 1; }
    public boolean hasNext() { return pageNum < totalPage; }
    public int getPrevPage() { return pageNum - 1; }
    public int getNextPage() { return pageNum + 1; }
}
