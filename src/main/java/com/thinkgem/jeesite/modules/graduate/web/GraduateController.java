/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.graduate.web;


import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.validation.ConstraintViolationException;
import com.thinkgem.jeesite.common.persistence.Msg;
import com.thinkgem.jeesite.common.utils.PDFUtil;
import com.thinkgem.jeesite.modules.major.entity.Major;
import com.thinkgem.jeesite.modules.major.service.MajorService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.FileUtils;
import com.thinkgem.jeesite.common.utils.PDFUtil;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.graduate.dao.GraduateDao;
import com.thinkgem.jeesite.modules.graduate.entity.Graduate;
import com.thinkgem.jeesite.modules.graduate.service.GraduateService;
import com.thinkgem.jeesite.modules.institute.entity.Institute;
import com.thinkgem.jeesite.modules.institute.service.InstituteService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import static com.thinkgem.jeesite.common.utils.FileUtils.downFile;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.ArrayList;
import java.util.List;

import com.jspsmart.upload.*;

/**
 * 毕业生信息管理Controller
 * @author chenhong
 * @version 2017-07-25
 */
@Controller
@RequestMapping(value = "${adminPath}/graduate/graduate")
public class GraduateController extends BaseController {

	@Autowired
	private GraduateService graduateService;

    @Autowired
    private GraduateDao graduateDao;

	@Autowired
	private InstituteService instituteService;

    @Autowired
    private MajorService majorService;

	@Autowired
	private SystemService systemService;

    @ModelAttribute
    public Graduate get(@RequestParam(required=false) String id) {//
        if (StringUtils.isNotBlank(id)){
            return graduateService.getStudent(id);
        }else{
            return new Graduate();
        }
    }

    /**
     * 用户信息显示及保存
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "info")
    public String info(Graduate student, HttpServletResponse response, Model model) {
        Graduate currentStudent = UserUtils.getStudent();
        model.addAttribute("student", currentStudent);
        model.addAttribute("Global", new Global());
        return "modules/sys/studentInfo";
    }

    /**
     * 返回用户信息
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "infoData")
    public Graduate infoData() {
        return  UserUtils.getStudent();
    }

    /**
     * 修改个人用户密码
     * @param oldPassword
     * @param newPassword
     * @param model
     * @return
     */
    @RequiresPermissions("user:view")
    @RequestMapping(value = "modifyPwd")
    public String modifyPwd(String oldPassword, String newPassword, Model model) {
        Graduate student = UserUtils.getStudent();
        if (StringUtils.isNotBlank(oldPassword) && StringUtils.isNotBlank(newPassword)){
            if (SystemService.validatePassword(oldPassword, student.getPassword())){
                graduateService.updateStudentPasswordById(student.getId(), newPassword);
                model.addAttribute("message", "修改密码成功");
            }else{
                model.addAttribute("message", "修改密码失败，旧密码错误");
            }
        }
        model.addAttribute("student", student);
        return "modules/sys/studentModifyPwd";
    }


    /**
     * @author 余锡鸿
     * @TODO (注：学生毕业证书)
     * @param model
     * @DATE: 2017/8/28 20:51
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "graduationCertificate")
    public String graduationCertificate(Model model,RedirectAttributes redirectAttributes) {
        if(StringUtils.isNotBlank(UserUtils.getStudent().getGraCertificate())){
            return "modules/graduate/graduationCertificate";
        }
        else{
            model.addAttribute("message","您的证书还未制作");
            return "modules/graduate/graduationCertificate";
        }

    }

    /**
     * @author 余锡鸿
     * @TODO (注：学生学位证书)
     * @param model
     * @DATE: 2017/8/28 20:53
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "degreeCertificate")
    public String degreeCertificate(Model model) {
        if(StringUtils.isNotBlank(UserUtils.getStudent().getDegreeCertificate())){
            return "modules/graduate/degreeCertificate";
        }
        else{
            model.addAttribute("message","您的证书还未制作");
            return "modules/graduate/degreeCertificate";
        }
    }


	/**
	 * 分页查询毕业生信息列表的方法
	 * @param graduate
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("graduate:graduate:view")
	@RequestMapping(value = {"list", ""})
	public String list(Graduate graduate, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<Institute> institutes = instituteService.findList(new Institute());
		Page<Graduate> page = graduateService.findPage(new Page<Graduate>(request, response), graduate);
        model.addAttribute("institutes", institutes);
		model.addAttribute("page", page);
		return "modules/graduate/graduateList";
	}


    /**
     * 分页查询毕业生信息列表的方法
     * @param graduate
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("graduate:graduate:view")
    @RequestMapping(value = "list1")
    public String list1(Graduate graduate, HttpServletRequest request, HttpServletResponse response, Model model) {
        List<Institute> institutes = instituteService.findList(new Institute());
        Page<Graduate> page = graduateService.findPage(new Page<Graduate>(request, response), graduate);
        model.addAttribute("institutes", institutes);
        model.addAttribute("page", page);
        return "modules/graduate/graduateList1";
    }

    @RequiresPermissions("graduate:graduate:view")
    @RequestMapping(value = "startMaking")
    public String startMaking() {
        /**
         * @author 许彩开
         * @TODO (注：开始制作)
         * @param graduate
         * @param request
         * @param response
         * @param model
         * @DATE: 2017\8\28 0028 11:33
         */

