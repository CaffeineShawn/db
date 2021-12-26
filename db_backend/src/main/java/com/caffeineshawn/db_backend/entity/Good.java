package com.caffeineshawn.db_backend.entity;

public class Good {
    private int good_id;
    private String good_name;
    private double good_weight;
    private double good_price;


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

    public double getGood_weight() {
        return good_weight;
    }

    public void setGood_weight(double good_weight) {
        this.good_weight = good_weight;
    }

    public double getGood_price() {
        return good_price;
    }

    public void setGood_price(double good_price) {
        this.good_price = good_price;
    }


    @Override
    public String toString() {
        return "Good{" +
                "good_id=" + good_id +
                ", good_name='" + good_name + '\'' +
                ", good_weight=" + good_weight +
                ", good_price=" + good_price +
                '}';
    }
}
