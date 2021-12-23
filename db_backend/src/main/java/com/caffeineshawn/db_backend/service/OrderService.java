package com.caffeineshawn.db_backend.service;

import com.caffeineshawn.db_backend.entity.Order;
import com.caffeineshawn.db_backend.mapper.OrderMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class OrderService {
    @Resource
    OrderMapper orderMapper;

    public int addOrder(Order order){
        return orderMapper.addOrder(order);
    }

    public List<Order> findUserOrder(int user_id){
        return orderMapper.findUserOrder(user_id);
    }
}
