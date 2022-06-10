package com.caffeineshawn.db_backend.service;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.write.metadata.WriteSheet;
import com.caffeineshawn.db_backend.entity.*;
import com.caffeineshawn.db_backend.mapper.GoodMapper;
import com.caffeineshawn.db_backend.mapper.OrderMapper;
import com.caffeineshawn.db_backend.mapper.TrackMapper;
import com.caffeineshawn.db_backend.mapper.UserMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Service
public class OrderService {
    @Resource
    OrderMapper orderMapper;
    @Resource
    TrackMapper trackMapper;
    @Resource
    GoodMapper goodMapper;
    @Resource
    UserMapper userMapper;

    public int addOrder(Order order){
        return orderMapper.addOrder(order);
    }

    public List<OrderInfoExcel> findAllOrder(QueryInfo queryInfo){
        queryInfo.setPage((queryInfo.getPage() - 1) * queryInfo.getSize());
        System.out.println(queryInfo);
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

    @Transactional
    public int deleteOrderById(int order_id){
        if(orderMapper.deleteOrderById(order_id) == 1)
            return 1;
        return 0;
    }

    @Transactional
    public int addOrder(User consignor, User consignee, Good good, Order order){
        User user = userMapper.findUserByNameAndPhone(consignor);
        if(user == null){
            userMapper.addUser(consignor);
        }
        else{
            consignor = user;
        }
        user = userMapper.findUserByNameAndPhone(consignee);
        if(user == null){
            userMapper.addUser(consignee);
        }
        else {
            consignee = user;
        }
        Good existingGood = goodMapper.findGoodByGoodInfo(good);
        if(existingGood == null){
            goodMapper.addGood(good);
        }
        else {
            good = existingGood;
        }
        order.setConsignee_id(consignee.getUser_id());
        order.setConsignor_id(consignor.getUser_id());
        Track track = new Track();
        track.setCurrent_location(order.getOrder_origin());
        track.setCurrent_time(new Timestamp(new Date().getTime()));
        if(orderMapper.addOrder(order) == 1 && orderMapper.addOrderGood(order.getOrder_id(), good.getGood_id()) == 1){
            track.setOrder_id(order.getOrder_id());
            if(trackMapper.addTrack(track) == 1)
                return 1;
        }
        return 0;
    }

    public Order findOrderById(int order_id){
        return orderMapper.findOrderById(order_id);
    }

    @Transactional
    public int updateOrderInfo(Order order){
        return orderMapper.updateOrderInfo(order);
    }

    public void exportOrder(HttpServletResponse response){
        try {
            //设置返回的数据格式
            response.setContentType("application/vnd.ms-excel");
            //设置返回的数据编码
            response.setCharacterEncoding("utf-8");
            // 这里URLEncoder.encode可以防止中文乱码 当然和easyexcel没有关系
            String fileName = URLEncoder.encode("订单数据", "UTF-8");
            response.setHeader("Content-disposition", "attachment;filename="+ fileName + ".xlsx");
            QueryInfo queryInfo = new QueryInfo();
            List<OrderInfoExcel> orderRes = orderMapper.findAllOrder(queryInfo);
            List<Track> orderTrackRes = trackMapper.findAllTrack();

            ExcelWriter excelWriter = EasyExcel.write(response.getOutputStream()).build();
            WriteSheet mainSheet = EasyExcel.writerSheet(0, "订单数据").head(OrderInfoExcel.class).build();
            excelWriter.write(orderRes, mainSheet);

            WriteSheet trackSheet = EasyExcel.writerSheet(1, "订单物流数据").head(Track.class).build();
            excelWriter.write(orderTrackRes, trackSheet);
//            EasyExcel.write(response.getOutputStream(),OrderInfoExcel.class).sheet("订单物流数据")
//                    .doWrite(orderRes);
            excelWriter.finish();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
