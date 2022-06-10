package com.caffeineshawn.db_backend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
public class DbBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(DbBackendApplication.class, args);
    }

}
