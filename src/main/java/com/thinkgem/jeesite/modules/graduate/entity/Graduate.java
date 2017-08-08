/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.graduate.entity;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.utils.Collections3;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.common.utils.excel.fieldtype.RoleListType;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 毕业生信息管理Entity
 * @author chenhong
 * @version 2017-07-25
 */
public class Graduate extends DataEntity<Graduate> {
	
	private static final long serialVersionUID = 1L;
	private String stuNo;		// 学号
	private String password;		// 密码
	private String stuName;		// 姓名
	private String sex;		// 性别
	private Date birthday;		// 出生日期
	private String idcardNo;		// 身份证号
	private String stuImg;		// 学生头像
	private String collegeId;		// 院系代码
	private String collegeName;		// 院系名称
	private String orgId;		// 学院代码
	private String orgName;		// 学院名称
	private String major;		// 专业代码
	private String majorName;		// 专业名称
	private String learningForm;		// 学习形式
	private String arrangement;		// 层次
	private Date acceptanceDate;		// 入学日期
	private Date graduationDate;		// 毕业日期
	private Integer eduSystem;		// 学制
	private String graConclusion;		// 毕结业结论
	private String graCertificateNo;		// 毕业证书编号
	private String degreeCertificateNo;		// 学位证书编号
	private String session;		// 届别
	private Integer cet4;		// 四级成绩
	private Integer cet6;		// 六级成绩
	private String cet4CertificateNo;		// 四级证书编号
	private String cet6CertificateNo;		// 六级证书编号
	private String degreeName;		// 学士学位名称
	private String lastNameEn;		// 姓(英文)
	private String firstNameEn;		// 名(英文)
	private String sexEn;		// 性别(英文)
	private String birthdayEn;		// 生日(英文)
	private String majorNameEn;		// 专业名称(英文)
	private String degreeNameEn;		// 学士学位(英文)

	private String oldLoginIp;	// 上次登陆IP
	private Date oldLoginDate;	// 上次登陆日期

	private Role role;	// 根据角色查询用户条件

	private List<Role> roleList = Lists.newArrayList(); // 拥有角色列表
	
	public Graduate() {
		super();
	}

	public Graduate(String id){
		super(id);
	}

	public Graduate(String id, String stuNo){
		super(id);
		this.stuNo = stuNo;
	}

	@Length(min=1, max=20, message="学号长度必须介于 1 和 20 之间")
	public String getStuNo() {
		return stuNo;
	}

	public void setStuNo(String stuNo) {
		this.stuNo = stuNo;
	}
	
	@Length(min=0, max=20, message="密码长度必须介于 0 和 20 之间")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	@Length(min=0, max=20, message="姓名长度必须介于 0 和 20 之间")
	public String getStuName() {
		return stuName;
	}

	public void setStuName(String stuName) {
		this.stuName = stuName;
	}
	
	@Length(min=0, max=10, message="性别长度必须介于 0 和 10 之间")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	
	@Length(min=0, max=64, message="身份证号长度必须介于 0 和 64 之间")
	public String getIdcardNo() {
		return idcardNo;
	}

	public void setIdcardNo(String idcardNo) {
		this.idcardNo = idcardNo;
	}
	
	@Length(min=0, max=50, message="学生头像长度必须介于 0 和 50 之间")
	public String getStuImg() {
		return stuImg;
	}

	public void setStuImg(String stuImg) {
		this.stuImg = stuImg;
	}
	
	@Length(min=0, max=64, message="院系代码长度必须介于 0 和 64 之间")
	public String getCollegeId() {
		return collegeId;
	}

	public void setCollegeId(String collegeId) {
		this.collegeId = collegeId;
	}
	
