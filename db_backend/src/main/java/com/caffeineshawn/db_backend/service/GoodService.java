package com.caffeineshawn.db_backend.service;

import com.caffeineshawn.db_backend.entity.Good;
import com.caffeineshawn.db_backend.mapper.GoodMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class GoodService {

    @Resource
    GoodMapper goodMapper;

    public int addGood(Good good){
        return goodMapper.addGood(good);
    }

}
