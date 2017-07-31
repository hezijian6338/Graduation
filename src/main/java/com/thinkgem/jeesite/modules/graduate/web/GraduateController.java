/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.graduate.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.persistence.Msg;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.graduate.entity.Graduate;
import com.thinkgem.jeesite.modules.graduate.service.GraduateService;
import com.thinkgem.jeesite.modules.institute.entity.Institute;
import com.thinkgem.jeesite.modules.institute.service.InstituteService;

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
}