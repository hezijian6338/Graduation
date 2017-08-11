/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.major.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.major.entity.Major;
import com.thinkgem.jeesite.modules.major.dao.MajorDao;

/**
 * 专业信息Service
 * @author chenhong
 * @version 2017-08-07
 */
@Service
@Transactional(readOnly = true)
public class MajorService extends CrudService<MajorDao, Major> {
	@Autowired
	private MajorDao majorDao;

	public Major get(String id) {
		return super.get(id);
	}
	
	public List<Major> findList(Major major) {
		return super.findList(major);
	}
	
	public Page<Major> findPage(Page<Major> page, Major major) {
		return super.findPage(page, major);
	}
	
	@Transactional(readOnly = false)
	public void save(Major major) {
		super.save(major);
	}
	
	@Transactional(readOnly = false)
	public void delete(Major major) {
		super.delete(major);
	}

	/**
	 * 根据学院id查询出专业
	 */
	public List<Major> findMajor(String id) {
		return majorDao.findMajor(id);
	}
}