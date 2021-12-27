package com.caffeineshawn.db_backend.mapper;


import com.caffeineshawn.db_backend.entity.QueryInfo;
import com.caffeineshawn.db_backend.entity.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {

    User findUserById(int user_id);

    List<User> findAllUser(QueryInfo queryInfo);

    List<User> findUsers();

    int findAllUserCount(String information);

    User findUserByNameAndPhone(User user);

    int addUser(User user);

    int updateUser(User user);

    int deleteUser(int user_id);

    int login(User user);

    List<Integer> findUserByName(String user_name);

    String confirmPassword(Integer user_id);
}
