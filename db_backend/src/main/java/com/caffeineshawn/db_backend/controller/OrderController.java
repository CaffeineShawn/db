package com.caffeineshawn.db_backend.controller;

import com.alibaba.fastjson.JSON;
import com.caffeineshawn.db_backend.entity.Order;
import com.caffeineshawn.db_backend.entity.QueryInfo;
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
        List<Order> oList = orderService.findAllOrder(queryInfo);
        HashMap<String, Object> map = new HashMap<>();
        map.put("res", oList);
        map.put("total", oList.size());
        return JSON.toJSONString(map);
    }

    @GetMapping("/findOrders")
    public String findOrders(){
        List<Order> orderList = orderService.findOrders();
        return JSON.toJSONString(orderList);
    }
}
