package com.caffeineshawn.db_backend.mapper;

import com.caffeineshawn.db_backend.entity.Good;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface GoodMapper {

    int addGood(Good good);

    Good findGoodById(int order_id);

    int updateGoodInfo(Good good);

    int deleteGoodByOrderId(int order_id);

    Good findGoodByGoodInfo(Good good);

    List<HashMap> getGoodAnalyseInfo();
}
