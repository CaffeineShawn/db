package com.caffeineshawn.db_backend.entity;

public class Order {
    private int consignor_id;
    private int consignee_id;
    private int good_id;

    public int getConsignor_id() {
        return consignor_id;
    }

    public void setConsignor_id(int consignor_id) {
        this.consignor_id = consignor_id;
    }

    public int getConsignee_id() {
        return consignee_id;
    }

    public void setConsignee_id(int consignee_id) {
        this.consignee_id = consignee_id;
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
                "consignor_id=" + consignor_id +
                ", consignee_id=" + consignee_id +
                ", good_id=" + good_id +
                '}';
    }
}

