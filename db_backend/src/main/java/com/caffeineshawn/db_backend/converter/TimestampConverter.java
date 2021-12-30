package com.caffeineshawn.db_backend.converter;

import com.alibaba.excel.converters.Converter;
import com.alibaba.excel.enums.CellDataTypeEnum;
import com.alibaba.excel.metadata.CellData;
import com.alibaba.excel.metadata.GlobalConfiguration;
import com.alibaba.excel.metadata.property.ExcelContentProperty;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class TimestampConverter implements Converter<Timestamp> {
    @Override
    public Class<Timestamp> supportJavaTypeKey() {
        return Timestamp.class;
    }

    @Override
    public CellDataTypeEnum supportExcelTypeKey() {
        return CellDataTypeEnum.STRING;
    }

    @Override
    public Timestamp convertToJavaData(CellData cellData, ExcelContentProperty excelContentProperty, GlobalConfiguration globalConfiguration) throws Exception {
        System.out.println(cellData.getStringValue());
        return Timestamp.valueOf(cellData.getStringValue());
    }

    @Override
    public CellData convertToExcelData(Timestamp timestamp, ExcelContentProperty excelContentProperty, GlobalConfiguration globalConfiguration) throws Exception {
        return new CellData<>(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(timestamp));
    }
}
