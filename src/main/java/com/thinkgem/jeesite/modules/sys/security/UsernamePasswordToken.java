/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sys.security;

/**
 * 用户和密码（包含验证码）令牌类
 * @author ThinkGem
 * @version 2013-5-19
 */
public class UsernamePasswordToken extends org.apache.shiro.authc.UsernamePasswordToken {

	private static final long serialVersionUID = 1L;

	private String captcha;
	private boolean mobileLogin;
	private String chosenRole;
	
	public UsernamePasswordToken() {
		super();
	}

	public UsernamePasswordToken(String username, char[] password,
			boolean rememberMe, String host, String captcha, boolean mobileLogin) {
		super(username, password, rememberMe, host);
		this.captcha = captcha;
		this.mobileLogin = mobileLogin;
	}
	/**
	*@Author:YuXiaoXi
	*@Descriptinon:带有用户选择类型的构造函数
	*@Date:9:45 2017/8/8
	*@return:
	*/
	public UsernamePasswordToken(String username, char[] password,
								 boolean rememberMe, String host, String captcha, boolean mobileLogin,
								 String chosenRole) {
		super(username, password, rememberMe, host);
		this.captcha = captcha;
		this.mobileLogin = mobileLogin;
		this.chosenRole = chosenRole;
	}

	public String getCaptcha() {
		return captcha;
	}

	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}

	public boolean isMobileLogin() {
		return mobileLogin;
	}

	public String getChosenRole() {
		return chosenRole;
	}

	public void setChosenRole(String chosenRole) {
		this.chosenRole = chosenRole;
	}
	
}