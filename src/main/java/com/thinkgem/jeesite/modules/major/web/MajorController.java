/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.major.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.modules.institute.entity.Institute;
import com.thinkgem.jeesite.modules.institute.service.InstituteService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.major.entity.Major;
import com.thinkgem.jeesite.modules.major.service.MajorService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 专业信息Controller
 * @author chenhong
 * @version 2017-08-07
 */
@Controller
@RequestMapping(value = "${adminPath}/major/major")
public class MajorController extends BaseController {

	@Autowired
	private MajorService majorService;

	@Autowired
	private InstituteService instituteService;
	
	@ModelAttribute
	public Major get(@RequestParam(required=false) String id) {
		Major entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = majorService.get(id);
		}
		if (entity == null){
			entity = new Major();
		}
		return entity;
	}
	
	@RequiresPermissions("major:major:view")
	@RequestMapping(value = {"list", ""})
	public String list(Major major, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Major> page = majorService.findPage(new Page<Major>(request, response), major); 
		model.addAttribute("page", page);
		return "modules/major/majorList";
	}

	@RequiresPermissions("major:major:view")
	@RequestMapping(value = "form")
	public String form(Major major, Model model) {
		List<Institute> institutes = instituteService.findList(new Institute());
		model.addAttribute("major", major);
		model.addAttribute("institutes", institutes);
		return "modules/major/majorForm";
	}

	@RequiresPermissions("major:major:edit")
	@RequestMapping(value = "save")
	public String save(Major major, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, major)){
			return form(major, model);
		}
		majorService.save(major);
		addMessage(redirectAttributes, "保存专业信息成功");
		return "redirect:"+Global.getAdminPath()+"/major/major/?repage";
	}
	
	@RequiresPermissions("major:major:edit")
	@RequestMapping(value = "delete")
	public String delete(Major major, RedirectAttributes redirectAttributes) {
		majorService.delete(major);
		addMessage(redirectAttributes, "删除专业信息成功");
		return "redirect:"+Global.getAdminPath()+"/major/major/?repage";
	}

	/**
	 * ajax根据学院的id查询出专业
	 */
    @RequiresPermissions("graduate:graduate:view")
	@RequestMapping(value = "findMajor")
	public @ResponseBody Map findMajor(String id) throws Exception{
		Map jsonMap = new HashMap();
		List<Major> majors = majorService.findMajor(id);
		List list = new ArrayList();
        if(majors.size()>0){
            for (Major major : majors) {
                Map majorMap = new HashMap();
                majorMap.put("orgName", major.getMajorName());
                list.add(majorMap);
            }
        }
        else{
            Map majorMap=new HashMap();
            majorMap.put("orgName", null);
            list.add(majorMap);
        }
        jsonMap.put("majors",list);
		return jsonMap;
	}
}