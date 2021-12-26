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
        List<HashMap> oList = orderService.findAllOrder(queryInfo);
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

    @GetMapping("/findOrderById/{order_id}")
    public String findOrderById(@PathVariable int order_id){
        Order order = orderService.findOrderById(order_id);
        HashMap<String, Object> map = new HashMap<>();
        map.put("res", order);
        return JSON.toJSONString(map);
    }
}
