package com.caffeineshawn.db_backend.service;

import com.caffeineshawn.db_backend.entity.Order;
import com.caffeineshawn.db_backend.entity.QueryInfo;
import com.caffeineshawn.db_backend.entity.Track;
import com.caffeineshawn.db_backend.mapper.OrderMapper;
import com.caffeineshawn.db_backend.mapper.TrackMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Service
public class OrderService {
    @Resource
    OrderMapper orderMapper;
    @Resource
    TrackMapper trackMapper;


    public int addOrder(Order order){
        return orderMapper.addOrder(order);
    }

    public List<HashMap> findAllOrder(QueryInfo queryInfo){
        queryInfo.setPage((queryInfo.getPage() - 1) * queryInfo.getSize());
        return orderMapper.findAllOrder(queryInfo);
    }

    public List<Order> findOrders(){
        return orderMapper.findOrders();
    }

    public List<Track> findOrderTrack(int order_id){
        return trackMapper.findOrderTrack(order_id);
    }
}
