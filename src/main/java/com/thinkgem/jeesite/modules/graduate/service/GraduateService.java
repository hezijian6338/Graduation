/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.graduate.service;

import java.util.ArrayList;
import java.util.List;

import com.thinkgem.jeesite.modules.institute.entity.Institute;
import com.thinkgem.jeesite.modules.institute.service.InstituteService;
import com.thinkgem.jeesite.modules.sys.dao.RoleDao;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.graduate.entity.Graduate;
import com.thinkgem.jeesite.modules.graduate.dao.GraduateDao;

import static com.thinkgem.jeesite.modules.sys.service.SystemService.entryptPassword;

/**
 * 毕业生信息管理Service
 * @author chenhong
 * @version 2017-07-25
 */
@Service
@Transactional(readOnly = true)
public class GraduateService extends CrudService<GraduateDao, Graduate> {

	@Autowired
	private GraduateDao graduateDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private InstituteService instituteService;
	public Graduate get(String id) {
		return super.get(id);
	}
	
	public List<Graduate> findList(Graduate graduate) {
		return super.findList(graduate);
	}
	
	public Page<Graduate> findPage(Page<Graduate> page, Graduate graduate) {

			if(graduate.getOrgId()!=null) {
				if (graduate.getOrgId().equals("所有学院")) {
					graduate.setOrgId(null);
				}
			}

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

	@Transactional(readOnly = false)
	public void batchDelete(String ids){
		List list = new ArrayList();
		String[] id = ids.split(",");
		for(int i=0;i<id.length;i++){
			list.add(id[i]);
		}
		graduateDao.batchDelete(list);
	}

	public int findByStuNo(Graduate graduate) {
		return graduateDao.selectByStuNo(graduate);
	}

	/**
	 *
	 * @author 许彩开
	 * TODO(注：)
	 * @param page
	 * @param graduate
	 * @return
	 * @return_type Page<Graduate>
	 * @DATE 2017年7月26日
	 */
	public Page<Graduate> findGraduate(Page<Graduate> page, Graduate graduate) {
		// 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
		graduate.getSqlMap().put("dsf", dataScopeFilter(graduate.getCurrentUser(), "o", "a"));
		// 设置分页参数
		graduate.setPage(page);
		// 执行分页查询
		List<Graduate> list=new ArrayList<Graduate>();
		for(Graduate graduate2:graduateDao.findList(graduate)){
			//学院代码的转换
			Institute institute=instituteService.get(graduate2.getOrgId());
			graduate2.setOrgId(institute.getInstituteNo());
			//性别转换 男==1  ，女==2
			if(graduate2.getSex().equals("1")){
				graduate2.setSex("男");
			}else{
				graduate2.setSex("女");
			}
			list.add(graduate2);
		}

		page.setList(list);
		// page.setList(graduateDao.findList(graduate));
		return page;
	}

	/**
	 *
	 * @author 许彩开
	 * TODO(注：根据学号获取Graduate对象)
	 * @param stuNo
	 * @return
	 * @return_type Graduate
	 * @DATE 2017年7月27日
	 */
	public Graduate getByStuNo(String stuNo) {
		Graduate graduate=new Graduate("",stuNo);
		graduate=graduateDao.getByStuNo(graduate);
		return graduate;
	}
	/**
	 * @author 余锡鸿
	 * @TODO (注：根据id获取Graduate对象)
	  * @param id
	 * @DATE: 2017/8/18 16:52
	 */
	public Graduate getStudent(String id) {
		Graduate student = graduateDao.get(id);
		if (student == null){
			return null;
		}
		List<Role> list=roleDao.findStudentRoleByEnname("student");
		student.setRoleList(list);
//			CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + student.getId(), student);
//			CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + student.getStuNo(), student);

		return student;
	}
	/**
	 * @author 余锡鸿
	 * @TODO (注：根据学号获取Graduate对象,并且设置对象拥有的角色列表)
	  * @param stuNo
	 * @DATE: 2017/8/18 10:09
	 */
	public Graduate getStudentBystuNo(String stuNo) {
		Graduate student = graduateDao.getBystuNoAndsetRole(new Graduate(null, stuNo));
		if (student == null){
			return null;
		}
		List<Role> list=roleDao.findStudentRoleByEnname("student");
		student.setRoleList(list);
		//student.setRoleList(roleDao.findList(new Role(user)));
//			CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + student.getId(), student);
//			CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + student.getStuNo(), student);
		return student;
	}
	/**
	 * @author 余锡鸿
	 * @TODO (注：学生修改密码)
	 * @param id
	 * @param newPassword
	 * @DATE: 2017/8/18 16:44
	 */
	@Transactional(readOnly = false)
	public void updateStudentPasswordById(String id,String newPassword) {
		Graduate student = new Graduate(id);
		student.setPassword(entryptPassword(newPassword));
		graduateDao.updatePasswordById(student);
	}


	public List<Graduate> findAllGraduate(Graduate graduate){
		/**
		 * @author 许彩开
		 * @TODO (注：)
		 * @param graduate
		 * @DATE: 2017/8/1 17:17
		 */
		return graduateDao.findList(graduate);
	}

	public void updateByStuNo(Graduate graduate) {
		graduateDao.updateByStuNo(graduate);
	}

}