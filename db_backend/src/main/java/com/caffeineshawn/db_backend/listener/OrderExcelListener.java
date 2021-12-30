package com.caffeineshawn.db_backend.listener;

import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.caffeineshawn.db_backend.entity.Good;
import com.caffeineshawn.db_backend.entity.Order;
import com.caffeineshawn.db_backend.entity.OrderInfoExcel;
import com.caffeineshawn.db_backend.entity.User;

import java.util.ArrayList;
import java.util.List;

public class OrderExcelListener extends AnalysisEventListener<OrderInfoExcel> {

    private List<Order> orderList = new ArrayList<>();
    private List<User> consignorList = new ArrayList<>();
    private List<User> consigneeList = new ArrayList<>();
    private List<Good> goodList = new ArrayList<>();

    void transForm(OrderInfoExcel orderInfo, String type){
        if(type == "order") {
            Order order = new Order();
            order.setOrder_id(orderInfo.getOrder_id());
            order.setOrder_destination(orderInfo.getOrder_destination());
            order.setOrder_origin(orderInfo.getOrder_origin());
            this.orderList.add(order);
        } else if(type == "consignor"){
            User user = new User();
            user.setUser_name(orderInfo.getConsignor());
            user.setUser_phone(orderInfo.getConsignor_phone());
            this.consignorList.add(user);
        } else if (type == "consignee"){
            User user = new User();
            user.setUser_name(orderInfo.getConsignee());
            user.setUser_phone(orderInfo.getConsignee_phone());
            this.consigneeList.add(user);
        } else {
            Good good = new Good();
            good.setGood_weight(orderInfo.getGood_weight());
            good.setGood_name(orderInfo.getGood_name());
            good.setGood_price(orderInfo.getGood_price());
            this.goodList.add(good);
        }
    }

    @Override
    public void invoke(OrderInfoExcel orderInfoExcel, AnalysisContext analysisContext) {
        transForm(orderInfoExcel, "order");
        transForm(orderInfoExcel, "consignor");
        transForm(orderInfoExcel, "consignee");
        transForm(orderInfoExcel, "good");
    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext analysisContext) {
        System.out.println("接收完成");
    }

    public List<Order> getOrderList() {
        return orderList;
    }

    public void setOrderList(List<Order> orderList) {
        this.orderList = orderList;
    }

    public List<User> getConsignorList() {
        return consignorList;
    }

    public void setConsignorList(List<User> consignorList) {
        this.consignorList = consignorList;
    }

    public List<User> getConsigneeList() {
        return consigneeList;
    }

    public void setConsigneeList(List<User> consigneeList) {
        this.consigneeList = consigneeList;
    }

    public List<Good> getGoodList() {
        return goodList;
    }

    public void setGoodList(List<Good> goodList) {
        this.goodList = goodList;
    }

    @Override
    public String toString() {
        return "OrderExcelListener{" +
                "orderList=" + orderList +
                ", consignorList=" + consignorList +
                ", consigneeList=" + consigneeList +
                ", goodList=" + goodList +
                '}';
    }
}
