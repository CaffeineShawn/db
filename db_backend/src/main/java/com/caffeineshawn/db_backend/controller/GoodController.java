package com.caffeineshawn.db_backend.controller;

import com.alibaba.fastjson.JSON;
import com.caffeineshawn.db_backend.entity.Good;
import com.caffeineshawn.db_backend.service.GoodService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;

@RestController
@RequestMapping("/good")
public class GoodController {
    @Resource
    GoodService goodService;

    @GetMapping("/findGoodById/{order_id}")
    public String findGoodById(@PathVariable int order_id){
        Good good = goodService.findGoodById(order_id);
        HashMap<String, Object> map = new HashMap<>();
        map.put("res", good);
        return JSON.toJSONString(map);
    }
}
