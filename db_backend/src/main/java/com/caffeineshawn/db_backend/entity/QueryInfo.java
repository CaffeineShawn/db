package com.caffeineshawn.db_backend.entity;

public class QueryInfo {
    private String information;
    private int page;
    private int size;

    public String getInformation() {
        return information;
    }

    public void setInformation(String information) {
        this.information = information;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    @Override
    public String toString() {
        return "QueryInfo{" +
                "information='" + information + '\'' +
                ", page=" + page +
                ", size=" + size +
                '}';
    }
}
