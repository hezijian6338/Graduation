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
	/**
	*@Author:YuXiaoXi
	*@Descriptinon:根据学号查找学生
	*@Date:9:19 2017/8/8
	 * @param student
	*@return:
	*/
	public Graduate getBystuNo1(Graduate student);

	public int selectByStuNo(Graduate graduate);

	public Graduate getByStuNo(Graduate graduate);

	public int updatePasswordById(Graduate student);

}