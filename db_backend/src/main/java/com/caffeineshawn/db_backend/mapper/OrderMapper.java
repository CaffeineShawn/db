package com.caffeineshawn.db_backend.mapper;

import com.caffeineshawn.db_backend.entity.Order;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrderMapper {

    int addOrder(Order order);

    List<Order> findUserOrder(int user_id);
}
