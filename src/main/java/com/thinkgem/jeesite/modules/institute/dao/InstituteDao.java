/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.institute.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.institute.entity.Institute;

/**
 * 学院管理DAO接口
 * @author chenhong
 * @version 2017-07-25
 */
@MyBatisDao
public interface InstituteDao extends CrudDao<Institute> {
    public Institute getInstituteByOrgId(String orgId);
}