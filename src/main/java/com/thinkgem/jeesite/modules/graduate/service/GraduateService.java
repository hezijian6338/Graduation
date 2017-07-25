/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.graduate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.graduate.entity.Graduate;
import com.thinkgem.jeesite.modules.graduate.dao.GraduateDao;

/**
 * 毕业生信息管理Service
 * @author chenhong
 * @version 2017-07-25
 */
@Service
@Transactional(readOnly = true)
public class GraduateService extends CrudService<GraduateDao, Graduate> {

	public Graduate get(String id) {
		return super.get(id);
	}
	
	public List<Graduate> findList(Graduate graduate) {
		return super.findList(graduate);
	}
	
	public Page<Graduate> findPage(Page<Graduate> page, Graduate graduate) {
		return super.findPage(page, graduate);
	}
	
	@Transactional(readOnly = false)
	public void save(Graduate graduate) {
		super.save(graduate);
	}
	
	@Transactional(readOnly = false)
	public void delete(Graduate graduate) {
		super.delete(graduate);
	}
	
}