package com.caffeineshawn.db_backend.entity;

public class Track {
    private int good_id;
    private String current_location;
    private String current_time;

    public int getGood_id() {
        return good_id;
    }

    public void setGood_id(int good_id) {
        this.good_id = good_id;
    }

    public String getCurrent_location() {
        return current_location;
    }

    public void setCurrent_location(String current_location) {
        this.current_location = current_location;
    }

    public String getCurrent_time() {
        return current_time;
    }

    public void setCurrent_time(String current_time) {
        this.current_time = current_time;
    }

    @Override
    public String toString() {
        return "Track{" +
                "good_id=" + good_id +
                ", current_location='" + current_location + '\'' +
                ", current_time='" + current_time + '\'' +
                '}';
    }
}