	@Length(min=0, max=64, message="院系名称长度必须介于 0 和 64 之间")
	public String getCollegeName() {
		return collegeName;
	}

	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}
	
	@Length(min=0, max=64, message="学院代码长度必须介于 0 和 64 之间")
	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	
	@Length(min=0, max=64, message="学院名称长度必须介于 0 和 64 之间")
	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	
	@Length(min=0, max=64, message="专业代码长度必须介于 0 和 64 之间")
	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}
	
	@Length(min=0, max=64, message="专业名称长度必须介于 0 和 64 之间")
	public String getMajorName() {
		return majorName;
	}

	public void setMajorName(String majorName) {
		this.majorName = majorName;
	}
	
	@Length(min=0, max=64, message="学习形式长度必须介于 0 和 64 之间")
	public String getLearningForm() {
		return learningForm;
	}

	public void setLearningForm(String learningForm) {
		this.learningForm = learningForm;
	}
	
	@Length(min=0, max=64, message="层次长度必须介于 0 和 64 之间")
	public String getArrangement() {
		return arrangement;
	}

	public void setArrangement(String arrangement) {
		this.arrangement = arrangement;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getAcceptanceDate() {
		return acceptanceDate;
	}

	public void setAcceptanceDate(Date acceptanceDate) {
		this.acceptanceDate = acceptanceDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getGraduationDate() {
		return graduationDate;
	}

	public void setGraduationDate(Date graduationDate) {
		this.graduationDate = graduationDate;
	}
	
	public Integer getEduSystem() {
		return eduSystem;
	}

	public void setEduSystem(Integer eduSystem) {
		this.eduSystem = eduSystem;
	}
	
	@Length(min=0, max=64, message="毕结业结论长度必须介于 0 和 64 之间")
	public String getGraConclusion() {
		return graConclusion;
	}

	public void setGraConclusion(String graConclusion) {
		this.graConclusion = graConclusion;
	}
	
	@Length(min=0, max=64, message="毕业证书编号长度必须介于 0 和 64 之间")
	public String getGraCertificateNo() {
		return graCertificateNo;
	}

	public void setGraCertificateNo(String graCertificateNo) {
		this.graCertificateNo = graCertificateNo;
	}
	
	@Length(min=0, max=64, message="学位证书编号长度必须介于 0 和 64 之间")
	public String getDegreeCertificateNo() {
		return degreeCertificateNo;
	}

	public void setDegreeCertificateNo(String degreeCertificateNo) {
		this.degreeCertificateNo = degreeCertificateNo;
	}
	
	@Length(min=0, max=32, message="届别长度必须介于 0 和 32 之间")
	public String getSession() {
		return session;
	}

	public void setSession(String session) {
		this.session = session;
	}
	
	public Integer getCet4() {
		return cet4;
	}

	public void setCet4(Integer cet4) {
		this.cet4 = cet4;
	}
	
	public Integer getCet6() {
		return cet6;
	}

	public void setCet6(Integer cet6) {
		this.cet6 = cet6;
	}
	
	@Length(min=0, max=64, message="四级证书编号长度必须介于 0 和 64 之间")
	public String getCet4CertificateNo() {
		return cet4CertificateNo;
	}

	public void setCet4CertificateNo(String cet4CertificateNo) {
		this.cet4CertificateNo = cet4CertificateNo;
	}
	
	@Length(min=0, max=64, message="六级证书编号长度必须介于 0 和 64 之间")
	public String getCet6CertificateNo() {
		return cet6CertificateNo;
	}

	public void setCet6CertificateNo(String cet6CertificateNo) {
		this.cet6CertificateNo = cet6CertificateNo;
	}
	
	@Length(min=0, max=64, message="学士学位名称长度必须介于 0 和 64 之间")
	public String getDegreeName() {
		return degreeName;
	}

	public void setDegreeName(String degreeName) {
		this.degreeName = degreeName;
	}
	
	@Length(min=0, max=10, message="姓(英文)长度必须介于 0 和 10 之间")
	public String getLastNameEn() {
		return lastNameEn;
	}

	public void setLastNameEn(String lastNameEn) {
		this.lastNameEn = lastNameEn;
	}
	
	@Length(min=0, max=10, message="名(英文)长度必须介于 0 和 10 之间")
	public String getFirstNameEn() {
		return firstNameEn;
	}

	public void setFirstNameEn(String firstNameEn) {
		this.firstNameEn = firstNameEn;
	}
	
	@Length(min=0, max=10, message="性别(英文)长度必须介于 0 和 10 之间")
	public String getSexEn() {
		return sexEn;
	}

	public void setSexEn(String sexEn) {
		this.sexEn = sexEn;
	}
	
	@Length(min=0, max=20, message="生日(英文)长度必须介于 0 和 20 之间")
	public String getBirthdayEn() {
		return birthdayEn;
	}

	public void setBirthdayEn(String birthdayEn) {
		this.birthdayEn = birthdayEn;
	}
	
	@Length(min=0, max=64, message="专业名称(英文)长度必须介于 0 和 64 之间")
	public String getMajorNameEn() {
		return majorNameEn;
	}

	public void setMajorNameEn(String majorNameEn) {
		this.majorNameEn = majorNameEn;
	}
	
	@Length(min=0, max=64, message="学士学位(英文)长度必须介于 0 和 64 之间")
	public String getDegreeNameEn() {
		return degreeNameEn;
	}

	public void setDegreeNameEn(String degreeNameEn) {
		this.degreeNameEn = degreeNameEn;
	}


	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	@JsonIgnore
	@ExcelField(title="拥有角色", align=1, sort=800, fieldType=RoleListType.class)
	public List<Role> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}

	@JsonIgnore
	public List<String> getRoleIdList() {
		List<String> roleIdList = Lists.newArrayList();
		for (Role role : roleList) {
			roleIdList.add(role.getId());
		}
		return roleIdList;
	}

	public void setRoleIdList(List<String> roleIdList) {
		roleList = Lists.newArrayList();
		for (String roleId : roleIdList) {
			Role role = new Role();
			role.setId(roleId);
			roleList.add(role);
		}
	}

	/**
	 * 用户拥有的角色名称字符串, 多个角色名称用','分隔.
	 */
	public String getRoleNames() {
		return Collections3.extractToString(roleList, "name", ",");
	}


	public String getOldLoginIp() {
		return oldLoginIp;
	}

	public void setOldLoginIp(String oldLoginIp) {
		this.oldLoginIp = oldLoginIp;
	}

	public Date getOldLoginDate() {
		return oldLoginDate;
	}

	public void setOldLoginDate(Date oldLoginDate) {
		this.oldLoginDate = oldLoginDate;
	}
	
}