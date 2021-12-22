package com.caffeineshawn.db_backend;

import com.caffeineshawn.db_backend.entity.Good;
import com.caffeineshawn.db_backend.entity.Order;
import com.caffeineshawn.db_backend.entity.User;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;
import java.io.InputStream;

@SpringBootTest
class DbBackendApplicationTests {

    public static void main(String[] args) throws IOException {
        InputStream config = Resources.getResourceAsStream("mybatis-config.xml");
        // 根据配置文件构建SqlSessionFactory
        SqlSessionFactory ssf = new SqlSessionFactoryBuilder().build(config);
        // 通过SqlSessionFactory创建SqlSession
        SqlSession ss = ssf.openSession();
        // SqlSession执行文件中定义的SQL，并返回映射结果
        Good good1 = new Good();
        good1.setGood_destination("广州");
        good1.setGood_name("k380");
        good1.setGood_state("待发货");
        good1.setGood_weight(120.0);
        good1.setGood_origin("深圳");

        ss.insert("com.caffeineshawn.db_backend.mapper.GoodMapper.addGood", good1);

        Good good2 = new Good();
        good2.setGood_destination("广州");
        good2.setGood_name("ipad");
        good2.setGood_state("已发货");
        good2.setGood_origin("杭州");
        good2.setGood_weight(250.0);

        ss.insert("com.caffeineshawn.db_backend.mapper.GoodMapper.addGood", good2);

        Order order = new Order();
        order.setConsignee_id(1);
        order.setConsignor_id(2);
        order.setGood_id(good1.getGood_id());
        ss.insert("com.caffeineshawn.db_backend.mapper.OrderMapper.addOrder", order);

        order.setConsignee_id(2);
        order.setConsignor_id(1);
        order.setGood_id(good2.getGood_id());
        ss.insert("com.caffeineshawn.db_backend.mapper.OrderMapper.addOrder", order);


        User user = ss.getMapper(com.caffeineshawn.db_backend.mapper.UserMapper.class).findUserById(1);
        System.out.println(user);

        ss.commit();
        // 关闭 SqlSession
        ss.close();
    }


}
