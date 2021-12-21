package com.caffeineshawn.db_backend.entity;

public class Order {
    private String consignor;
    private String consignee;
    private int good_id;

    public String getConsignor() {
        return consignor;
    }

    public void setConsignor(String consignor) {
        this.consignor = consignor;
    }

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
    }

    public int getGood_id() {
        return good_id;
    }

    public void setGood_id(int good_id) {
        this.good_id = good_id;
    }

    @Override
    public String toString() {
        return "Order{" +
                "consignor='" + consignor + '\'' +
                ", consignee='" + consignee + '\'' +
                ", good_id=" + good_id +
                '}';
    }
}
