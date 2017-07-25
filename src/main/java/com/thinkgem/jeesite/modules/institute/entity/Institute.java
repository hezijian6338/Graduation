/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.institute.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 学院管理Entity
 * @author chenhong
 * @version 2017-07-25
 */
public class Institute extends DataEntity<Institute> {
	
	private static final long serialVersionUID = 1L;
	private String instituteNo;		// 学院编号
	private String instituteName;		// 学院名称
	
	public Institute() {
		super();
	}

	public Institute(String id){
		super(id);
	}

	@Length(min=1, max=64, message="学院编号长度必须介于 1 和 64 之间")
	public String getInstituteNo() {
		return instituteNo;
	}

	public void setInstituteNo(String instituteNo) {
		this.instituteNo = instituteNo;
	}
	
	@Length(min=1, max=64, message="学院名称长度必须介于 1 和 64 之间")
	public String getInstituteName() {
		return instituteName;
	}

	public void setInstituteName(String instituteName) {
		this.instituteName = instituteName;
	}
	
}