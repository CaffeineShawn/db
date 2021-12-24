package com.caffeineshawn.db_backend.controller;

import com.alibaba.fastjson.JSON;
import com.caffeineshawn.db_backend.entity.Order;
import com.caffeineshawn.db_backend.entity.QueryInfo;
import com.caffeineshawn.db_backend.entity.Track;
import com.caffeineshawn.db_backend.service.OrderService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/order")
public class OrderController {
    @Resource
    OrderService orderService;

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
        System.out.println(order_id);
        List<Track> tList = orderService.findOrderTrack(order_id);
        HashMap<String, Object> map = new HashMap<>();
        map.put("res", tList);
        return JSON.toJSONString(map);
    }
}
