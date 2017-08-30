package com.thinkgem.jeesite.common.utils;


import java.io.IOException;


public class ZipUtilsTest {
    public static void main(String[] args) throws IOException {
        FileUtils.zipFiles("E:\\pdf","graduateModel","E:\\pdf\\中文乱码.zip");
    }

}
