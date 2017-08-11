/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.major.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.major.entity.Major;

import java.util.List;

/**
 * 专业信息DAO接口
 * @author chenhong
 * @version 2017-08-07
 */
@MyBatisDao
public interface MajorDao extends CrudDao<Major> {
    public List<Major> findMajor(String id);
}