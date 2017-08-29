package com.thinkgem.jeesite.modules.graduate.web;


import com.alibaba.druid.support.json.JSONUtils;
import com.thinkgem.jeesite.modules.graduate.dao.GraduateDao;
import com.thinkgem.jeesite.modules.graduate.entity.Graduate;
import com.thinkgem.jeesite.modules.graduate.service.GraduateService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Controller
@RequestMapping(value="${adminPath}/graduate/plupload")
public class PluploadController{
    @Autowired
    private GraduateService graduateService;
    @Autowired
    private GraduateDao graduateDao;

    private static final int BUFFER_SIZE=100*1024;
    private static final Logger logger= Logger.getLogger(PluploadController.class);

    @RequestMapping(value="/")
    public String index(HttpServletRequest request){
        return "index";
    }

    /**
     * @Author HW
     * 使用plupload  上传文件头像
     * @param file		文件对象
     * @param request		文件名称
     * @param session		数据块序号
     *
     * @return
     */
    @RequestMapping(value = "plupload",method = RequestMethod.POST)
    @ResponseBody
    public void plupload(@RequestParam final MultipartFile file, HttpServletRequest request,
                         HttpServletResponse response, HttpSession session) throws IOException {

            final String name = request.getParameter("name");
            final String stuNo = name.substring(0,12);
            Graduate graduate = graduateService.getByStuNo(stuNo);
//            System.out.println(stuNum+"+++++++++++++++++"+graduate);
            Integer chunk=0,chunks=0;
            if (null!=request.getParameter("chunk")&&!request.getParameter("chunk").equals("")){
                chunk = Integer.valueOf(request.getParameter("chunk"));
            }
            if (null!=request.getParameter("chunks")&&!request.getParameter("chunks").equals("")){
                chunks=Integer.valueOf(request.getParameter("chunks"));
            }
            logger.info("chunk:["+chunk+"] chunks["+chunks+"]");
            String grade = name.substring(0,2);
            String institute = name.substring(2,4);
            String major = name.substring(4,6);
            String classes = name.substring(6,8);
            final String relativePath="/"+grade+"/"+institute+"/"+major+"/"+classes+"/";
            final String realPath=session.getServletContext().getRealPath("");
            //线程池里的线程数会动态变化，并可在线程被移除前重用
            ExecutorService threadPool = Executors.newCachedThreadPool();
            if (graduate!=null){
                final Integer finalChunk = chunk;
                final Integer finalChunks = chunks;
                threadPool.execute(new Runnable() {
                    @Override
                    public void run() {
                        try {
                            //新建文件夹
//                            File folder=new File("D:"+"//"+"stuImg"+relativePath);
                            File folder=new File("E:"+"//"+"stuImg"+relativePath);
                            if (!folder.exists()){
                                folder.mkdirs();
                            }
                            File destFile = new File(folder,name);
                            //文件已存在删除旧文件（上传了新同名文件的话 ）
                            if ((finalChunk == 0) && destFile.exists()){
                                destFile.delete();
                                destFile = new File(folder,name);
                            }
                            //合成文件

                                appendFile(file.getInputStream(),destFile);

                            if (finalChunk == finalChunks){
                                logger.info("上传完成");
                            }else{
                                logger.info("还剩["+(finalChunks -1- finalChunk)+"]个块文件");
                            }
                        } catch (IOException e) {
                            logger.error(e.getMessage());
                        }
                    }

                });
                threadPool.execute(new Runnable() {
                    @Override
                    public void run() {
                        Graduate graduate = new Graduate();
                        String realPathName = "stuImg"+relativePath+name;
//                        System.out.println("*****************************"+realPathName);
                        graduate.setStuImg(realPathName);
                        graduate.setStuNo(stuNo);
                        graduateDao.updateByStuNo(graduate);
                    }
                });

            }else{
                //获取不存在对应学生的信息，然后将其通过json封装好后返回給前台
                String msg = "照片"+name+"不存在对应的学生";
                Map <String,Object> m = new HashMap<String,Object>();
                m.put("status",false);
                m.put("stuInfo",msg);

                response.getWriter().write(JSONUtils.toJSONString(m));
                System.out.println("照片"+name+"不存在对应的学生");

            }
    }

