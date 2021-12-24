package com.caffeineshawn.db_backend.entity;

import java.sql.Timestamp;

public class Track {
    private int order_id;
    private String current_location;
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
