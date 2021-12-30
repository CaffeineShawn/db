package com.caffeineshawn.db_backend.entity;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;

public class OrderInfoExcel {
    @ExcelProperty({"订单号"})
    private int order_id;
    @ExcelIgnore
    private int good_id;
    @ExcelProperty({"发件人"})
    private String consignor;
    @ExcelProperty({"发件人号码"})
    private String consignor_phone;
    @ExcelProperty({"收件人"})
    private String consignee;
    @ExcelProperty({"收件人号码"})
    private String consignee_phone;
    @ExcelProperty({"收货地址"})
    private String order_destination;
    @ExcelProperty({"发货地址"})
    private String order_origin;
    @ExcelProperty({"货物名"})
    private String good_name;
    @ExcelProperty({"货物重量(kg)"})
    private double good_weight;
    @ExcelProperty({"货物价格(¥)"})
    private double good_price;
    @ExcelProperty({"订单状态"})
    private String order_state;

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getGood_id() {
        return good_id;
    }

    public void setGood_id(int good_id) {
        this.good_id = good_id;
    }

    public String getConsignor() {
        return consignor;
    }

    public void setConsignor(String consignor) {
        this.consignor = consignor;
    }

    public String getConsignor_phone() {
        return consignor_phone;
    }

    public void setConsignor_phone(String consignor_phone) {
        this.consignor_phone = consignor_phone;
    }

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
    }

    public String getConsignee_phone() {
        return consignee_phone;
    }

    public void setConsignee_phone(String consignee_phone) {
        this.consignee_phone = consignee_phone;
    }

    public String getOrder_destination() {
        return order_destination;
    }

    public void setOrder_destination(String order_destination) {
        this.order_destination = order_destination;
    }

    public String getOrder_origin() {
        return order_origin;
    }

    public void setOrder_origin(String order_origin) {
        this.order_origin = order_origin;
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

    public String getOrder_state() {
        return order_state;
    }

    public void setOrder_state(String order_state) {
        this.order_state = order_state;
    }

    @Override
    public String toString() {
        return "OrderInfoExcel{" +
                "order_id=" + order_id +
                ", good_id=" + good_id +
                ", consignor='" + consignor + '\'' +
                ", consignor_phone='" + consignor_phone + '\'' +
                ", consignee='" + consignee + '\'' +
                ", consignee_phone='" + consignee_phone + '\'' +
                ", order_destination='" + order_destination + '\'' +
                ", order_origin='" + order_origin + '\'' +
                ", good_name='" + good_name + '\'' +
                ", good_weight='" + good_weight + '\'' +
                ", good_price='" + good_price + '\'' +
                ", order_state='" + order_state + '\'' +
                '}';
    }
}
