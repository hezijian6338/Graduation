/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.Menu;

/**
 * 菜单DAO接口
 * @author ThinkGem
 * @version 2014-05-16
 */
@MyBatisDao
public interface MenuDao extends CrudDao<Menu> {

	public List<Menu> findByParentIdsLike(Menu menu);

	public List<Menu> findByUserId(Menu menu);
	/**
	*@Author:YuXiaoXi
	*@Descriptinon:根据学生角色查找权限菜单列表
	*@Date:9:21 2017/8/8
	 * @param enname
	*@return:
	*/
	public List<Menu> findByStudentRoleList(String enname);

	public int updateParentIds(Menu menu);
	
	public int updateSort(Menu menu);
	
}
