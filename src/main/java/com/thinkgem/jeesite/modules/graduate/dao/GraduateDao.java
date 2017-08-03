/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.graduate.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.graduate.entity.Graduate;

import java.util.List;

/**
 * 毕业生信息管理DAO接口
 * @author chenhong
 * @version 2017-07-25
 */
@MyBatisDao
public interface GraduateDao extends CrudDao<Graduate> {
	public void batchDelete(List<String> list);

	public int selectByStuNo(Graduate graduate);

	public Graduate getByStuNo(Graduate graduate);
}