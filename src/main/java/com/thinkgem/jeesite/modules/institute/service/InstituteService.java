/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.institute.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.institute.entity.Institute;
import com.thinkgem.jeesite.modules.institute.dao.InstituteDao;

/**
 * 学院管理Service
 * @author chenhong
 * @version 2017-07-25
 */
@Service
@Transactional(readOnly = true)
public class InstituteService extends CrudService<InstituteDao, Institute> {

	public Institute get(String id) {
		return super.get(id);
	}
	
	public List<Institute> findList(Institute institute) {
		return super.findList(institute);
	}
	
	public Page<Institute> findPage(Page<Institute> page, Institute institute) {
		return super.findPage(page, institute);
	}
	
	@Transactional(readOnly = false)
	public void save(Institute institute) {
		super.save(institute);
	}
	
	@Transactional(readOnly = false)
	public void delete(Institute institute) {
		super.delete(institute);
	}
	
}