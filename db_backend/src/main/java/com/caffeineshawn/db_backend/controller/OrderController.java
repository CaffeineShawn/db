package com.caffeineshawn.db_backend.controller;

import com.alibaba.fastjson.JSON;
import com.caffeineshawn.db_backend.entity.*;
import com.caffeineshawn.db_backend.service.OrderService;
import com.caffeineshawn.db_backend.service.UserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/order")
public class OrderController {
    @Resource
    OrderService orderService;
    @Resource
    UserService userService;

    @PostMapping("/findAllOrder")
    public String findAllOrder(@RequestBody QueryInfo queryInfo){
        List<OrderInfoExcel> oList = orderService.findAllOrder(queryInfo);
        int total = orderService.findAllOrderCount(queryInfo);
        HashMap<String, Object> map = new HashMap<>();
        map.put("res", oList);
        map.put("total", total);
        return JSON.toJSONString(map);
    }

    @GetMapping("/findOrders")
    public String findOrders(){
        List<Order> orderList = orderService.findOrders();
        return JSON.toJSONString(orderList);
    }

    @GetMapping("/findOrderTrack/{order_id}")
    public String findOrderTrack(@PathVariable int order_id){
        List<Track> tList = orderService.findOrderTrack(order_id);
        HashMap<String, Object> map = new HashMap<>();
        map.put("res", tList);
        return JSON.toJSONString(map);
    }
    
    @GetMapping("/findTracksByOrderId/{order_id}")
    public String findTracksByOrderId(@PathVariable int order_id){
        List<Track> tracks = orderService.findOrderTrack(order_id);
        return JSON.toJSONString(tracks);
    }

    @DeleteMapping("/deleteOrderById/{order_id}")
    public String deleteOrderById(@PathVariable int order_id){
        if(orderService.deleteOrderById(order_id) == 1)
            return "ok";
        return "error";
    }

    @PostMapping("/addOrder")
    public String addOrder(@RequestBody HashMap param){
        String consignorJson = JSON.toJSONString(param.get("consignor"));
        String consigneeJson = JSON.toJSONString(param.get("consignee"));
        String goodJson = JSON.toJSONString(param.get("goodInfo"));
        String orderJson = JSON.toJSONString(param.get("orderInfo"));
        User consignor = JSON.parseObject(consignorJson, User.class);
        User consignee = JSON.parseObject(consigneeJson, User.class);
        Good good = JSON.parseObject(goodJson, Good.class);
        Order order = JSON.parseObject(orderJson, Order.class);
        System.out.println(consignor);
        System.out.println(consignee);
        System.out.println(good);
        System.out.println(order);
        if(orderService.addOrder(consignor, consignee, good, order) == 1)
            return "ok";
        return "error";
    }

    @PostMapping("/addOrderWithTonsOfData")
    public String addOrderWithTonsOfData(@RequestBody HashMap map) {
        User consignor = new User();
        consignor.setUser_name((String) map.get("consignor"));
        consignor.setUser_phone((String) map.get("consignor_phone"));

        User consignee = new User();
        consignee.setUser_name((String) map.get("consignee"));
        consignee.setUser_phone((String) map.get("consignee_phone"));


        String jsonString = JSON.toJSONString(map);
        Good good = JSON.parseObject(jsonString, Good.class);
        Order order = JSON.parseObject(jsonString, Order.class);
        System.out.println(map.toString());
        System.out.println(consignee);
        System.out.println(consignor);

        return orderService.addOrder(consignor, consignee, good, order) == 1 ? "ok" : "error";

    }


    @GetMapping("/findOrderById/{order_id}")
    public String findOrderById(@PathVariable int order_id){
        Order order = orderService.findOrderById(order_id);
        HashMap<String, Object> map = new HashMap<>();
        map.put("res", order);
        return JSON.toJSONString(map);
    }

    @PostMapping("/updateOrderInfo")
    public String updateOrderInfo(@RequestBody Order order){
        if(orderService.updateOrderInfo(order) == 1)
            return "ok";
        return "error";
    }

    @PutMapping("/updateOrder")
    public String updateOrder(@RequestBody HashMap map) {
        Order order = orderService.findOrderById((Integer) map.get("order_id"));
        order.setOrder_origin((String) map.get("order_origin"));
        order.setOrder_state((String) map.get("order_state"));
        order.setOrder_destination((String) map.get("order_destination"));
        return orderService.updateOrderInfo(order) == 1 ? "ok" : "error";
    }
}
