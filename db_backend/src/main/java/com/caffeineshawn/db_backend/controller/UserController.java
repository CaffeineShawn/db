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

    @PostMapping("/addUser")
    public String addUser(@RequestBody User user){
        return userService.addUser(user)==1 ? "true" : "false";
    }

    @PutMapping("/updateUser")
    public String updateUser(@RequestBody User user){

        System.out.println(user);
        return userService.updateUser(user)==1 ? "true" : "false";
    }

    @DeleteMapping("/deleteUser/{user_id}")
    public String deleteUser(@PathVariable int user_id){
        return userService.deleteUser(user_id)==1 ? "true" : "false";
    }

    @PostMapping("/login")
    public Integer login(@RequestBody User user){
        List<Integer> userList = userService.findUsersByName(user.getUser_name());
        if(userList.size()==1) {
            String password = userService.confirmPassword(userList.get(0));
            return password.equals(user.getUser_password()) ? userList.get(0) : -100;
        }
        else if(userList.size()==0){
            return -200;
        }
        else{
            for (int me : userList) {
                String password = userService.confirmPassword(me);
                if(password.equals(user.getUser_password()))
                    return me;
            }
        }
        return -100;
    }


}