        return "modules/graduate/index";
    }




    @RequiresPermissions("graduate:graduate:view")
    @RequestMapping(value = "smartUploaddemo")
    public String smartUploaddemo( HttpServletRequest  request, HttpServletResponse response,MultipartFile image,Model model) throws ServletException, SmartUploadException, IOException, FileUploadException {
        /**
         * @author 许彩开
         * @TODO (注：开始制作)
         * @param graduate
         * @param request
         * @param response
         * @param model
         * @DATE: 2017\8\28 0028 11:33
         */

//        DiskFileItemFactory factory=new DiskFileItemFactory();
//        ServletFileUpload upload=new ServletFileUpload(factory);
//        List items=upload.parseRequest(request);
//        Iterator it=items.iterator();
//        while(it.hasNext()){
//            FileItem item = (FileItem)it.next();
//            if(item.getName() != null && !"".equals(item.getName())){
//                System.out.println("上传的文件名称为：" + item.getName());
//            }
//        }
//        System.out.println("自己拿的照片"+image.getOriginalFilename());
//
//
//        System.out.println(request.getParameter("id")+"fuck you");
//        model.addAttribute("image",image);


        return "modules/graduate/smartUploaddemo";
    }

    @RequiresPermissions("graduate:graduate:view")
    @RequestMapping(value = "template")
    public String template() {
        /**
         * @author 许彩开
         * @TODO (注：证书模板制作接入)
          * @param graduate
         * @param request
         * @param response
         * @param model
         * @DATE: 2017\8\28 0028 11:33
         */

        return "modules/graduate/templateMaking";
    }

    @RequiresPermissions("graduate:graduate:view")
    @RequestMapping(value = "CheckModel")
    public String CheckModel(Graduate graduate, HttpServletRequest request, HttpServletResponse response, Model model) {
        /**
         * @author 许彩开
         * @TODO (注：历史模板查看接口)
         * @param graduate
         * @param request
         * @param response
         * @param model
         * @DATE: 2017\8\28 0028 11:33
         */

        return "modules/graduate/CheckModel";
    }


	/**
	 * 通过json数据返回给前端页面
	 * @param id
	 * @return
	 */
	@RequiresPermissions("graduate:graduate:view")
	@RequestMapping(value = "/detail/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg detail(@PathVariable("id") String id) {
		Graduate graduate = graduateService.get(id);
		return Msg.success().add("detail",graduate);
	}


    /**
     *  @author chenhong
	 * 跳转到毕业生添加页面
	 * @param graduate
	 * @param model
	 * @return
	 */

	@RequiresPermissions("graduate:graduate:view")
	@RequestMapping(value = "form")
	public String form(Graduate graduate, Model model) {
		List<Institute> institutes = instituteService.findList(new Institute());

		List<Major> majors = majorService.findMajor(institutes.get(0).getId());

		model.addAttribute("graduate", graduate);
		model.addAttribute("institutes", institutes);
        model.addAttribute("majors", majors);
		return "modules/graduate/graduateForm";
	}

       /**
     * @author chenhong
     * 跳转到毕业生编辑页面并把原有的数据显示在表单中
     * @param graduate
     * @param model
     * @return
     */
    @RequiresPermissions("graduate:graduate:view")
    @RequestMapping(value = "edit")
    public String edit(Graduate graduate, Model model) {
        List<Institute> institutes = instituteService.findList(new Institute());

        List<Major> majors = majorService.findMajor(graduate.getOrgId());

        model.addAttribute("graduate", graduate);
        model.addAttribute("institutes", institutes);
        model.addAttribute("majors", majors);
        return "modules/graduate/graduateEdit";
    }

	/**
     * @author chenhong
	 * 执行添加毕业生信息的方法
	 * @param graduate
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("graduate:graduate:edit")
	@RequestMapping(value = "save")
	public String save(Graduate graduate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, graduate)){
			return form(graduate, model);
		}else if(graduateService.findByStuNo(graduate) > 0){
            model.addAttribute("message","该学号已存在！");
            return form(graduate, model);
        }
        graduate.setPassword(SystemService.entryptPassword("123456"));
		graduate.setBirthdayEn(CnDateToEnDate.CnDateToEnDate(graduate.getBirthday()));
		graduateService.save(graduate);
		addMessage(redirectAttributes, "保存毕业生信息成功");
		return "modules/graduate/graduateEdit";
	}

    /**
     * @author chenhong
     * 执行修改毕业生信息的方法
     * @param graduate
     * @param model
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("graduate:graduate:edit")
    @RequestMapping(value = "update")
    public String update(Graduate graduate, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, graduate)){
            return form(graduate, model);
        }
        graduate.setBirthdayEn(CnDateToEnDate.CnDateToEnDate(graduate.getBirthday()));
        graduateService.save(graduate);
        addMessage(redirectAttributes, "修改毕业生信息成功");
        return "redirect:"+Global.getAdminPath()+"/graduate/graduate/?repage";
    }


    /**
     * @author 余锡鸿
     * @TODO (注：重置学生密码)
     * @param graduate
     * @param model
     * @param redirectAttributes
     * @DATE: 2017/8/22 9:14
     */
    @RequiresPermissions("graduate:graduate:edit")
    @RequestMapping(value = "resetPwd")
    public String resetPwd(Graduate graduate, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, graduate)){
            return form(graduate, model);
        }
        graduate.setPassword(SystemService.entryptPassword("123456"));
        graduateService.save(graduate);
        addMessage(redirectAttributes, "重置密码成功，密码为123456");
        return "redirect:"+Global.getAdminPath()+"/graduate/graduate/?repage";
    }

	/**
	 * 删除毕业生信息的方法
	 * @param graduate
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("graduate:graduate:edit")
	@RequestMapping(value = "delete")
	public String delete(Graduate graduate, RedirectAttributes redirectAttributes) {
		graduateService.delete(graduate);
		addMessage(redirectAttributes, "删除毕业生信息成功");
		return "redirect:"+Global.getAdminPath()+"/graduate/graduate/?repage";
	}

	/**
     * @author chenhong
	 * 批量删除毕业生信息的方法
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("graduate:graduate:edit")
	@RequestMapping(value = "batchDelete")
	public String batchDelete(RedirectAttributes redirectAttributes,String ids) {
		graduateService.batchDelete(ids);
		addMessage(redirectAttributes, "批量删除毕业生信息成功");
		return "redirect:"+Global.getAdminPath()+"/graduate/graduate/?repage";
	}

    /**
     * @Author:LianHaoWen
     * 导入毕业生头像
     *
     */
    @RequestMapping(value = "upload")
    public String graduateImg(){
        return "modules/graduate/upload";
    }

    /**
     * 导入毕业证书
     *
     */
    @RequestMapping(value = "uploadPdf")
    public String graduatePdf(){
        return "modules/graduate/uploadPdf";
    }

    /**
     * 导入学士学位证书
     *
     */
    @RequestMapping(value = "uploadDegreePdf")
    public String graduateDegreePdf(){
        return "modules/graduate/uploadDegreePdf";
    }

    /**
     * 下载毕业证书
     *
     */
    @RequestMapping(value = "downloadGraduate")
    public String downloadGraduate(HttpServletRequest request,HttpServletResponse response){
        FileUtils.zipFiles("E:\\pdf","graduateModel","E:\\pdf\\graduateModel.zip");
        File file=new File("E:\\pdf\\graduateModel.zip");
        FileUtils.downFile(file,request,response,"graduateModel.zip");
        return "redirect:"+Global.getAdminPath()+"/graduate/graduate/graduateList1/?repage";
    }

    /**
     * 下载学士学位证书
     *
     */
    @RequestMapping(value = "downloadDegree")
    public String downloadDegree(HttpServletRequest request,HttpServletResponse response){
        FileUtils.zipFiles("E:\\pdf","degreeModel","E:\\pdf\\degreeModel.zip");
        File file=new File("E:\\pdf\\degreeModel.zip");
        FileUtils.downFile(file,request,response,"degreeModel.zip");
        return "redirect:"+Global.getAdminPath()+"/graduate/graduate/graduateList1/?repage";
    }

    /**
     * 导出毕业信息数据（许彩开 2017.07.26）
     * @param graduate
     * @param request
     * @param response
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("graduate:graduate:view")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(Graduate graduate, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes,String ids) {
        try {
            String fileName = "毕业数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
          List<String> listString=graduateService.exportSelect(ids);
          if(ids.equals("0")) {
              List<Graduate> list = graduateService.findAllGraduate(graduate);
              System.out.println("list ============="+list+"\n======list.size()"+list.size());
              new ExportExcel("毕业数据", Graduate.class).setDataList(list).write(response, fileName).dispose();
          }else {
              //注：导出选中的学生
              List<Graduate> list = graduateService.exportSelectGraduate(listString);
              new ExportExcel("毕业数据", Graduate.class).setDataList(list).write(response, fileName).dispose();
          }
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导出毕业数据失败！失败信息："+e.getMessage());
            e.printStackTrace();
        }
        return "redirect:"+adminPath+"/graduate/graduate?repage";
    }



    /**
     * 导入毕业数据
     * @param file
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("graduate:graduate:edit")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file,Model model, RedirectAttributes redirectAttributes) {
        if(Global.isDemoMode()){
            addMessage(redirectAttributes, "演示模式，不允许操作！");
            return "redirect:" + adminPath + "/sys/user/list?repage";
        }
        try {
            int successNum = 0;
            int failureNum = 0;
            StringBuilder failureMsg = new StringBuilder();
            ImportExcel ei = new ImportExcel(file, 1, 0);
            List<Graduate> list = ei.getDataList(Graduate.class);
            for (Graduate graduate : list){
                try{
                    if ("true".equals(checkStuNo(graduate))){
                        if(checkInstiuteByOrgId(graduate)){
                            //性别转换 1==男  ，2==女
                            if(graduate.getSex().equals("男")){
                                graduate.setSex("1");
                            }else{
                                graduate.setSex("2");
                            }
                            graduate.setPassword(SystemService.entryptPassword("123456"));
                            graduate.setBirthdayEn(CnDateToEnDate.CnDateToEnDate(graduate.getBirthday()));
                            BeanValidators.validateWithException(validator, graduate);
                            graduateService.save(graduate);
                            successNum++;
                        }else{
                            failureMsg.append("<br/>学号为："+graduate.getStuNo()+" 的学院代码或者学院名称输入错误！");
                            failureNum++;
                        }
                    }else{
                        failureMsg.append("<br/>学号： "+graduate.getStuNo()+" 已存在; ");
                        failureNum++;
                    }
                }catch(ConstraintViolationException ex){
                    failureMsg.append("<br/>学号 "+graduate.getStuNo()+" 导入失败：");
                    List<String> messageList = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
                    for (String message : messageList){
                        failureMsg.append(message+"; ");
                        failureNum++;
                    }
                }catch (Exception ex) {
                    failureMsg.append("<br/>学号 "+graduate.getStuNo()+" 导入失败："+ex.getMessage());
                    ex.printStackTrace();
                }
            }
            if (failureNum>0){
                failureMsg.insert(0, "，失败 "+failureNum+" 条用户，导入信息如下：");
            }
            addMessage(redirectAttributes, "已成功导入 "+successNum+" 条用户"+failureMsg);
        } catch (Exception e) {
            addMessage(redirectAttributes, "导入用户失败！失败信息："+e.getMessage());
        }
        return "redirect:"+Global.getAdminPath()+"/graduate/graduate/?repage";
    }

    /**
     *
     * @author 许彩开
     * TODO(注：下载导入毕业信息数据模板)
     * @param graduate
     * @param request
     * @param response
     * @param redirectAttributes
     * @return
     * @return_type String
     * @DATE 2017年7月26日
     */
    @RequiresPermissions("graduate:graduate:view")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(Graduate graduate,HttpServletRequest request,HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "毕业数据导入模板.xlsx";
            Page<Graduate> page = graduateService.findGraduate(new Page<Graduate>(request, response, -1), graduate);
            List<Graduate> list = Lists.newArrayList();
            if(page.getList()!=null&&page.getList().size()>0) {
                //取出第一个对象
                list.add(page.getList().get(0));
                new ExportExcel("毕业数据", Graduate.class, 2).setDataList(list).write(response, fileName).dispose();
                return null;
            }else{
                new ExportExcel("毕业数据",Graduate.class,2).write(response,fileName).dispose();
                return null;
            }
        } catch (Exception e) {
            addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
        }
        return "redirect:"+adminPath+"/graduate/graduate/?repage";
    }

    /***
     *
     * @author 许彩开
     * TODO(注：验证学号是否有效)
     * @param graduate
     * @return
     * @return_type String
     * @DATE 2017年7月26日
     */
    @ResponseBody
    @RequiresPermissions("graduate:graduate:edit")
    @RequestMapping(value = "checkStuNo")
    public String checkStuNo(Graduate graduate) {
        if (graduate !=null&&graduate.getStuNo() != null) {
            if ( graduateService.findByStuNo(graduate) > 0) {
                //该学号已存在
                return "false";
            }else{
                return "true";
            }
        }else{
            return "false";
        }
    }
    public boolean checkInstiuteByOrgId(Graduate graduate){
        /**
         * @author 许彩开
         * @TODO (注：验证学院代码是否有效)
         * @param graduate
         * @DATE: 2017/8/1 10:20
         */
        Institute institute=null;
        if(graduate.getOrgId()!=null||!graduate.getOrgId().equals("")){
            institute=instituteService.getInstituteByOrgId(graduate.getOrgId());
            if(institute!=null&&institute.getInstituteName().equals(graduate.getOrgName())){
                graduate.setOrgId(institute.getId());
                return  true;
            }else {
                return false;
            }
        }else{
            return false;
        }
    }

    /**
     * @author chenhong
     * 执行批量生成毕业证书的方法
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("graduate:graduate:edit")
    @RequestMapping(value = "makeGraCertificate")
    public String makeGraCertificate(RedirectAttributes redirectAttributes,String ids) {
        List<String> listString=graduateService.exportSelect(ids);//先把ids中转成每个学生的id组成的数组
        List<Graduate> list = graduateService.exportSelectGraduate(listString);//根据list中的id查询学生
        String path = "E:\\pdf\\graduate.pdf";
        List<Graduate> list1 = new ArrayList<Graduate>();
        StringBuilder message = new StringBuilder();
        for(Graduate graduate1 : list){
            if(graduate1.getStuImg()==null){
                list1.add(graduate1);
            }
        }
        for(Graduate graduate1 : list1){
            message.append(graduate1.getStuNo()+",");

        }
        if(list1!=null && list1.size()>0){
            message.append("以上学号没有上传头像！");
            addMessage(redirectAttributes, message.toString());
            return "redirect:"+Global.getAdminPath()+"/graduate/graduate/list1?repage";
        }

        for(Graduate graduate1 : list){
            try {
                String outputFileName = "E:\\pdf\\graduateModel\\" + graduate1.getStuNo() + graduate1.getStuName() + ".pdf" ;
                PDFUtil.fillTemplate(graduate1,path,outputFileName);
                graduate1.setGraCertificate("/pic/pdf/graduateModel/"+graduate1.getStuNo()+graduate1.getStuName()+".pdf");
                //update(graduate1,model,redirectAttributes);
                graduateDao.updateGraByStuNo(graduate1);
            }catch (Exception e){
                e.printStackTrace();
            }
        }

        addMessage(redirectAttributes, "生成毕业证书成功");
        return "redirect:"+Global.getAdminPath()+"/graduate/graduate/list1?repage";
    }

    /**
     * @author chenhong
     * 执行批量生成学位证书的方法
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("graduate:graduate:edit")
    @RequestMapping(value = "makeDgrCertificate")
    public String makeDgrCertificate(RedirectAttributes redirectAttributes,String ids) {
        List<String> listString=graduateService.exportSelect(ids);//先把ids中转成每个学生的id组成的数组
        List<Graduate> list = graduateService.exportSelectGraduate(listString);//根据list中的id查询学生
        String path = "E:\\pdf\\degree.pdf";
        List<Graduate> list1 = new ArrayList<Graduate>();
        StringBuilder message = new StringBuilder();
        for(Graduate graduate1 : list){
            if(graduate1.getStuImg()==null){
                list1.add(graduate1);
            }
        }
        for(Graduate graduate1 : list1){
            message.append(graduate1.getStuNo()+",");

        }
        if(list1!=null && list1.size()>0){
            message.append("以上学号没有上传头像！");
            addMessage(redirectAttributes, message.toString());
            return "redirect:"+Global.getAdminPath()+"/graduate/graduate/list1?repage";
        }
        for(Graduate graduate1 : list){
            try {
                String outputFileName = "E:\\pdf\\degreeModel\\" + graduate1.getStuNo() + graduate1.getStuName() + ".pdf" ;
                PDFUtil.fillTemplate(graduate1,path,outputFileName);
                graduate1.setDegreeCertificate("/pic/pdf/degreeModel/"+graduate1.getStuNo()+graduate1.getStuName()+".pdf");
                //update(graduate1,model,redirectAttributes);
                graduateDao.updateDegreeByStuNo(graduate1);
            }catch (Exception e){
                e.printStackTrace();
            }
        }

        addMessage(redirectAttributes, "生成学位证书成功");
        return "redirect:"+Global.getAdminPath()+"/graduate/graduate/list1?repage";
    }
}