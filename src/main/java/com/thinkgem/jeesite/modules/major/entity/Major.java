/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.major.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 专业信息Entity
 * @author chenhong
 * @version 2017-08-07
 */
public class Major extends DataEntity<Major> {
	
	private static final long serialVersionUID = 1L;
	private String majorNo;		// 专业代码
	private String majorName;		// 专业名称
	private String orgId;		// 归属学院id
	private String orgName;		//所属学院名称
	
	public Major() {
		super();
	}

	public Major(String id){
		super(id);
	}

	@Length(min=1, max=64, message="专业代码长度必须介于 1 和 64 之间")
	public String getMajorNo() {
		return majorNo;
	}

	public void setMajorNo(String majorNo) {
		this.majorNo = majorNo;
	}
	
	@Length(min=1, max=64, message="专业名称长度必须介于 1 和 64 之间")
	public String getMajorName() {
		return majorName;
	}

	public void setMajorName(String majorName) {
		this.majorName = majorName;
	}
	
	@Length(min=1, max=64, message="归属学院id长度必须介于 1 和 64 之间")
	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	@Length(min=1, max=64, message="所属学院名称长度必须介于 1 和 64 之间")
	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
}