    /**
     * @Author HW
     * 使用plupload  上传毕业证
     * @param file		文件对象
     * @param request		文件名称
     * @param session		数据块序号
     *
     * @return
     */
    @RequestMapping(value = "pluploadGraduatePdf",method = RequestMethod.POST)
    @ResponseBody
    public void pluploadPdf(@RequestParam final MultipartFile file, HttpServletRequest request,
                         HttpServletResponse response, HttpSession session) throws IOException {

        final String name = request.getParameter("name");
        final String stuNo = name.substring(0,12);
        Graduate graduate = graduateService.getByStuNo(stuNo);
//            System.out.println(stuNum+"+++++++++++++++++"+graduate);
        Integer chunk=0,chunks=0;
        if (null!=request.getParameter("chunk")&&!request.getParameter("chunk").equals("")){
            chunk = Integer.valueOf(request.getParameter("chunk"));
        }
        if (null!=request.getParameter("chunks")&&!request.getParameter("chunks").equals("")){
            chunks=Integer.valueOf(request.getParameter("chunks"));
        }
        logger.info("chunk:["+chunk+"] chunks["+chunks+"]");
        String grade = name.substring(0,2);
        String institute = name.substring(2,4);
        String major = name.substring(4,6);
        String classes = name.substring(6,8);
        final String relativePath="/"+grade+"/"+institute+"/"+major+"/"+classes+"/";
//        final String realPath=session.getServletContext().getRealPath("");
        //线程池里的线程数会动态变化，并可在线程被移除前重用
        ExecutorService threadPool = Executors.newCachedThreadPool();
        if (graduate!=null){
            final Integer finalChunk = chunk;
            final Integer finalChunks = chunks;
            threadPool.execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        //新建文件夹
//                            File folder=new File("D:"+"//"+"stuImg"+relativePath);
                        File folder=new File("E:"+"//"+"pdf/graduate"+relativePath);
                        if (!folder.exists()){
                            folder.mkdirs();
                        }
                        File destFile = new File(folder,name);
                        //文件已存在删除旧文件（上传了新同名文件的话 ）
                        if ((finalChunk == 0) && destFile.exists()){
                            destFile.delete();
                            destFile = new File(folder,name);
                        }
                        //合成文件

                        appendFile(file.getInputStream(),destFile);

                        if (finalChunk == finalChunks){
                            logger.info("上传完成");
                        }else{
                            logger.info("还剩["+(finalChunks -1- finalChunk)+"]个块文件");
                        }
                    } catch (IOException e) {
                        logger.error(e.getMessage());
                    }
                }

            });
            threadPool.execute(new Runnable() {
                @Override
                public void run() {
                    Graduate graduate = new Graduate();
                    String realPathName = "/pic/pdf/graduate"+relativePath+name;
//                        System.out.println("*****************************"+realPathName);
                    graduate.setGraCertificate(realPathName);
                    graduate.setStuNo(stuNo);
                    graduateDao.updateGraByStuNo(graduate);
                }
            });

        }else{
            //获取不存在对应学生的信息，然后将其通过json封装好后返回給前台
            String msg = "该毕业证书"+name+"不存在对应的学生";
            Map <String,Object> m = new HashMap<String,Object>();
            m.put("status",false);
            m.put("stuInfo",msg);

            response.getWriter().write(JSONUtils.toJSONString(m));
            System.out.println("该毕业证书"+name+"不存在对应的学生");

        }
    }

    /**
     * @Author HW
     * 使用plupload  上传学士学位证书
     * @param file		文件对象
     * @param request		文件名称
     * @param session		数据块序号
     *
     * @return
     */
    @RequestMapping(value = "uploadDegreePdf",method = RequestMethod.POST)
    @ResponseBody
    public void pluploadDegreePdf(@RequestParam final MultipartFile file, HttpServletRequest request,
                            HttpServletResponse response, HttpSession session) throws IOException {

        final String name = request.getParameter("name");
        final String stuNo = name.substring(0,12);
        Graduate graduate = graduateService.getByStuNo(stuNo);
//            System.out.println(stuNum+"+++++++++++++++++"+graduate);
        Integer chunk=0,chunks=0;
        if (null!=request.getParameter("chunk")&&!request.getParameter("chunk").equals("")){
            chunk = Integer.valueOf(request.getParameter("chunk"));
        }
        if (null!=request.getParameter("chunks")&&!request.getParameter("chunks").equals("")){
            chunks=Integer.valueOf(request.getParameter("chunks"));
        }
        logger.info("chunk:["+chunk+"] chunks["+chunks+"]");
        String grade = name.substring(0,2);
        String institute = name.substring(2,4);
        String major = name.substring(4,6);
        String classes = name.substring(6,8);
        final String relativePath="/"+grade+"/"+institute+"/"+major+"/"+classes+"/";
//        final String realPath=session.getServletContext().getRealPath("");
        //线程池里的线程数会动态变化，并可在线程被移除前重用
        ExecutorService threadPool = Executors.newCachedThreadPool();
        if (graduate!=null){
            final Integer finalChunk = chunk;
            final Integer finalChunks = chunks;
            threadPool.execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        //新建文件夹
//                            File folder=new File("D:"+"//"+"stuImg"+relativePath);
                        File folder=new File("E:"+"//"+"pdf/degree"+relativePath);
                        if (!folder.exists()){
                            folder.mkdirs();
                        }
                        File destFile = new File(folder,name);
                        //文件已存在删除旧文件（上传了新同名文件的话 ）
                        if ((finalChunk == 0) && destFile.exists()){
                            destFile.delete();
                            destFile = new File(folder,name);
                        }
                        //合成文件

                        appendFile(file.getInputStream(),destFile);

                        if (finalChunk == finalChunks){
                            logger.info("上传完成");
                        }else{
                            logger.info("还剩["+(finalChunks -1- finalChunk)+"]个块文件");
                        }
                    } catch (IOException e) {
                        logger.error(e.getMessage());
                    }
                }

            });
            threadPool.execute(new Runnable() {
                @Override
                public void run() {
                    Graduate graduate = new Graduate();
                    String realPathName = "/pic/pdf/degree"+relativePath+name;
//                    System.out.println("*****************************"+realPathName);
                    graduate.setDegreeCertificate(realPathName);
                    graduate.setStuNo(stuNo);
                    graduateDao.updateDegreeByStuNo(graduate);
                }
            });

        }else{
            //获取不存在对应学生的信息，然后将其通过json封装好后返回給前台
            String msg = "该学士学位证书"+name+"不存在对应的学生";
            Map <String,Object> m = new HashMap<String,Object>();
            m.put("status",false);
            m.put("stuInfo",msg);

            response.getWriter().write(JSONUtils.toJSONString(m));
            System.out.println("该学士学位证书"+name+"不存在对应的学生");

        }
    }

    private void appendFile(InputStream inputStream, File destFile) {
        OutputStream out=null;
        try{
            //plupload配置了chunk的时候新上传的文件append到文件末尾
            if (destFile.exists()){
                out = new BufferedOutputStream(new FileOutputStream(destFile,true),BUFFER_SIZE);
            }else {
                out = new BufferedOutputStream(new FileOutputStream(destFile),BUFFER_SIZE);
            }
            inputStream = new BufferedInputStream(inputStream,BUFFER_SIZE);
            int len = 0;
            byte[] buffer = new byte[BUFFER_SIZE];
            while((len= inputStream.read(buffer))>0){
                out.write(buffer,0,len);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }finally {
            try{
                if (null!=inputStream){
                    inputStream.close();
                }
                if (null!=out){
                    out.close();
                }
            }catch (IOException e){
                logger.error(e.getMessage());
            }
        }
    }
}
