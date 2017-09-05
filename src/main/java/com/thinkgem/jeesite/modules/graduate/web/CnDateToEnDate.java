package com.thinkgem.jeesite.modules.graduate.web;

import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by chenhong on 2017/8/31.
 * 中文日期转英文日期
 */
public class CnDateToEnDate {
    /*public static void main(String args){
        Date date = new Date();
        CnDateToEnDate(date);
    }*/
    /*@Test
    public void test(){
        Date date = new Date();
        String enDate = CnDateToEnDate(date);
        System.out.println(enDate);
    }*/
    public static String CnDateToEnDate(Date cnDate){
       // Map<Integer,String> map = new HashMap<Integer,String>();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String date = format.format(cnDate).replace("-","");
        //date = date.replace("-","");
        String[] enMonth = new String[]{"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
       /* map.put(1,"Jan");
        map.put(2,"Feb");
        map.put(3,"Mar");
        map.put(4,"Apr");
        map.put(5,"May");
        map.put(6,"Jun");
        map.put(7,"Jul");
        map.put(8,"Aug");
        map.put(9,"Sep");
        map.put(10,"Oct");
        map.put(11,"Nov");
        map.put(12,"Dec");*/
        String day = date.substring(6,date.length());
        if (day.indexOf("0")==0){
            day = day.substring(1,2);
        }
        String enDate = enMonth[cnDate.getMonth()]+" "+day+date.substring(0,4);
        return enDate;
    }
}
