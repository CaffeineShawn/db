package com.caffeineshawn.db_backend.service;

import com.caffeineshawn.db_backend.entity.Order;
import com.caffeineshawn.db_backend.entity.QueryInfo;
import com.caffeineshawn.db_backend.entity.Track;
import com.caffeineshawn.db_backend.mapper.GoodMapper;
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
    @Resource
    GoodMapper goodMapper;


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

    public int findAllOrderCount(QueryInfo queryInfo){
        return orderMapper.findAllOrderCount(queryInfo);
    }

    public int deleteOrderById(int order_id){
        int good_id = orderMapper.findGoodIdByOrderId(order_id);
        if(orderMapper.deleteOrderById(order_id) == 1 && goodMapper.deleteGoodById(good_id) == 1)
            return 1;
        return 0;
    }
}
