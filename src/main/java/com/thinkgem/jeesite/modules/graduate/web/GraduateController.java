/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.graduate.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.thinkgem.jeesite.common.persistence.Msg;
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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.graduate.entity.Graduate;
import com.thinkgem.jeesite.modules.graduate.service.GraduateService;
import com.thinkgem.jeesite.modules.institute.entity.Institute;
import com.thinkgem.jeesite.modules.institute.service.InstituteService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

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
	private InstituteService instituteService;

	@Autowired
	private SystemService systemService;
	
	@ModelAttribute
	public Graduate get(@RequestParam(required=false) String id) {
		Graduate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = graduateService.get(id);
		}
		if (entity == null){
			entity = new Graduate();
		}
		return entity;
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
		Page<Graduate> page = graduateService.findPage(new Page<Graduate>(request, response), graduate);
		model.addAttribute("page", page);
		return "modules/graduate/graduateList";
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


/*
	 * 跳转到毕业生信息编辑页面并把原有的数据显示在表单中
	 * @param graduate
	 * @param model
	 * @return
	 */

	@RequiresPermissions("graduate:graduate:view")
	@RequestMapping(value = "form")
	public String form(Graduate graduate, Model model) {
		List<Institute> institutes = instituteService.findList(new Institute());
		model.addAttribute("graduate", graduate);
		model.addAttribute("institutes", institutes);
		return "modules/graduate/graduateForm";
	}

	/**
	 * 执行修改毕业生信息的方法
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
		}else if (graduateService.findByStuNo(graduate)!=0){
			addMessage(model,"该学号已被注册！");
			return form(graduate, model);
		}
		graduateService.save(graduate);
		addMessage(redirectAttributes, "保存毕业生信息成功");
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
     * 导出毕业信息数据（许彩开 2017.07.26）
     * @param graduate
     * @param request
     * @param response
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("graduate:graduate:view")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(Graduate graduate, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "毕业数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<Graduate> page = systemService.findGraduate(new Page<Graduate>(request, response,
                    -1), graduate);
            //Page<Graduate> page = graduateService.findPage(new Page<Graduate>(request, response), graduate);
            new ExportExcel("毕业数据", Graduate.class).setDataList(page.getList()).write(response, fileName).dispose();

            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导出毕业数据失败！失败信息："+e.getMessage());
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
                    if ("true".equals(checkStuNo("", graduate.getStuNo()))){
                        if(checkInstiuteByOrgId(graduate)){
                        graduate.setPassword(SystemService.entryptPassword("123456"));
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
            Page<Graduate> page = systemService.findGraduate(new Page<Graduate>(request, response, -1), graduate);
            List<Graduate> list = Lists.newArrayList();
            //取出第一个对象
            list.add(page.getList().get(0));
            new ExportExcel("毕业数据", Graduate.class, 2).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
        }
        return "redirect:"+adminPath+"/graduate/graduate/?repage";
    }

    /***
     *
     * @author 许彩开
     * TODO(注：验证学号是否有效)
     * @param oldStuNo
     * @param stuNo
     * @return
     * @return_type String
     * @DATE 2017年7月26日
     */
    @ResponseBody
    @RequiresPermissions("graduate:graduate:edit")
    @RequestMapping(value = "checkStuNo")
    public String checkStuNo(String oldStuNo, String stuNo) {
        if (stuNo !=null && stuNo.equals(oldStuNo)) {
            return "true";
        } else if (stuNo !=null && systemService.getByStuNo(stuNo) == null) {
            return "true";
        }
        return "false";
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



}