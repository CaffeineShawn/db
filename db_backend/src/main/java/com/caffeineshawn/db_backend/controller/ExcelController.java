package com.caffeineshawn.db_backend.controller;


import com.alibaba.excel.EasyExcel;
import com.caffeineshawn.db_backend.entity.*;
import com.caffeineshawn.db_backend.listener.OrderExcelListener;
import com.caffeineshawn.db_backend.listener.OrderTrackExcelListener;
import com.caffeineshawn.db_backend.service.OrderService;
import com.caffeineshawn.db_backend.service.TrackService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/excel")
public class ExcelController {
    @Resource
    OrderService orderService;
    @Resource
    TrackService trackService;

    @GetMapping("/exportOrder")
    public void exportOrder(HttpServletResponse response){
        orderService.exportOrder(response);
    }

    @PostMapping("/importOrder")
    public String importOrder(MultipartFile file) throws IOException {
        InputStream orderInputStream = file.getInputStream();
        InputStream orderTrackInputStream = file.getInputStream();

        //实例化实现了AnalysisEventListener接口的类
        OrderExcelListener orderlistener = new OrderExcelListener();
        OrderTrackExcelListener orderTrackListener = new OrderTrackExcelListener();

        EasyExcel.read(orderInputStream, OrderInfoExcel.class, orderlistener).sheet(0).doRead();
        List<Order> orderList = orderlistener.getOrderList();
        List<User> consignorList = orderlistener.getConsignorList();
        List<User> consigneeList = orderlistener.getConsigneeList();
        List<Good> goodList = orderlistener.getGoodList();

        HashMap<Integer, Integer> orderMap = new HashMap<>();
        for(int i = 0; i < orderList.size(); i++){
            Order order = orderList.get(i);
            int oldId = order.getOrder_id();
            orderService.addOrder(consignorList.get(i), consigneeList.get(i), goodList.get(i), order);
            orderMap.put(oldId, order.getOrder_id());
        }

        EasyExcel.read(orderTrackInputStream, Track.class, orderTrackListener).sheet(1).doRead();
        List<Track> trackList = orderTrackListener.getTrackList();
        for(int i = 0;i < trackList.size(); i++) {
            Track track = trackList.get(i);
            track.setOrder_id(orderMap.get(track.getOrder_id()));
            if(trackService.updateTrack(track, track) == 0){
                trackService.addTrack(track);
            }
        }
        return "ok";
    }


}
