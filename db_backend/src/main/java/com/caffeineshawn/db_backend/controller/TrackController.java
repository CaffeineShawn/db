package com.caffeineshawn.db_backend.controller;

import com.alibaba.fastjson.JSON;
import com.caffeineshawn.db_backend.entity.Track;
import com.caffeineshawn.db_backend.service.TrackService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;

@RestController
@RequestMapping("/track")
public class TrackController {
    @Resource
    TrackService trackService;

    @PostMapping("/addTrack")
    public String addTrack(@RequestBody Track track){
        if(trackService.findTrack(track) != null)
            return "existing";
        return trackService.addTrack(track) == 1 ? "ok" : "error";
    }

    @PostMapping("/findTrack")
    public String findTrack(@RequestBody Track track){
        return JSON.toJSONString(trackService.findTrack(track));
    }

    @PostMapping("/updateTrack")
    public String updateTrack(@RequestBody HashMap param){
        String oldTrackJson = JSON.toJSONString(param.get("oldTrackInfo"));
        String newTrackJson = JSON.toJSONString(param.get("newTrackInfo"));
        Track oldTrack = JSON.parseObject(oldTrackJson, Track.class);
        Track newTrack = JSON.parseObject(newTrackJson, Track.class);
        System.out.println(oldTrack);
        System.out.println(newTrack);
        if(trackService.updateTrack(oldTrack, newTrack) == 0)
            return "error";
        return "ok";
    }

    @DeleteMapping("/deleteSpecificTrack")
    public String deleteSpecificTrack(@RequestBody Track track){
        if(trackService.deleteSpecificTrack(track) > 0)
            return "ok";
        return "error";
    }

}
