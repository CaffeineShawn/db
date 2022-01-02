package com.caffeineshawn.db_backend.service;

import com.caffeineshawn.db_backend.entity.Good;
import com.caffeineshawn.db_backend.mapper.GoodMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Service
public class GoodService {

    @Resource
    GoodMapper goodMapper;

    @Transactional
    public int addGood(Good good){
        return goodMapper.addGood(good);
    }

    public Good findGoodById(int order_id){
        return goodMapper.findGoodById(order_id);
    }

    @Transactional
    public int updateGoodInfo(Good good){
        return goodMapper.updateGoodInfo(good);
    }

    public List<HashMap> getGoodAnalyseInfo(){
        return goodMapper.getGoodAnalyseInfo();
    }
}
