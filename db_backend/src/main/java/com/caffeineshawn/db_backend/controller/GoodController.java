package com.caffeineshawn.db_backend.controller;

import com.alibaba.fastjson.JSON;
import com.caffeineshawn.db_backend.entity.Good;
import com.caffeineshawn.db_backend.service.GoodService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

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


    @PostMapping("/updateGoodInfo")
    public String updateGoodInfo(@RequestBody Good good){
        if(goodService.updateGoodInfo(good) == 1)
            return "ok";
        return "error";
    }

    @PutMapping("/updateGood")
    public String updateGood(@RequestBody Good good){
        return goodService.updateGoodInfo(good) == 1 ? "ok" : "error";
    }

    @GetMapping("/getGoodAnalyseInfo")
    public String getGoodAnalyseInfo(){
        List<HashMap> lMap = goodService.getGoodAnalyseInfo();
        return JSON.toJSONString(lMap);
    }


}
