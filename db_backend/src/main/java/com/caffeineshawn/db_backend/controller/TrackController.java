package com.caffeineshawn.db_backend.controller;

import com.alibaba.fastjson.JSON;
import com.caffeineshawn.db_backend.entity.Order;
import com.caffeineshawn.db_backend.entity.QueryInfo;
import com.caffeineshawn.db_backend.entity.Track;
import com.caffeineshawn.db_backend.service.TrackService;
import org.springframework.web.bind.annotation.*;
import java.sql.Timestamp;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/track")
public class TrackController {
    @Resource
    TrackService trackService;

    @PostMapping("/addTrack")
    public String addTrack(@RequestBody Track track){
        Timestamp timestamp = new Timestamp(new Date().getTime());
        track.setCurrent_time(timestamp);
        if(trackService.addTrack(track)==1)
            return "true";
        else return "false";
    }

    @GetMapping("/findTrack")
    public String findTrack(@RequestBody Track track){
        return JSON.toJSONString(trackService.findTrack(track));
    }

    @PutMapping("/updateTrack")
    public String updateTrack(@RequestBody Track track){
        Timestamp timestamp = new Timestamp(new Date().getTime());
        track.setCurrent_time(timestamp);
        if(trackService.updateTrack(track)==1)
            return "true";
        else return "false";
    }

    @DeleteMapping("/deleteTrack/{order_id}")
    public String deleteTrack(@PathVariable int order_id) {
        if(trackService.deleteTrack(order_id)==1)
            return "true";
        else return "false";
    }


}
