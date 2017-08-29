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
	 * @author 许彩开
	 * @TODO (注：导出选中的学生)
	  * @param list
	 * @DATE: 2017\8\21 0021 11:40
	 */

	public List<Graduate> exportSelectGraduateList(List<String> list);
	/**
	*@Author:YuXiaoXi
	*@Descriptinon:根据学号查找学生
	*@Date:9:19 2017/8/8
	 * @param student
	*@return:
	*/


	public Graduate getBystuNoAndsetRole(Graduate student);

	public int selectByStuNo(Graduate graduate);

	public Graduate getByStuNo(Graduate graduate);

	public int updatePasswordById(Graduate student);

	public Graduate getByStuNo(String stuNum);

//	练浩文 2017.08.28 通过学号插入学生头像路径
	public void updateGraByStuNo(Graduate graduate);

	//	练浩文 2017.08.28 通过学号插入学生头像路径
	public void updateDegreeByStuNo(Graduate graduate);

	//	练浩文 2017.08.08 通过学号插入学生头像路径
	public void updateByStuNo(Graduate graduate);


}