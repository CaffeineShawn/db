package com.caffeineshawn.db_backend.entity;

public class Good {
    private int good_id;
    private String good_name;
    private float good_weight;
    private String good_state;
    private String destination;
    private String origin;

    public int getGood_id() {
        return good_id;
    }

    public void setGood_id(int good_id) {
        this.good_id = good_id;
    }

    public String getGood_name() {
        return good_name;
    }

    public void setGood_name(String good_name) {
        this.good_name = good_name;
    }

    public float getGood_weight() {
        return good_weight;
    }

    public void setGood_weight(float good_weight) {
        this.good_weight = good_weight;
    }

    public String getGood_state() {
        return good_state;
    }

    public void setGood_state(String good_state) {
        this.good_state = good_state;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    @Override
    public String toString() {
        return "Good{" +
                "good_id=" + good_id +
                ", good_name='" + good_name + '\'' +
                ", good_weight=" + good_weight +
                ", good_state='" + good_state + '\'' +
                ", destination='" + destination + '\'' +
                ", origin='" + origin + '\'' +
                '}';
    }
}
