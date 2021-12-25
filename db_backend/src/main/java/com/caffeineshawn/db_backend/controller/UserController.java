package com.caffeineshawn.db_backend.controller;

import com.alibaba.fastjson.JSON;
import com.caffeineshawn.db_backend.entity.QueryInfo;
import com.caffeineshawn.db_backend.entity.User;
import com.caffeineshawn.db_backend.service.UserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {
    @Resource
    UserService userService;

    @PostMapping("/findAllUser")
    public String findAllUser(@RequestBody QueryInfo queryInfo){
        List<User> uList = userService.findAllUser(queryInfo);
        int count = userService.findAllUserCount(queryInfo);
        HashMap<String, Object> map = new HashMap<>();
        map.put("res", uList);
        map.put("total", count);
        return JSON.toJSONString(map);
    }

    @GetMapping("/findUsers")
    public String findUsers() {
        List<User> users = userService.findUsers();
        return JSON.toJSONString(users);
    }
}
