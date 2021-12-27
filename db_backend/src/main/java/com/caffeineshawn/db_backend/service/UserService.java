package com.caffeineshawn.db_backend.service;

import com.caffeineshawn.db_backend.entity.QueryInfo;
import com.caffeineshawn.db_backend.entity.User;
import com.caffeineshawn.db_backend.mapper.UserMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserService {
    @Resource
    UserMapper userMapper;

    public User findUserById(int user_id){
        return userMapper.findUserById(user_id);
    }

    public List<User> findAllUser(QueryInfo queryInfo){
        queryInfo.setPage((queryInfo.getPage() - 1) * queryInfo.getSize());
        return userMapper.findAllUser(queryInfo);
    }

    public List<User> findUsers() {
        return userMapper.findUsers();
    }

    public int findAllUserCount(QueryInfo queryInfo){
        return userMapper.findAllUserCount(queryInfo.getInformation());
    }

    public int addUser(User user) {return  userMapper.addUser(user);
    }

    public int updateUser(User user) {return userMapper.updateUser(user);
    }

    public int deleteUser(int user_id) {return userMapper.deleteUser(user_id);
    }

    public int login(User user) {return userMapper.login(user);
    }

    public List<Integer> findUsersByName(String user_name) {
        return userMapper.findUserByName(user_name);
    }

    public String confirmPassword(Integer user_id) {
        return userMapper.confirmPassword(user_id);
    }
}

