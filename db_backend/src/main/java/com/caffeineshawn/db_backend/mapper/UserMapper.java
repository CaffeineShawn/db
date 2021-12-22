package com.caffeineshawn.db_backend.mapper;


import com.caffeineshawn.db_backend.entity.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {

    User findUserById(int user_id);
}
