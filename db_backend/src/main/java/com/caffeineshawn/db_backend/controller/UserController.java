package com.caffeineshawn.db_backend.controller;

import com.alibaba.fastjson.JSON;
import com.caffeineshawn.db_backend.entity.FilePath;
import com.caffeineshawn.db_backend.entity.QueryInfo;
import com.caffeineshawn.db_backend.entity.User;
import com.caffeineshawn.db_backend.service.UserService;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {
    @Resource
    UserService userService;

    @PostMapping("/findAllUser")
    public String findAllUser(@RequestBody QueryInfo queryInfo){
        List<User> uList = userService.findAllUser(queryInfo);
        int count = userService.findAllUserCount(queryInfo);
        HashMap<String, Object> map = new HashMap<>();
        map.put("res", uList);
        map.put("total", count);
        return JSON.toJSONString(map);
    }
    @GetMapping("/findUserById/{user_id}")
    public String findUserById(@PathVariable int user_id){
        User user = userService.findUserById(user_id);
        return JSON.toJSONString(user);
    }


    @GetMapping("/findUsers")
    public String findUsers() {
        List<User> users = userService.findUsers();
        return JSON.toJSONString(users);
    }

    @PostMapping("/addUser")
    public String addUser(@RequestBody User user){
        return userService.addUser(user)==1 ? "true" : "false";
    }

    @PostMapping("/addAllUser")
    public String addAllUser(@RequestBody User user){
        return userService.addAllUser(user)==1 ? "true" : "false";
    }

    @PutMapping("/updateUser")
    public String updateUser(@RequestBody User user){

        System.out.println(user);
        return userService.updateUser(user)==1 ? "true" : "false";
    }

    @DeleteMapping("/deleteUser/{user_id}")
    public String deleteUser(@PathVariable int user_id){
        return userService.deleteUser(user_id)==1 ? "true" : "false";
    }

    @PostMapping("/login")
    public Integer login(@RequestBody User user){
        List<Integer> userList = userService.findUsersByName(user.getUser_name());
        if(userList.size()==1) {
            String password = userService.confirmPassword(userList.get(0));
            return password.equals(user.getUser_password()) ? userList.get(0) : -100;
        }
        else if(userList.size()==0){
            return -200;
        } else{
            for (int me : userList) {
                String password = userService.confirmPassword(me);
                if(password.equals(user.getUser_password()))
                    return me;
            }
        }
        return -100;
    }
        @PostMapping("/userImport")
        public String userImport(@RequestBody FilePath filePath) {
            List<User> userList = new ArrayList<User>();

            try {
                FileInputStream fio = new FileInputStream(filePath.getPath());
                HSSFWorkbook workbook = new HSSFWorkbook(fio);
                HSSFSheet sheet = workbook.getSheetAt(0);

                for (Row row : sheet) {
                    if (row.getRowNum() == 0) {// 首行表头不读取
                        continue;
                    }

                    User user = new User();
                    user.setUser_name(row.getCell(0).getStringCellValue());
                    user.setUser_password(row.getCell(1).getStringCellValue()) ;
                    user.setUser_gender(row.getCell(2).getStringCellValue());
                    user.setUser_phone(row.getCell(3).getStringCellValue());
                    user.setUser_role((int)row.getCell(4).getNumericCellValue());

                    userList.add(user);
                }

                workbook.close();
                fio.close();

            } catch (IOException e) {
                e.printStackTrace();
                return "false";
            }

            for (User me:
                 userList) {
                userService.addAllUser(me);
            }
            return "true";
        }

        @PostMapping("/userExport")
        public String userExport(@RequestBody FilePath filePath){
            List<User> userList= userService.findUsers();
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet();

            HSSFRow titleRow = sheet.createRow(0);
            titleRow.createCell(0).setCellValue("用户名");
            titleRow.createCell(1).setCellValue("密码");
            titleRow.createCell(2).setCellValue("性别");
            titleRow.createCell(3).setCellValue("电话");
            titleRow.createCell(4).setCellValue("权限");

            for (User user : userList) {
                int lastRowNum = sheet.getLastRowNum();//获取最后一行行号

                HSSFRow row = sheet.createRow(lastRowNum+1);
                row.createCell(0).setCellValue(user.getUser_name());
                row.createCell(1).setCellValue(user.getUser_password());
                row.createCell(2).setCellValue(user.getUser_gender());
                row.createCell(3).setCellValue(user.getUser_phone());
                row.createCell(4).setCellValue(user.getUser_role());
            }

            try {
                FileOutputStream fos = new FileOutputStream(filePath.getPath());
                workbook.write(fos);
                workbook.close();
                fos.close();
            } catch (IOException e) {
                e.printStackTrace();
                return "false";
            }
            return "true";
        }

        @GetMapping("/getUserCostAnalyseInfo/{user_id}")
        public String getUserCostAnalyseInfo(@PathVariable int user_id){
            List<HashMap> lMap = userService.getUserCostAnalyseInfo(user_id);
            return JSON.toJSONString(lMap);
        }
}
