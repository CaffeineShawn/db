package com.caffeineshawn.db_backend.entity;

public class Order {
    private int consignor_id;
    private int consignee_id;
    private int order_id;
    private String order_origin;
    private String order_destination;
    private String order_state;

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

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public String getOrder_origin() {
        return order_origin;
    }

    public void setOrder_origin(String order_origin) {
        this.order_origin = order_origin;
    }

    public String getOrder_destination() {
        return order_destination;
    }

    public void setOrder_destination(String order_destination) {
        this.order_destination = order_destination;
    }

    public String getOrder_state() {
        return order_state;
    }

    public void setOrder_state(String order_state) {
        this.order_state = order_state;
    }

    @Override
    public String toString() {
        return "Order{" +
                "consignor_id=" + consignor_id +
                ", consignee_id=" + consignee_id +
                ", order_id=" + order_id +
                ", order_origin='" + order_origin + '\'' +
                ", order_destination='" + order_destination + '\'' +
                ", order_state='" + order_state + '\'' +
                '}';
    }
}

