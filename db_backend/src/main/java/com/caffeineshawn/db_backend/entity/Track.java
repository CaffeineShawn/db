package com.caffeineshawn.db_backend.entity;

import com.alibaba.excel.annotation.ExcelProperty;
import com.caffeineshawn.db_backend.converter.TimestampConverter;

import java.sql.Timestamp;

public class Track {
    @ExcelProperty("订单号")
    private int order_id;
    @ExcelProperty("地点")
    private String current_location;
    @ExcelProperty(value = "时间", converter = TimestampConverter.class)
    private java.sql.Timestamp current_time;

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public String getCurrent_location() {
        return current_location;
    }

    public void setCurrent_location(String current_location) {
        this.current_location = current_location;
    }

    public Timestamp getCurrent_time() {
        return current_time;
    }

    public void setCurrent_time(Timestamp current_time) {
        this.current_time = current_time;
    }

    @Override
    public String toString() {
        return "Track{" +
                "order_id=" + order_id +
                ", current_location='" + current_location + '\'' +
                ", current_time=" + current_time +
                '}';
    }
}
