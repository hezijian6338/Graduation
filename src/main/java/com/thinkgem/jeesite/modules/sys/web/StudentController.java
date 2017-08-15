package com.thinkgem.jeesite.modules.sys.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.thinkgem.jeesite.modules.graduate.entity.Graduate;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
/**
*@Author:YuXiaoXi
*@Descriptinon:学生用户Controll
*@Date:13:56 2017/8/14
*@return:
*/
@Controller
@RequestMapping(value = "${adminPath}/sys/student")
public class StudentController extends BaseController{

    @Autowired
    private SystemService systemService;

    @ModelAttribute
    public Graduate get(@RequestParam(required=false) String id) {//
        if (StringUtils.isNotBlank(id)){
            return systemService.getStudent(id);
        }else{
            return new Graduate();
        }
    }

    /**
     * 用户信息显示及保存
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = "info")
    public String info(Graduate student, HttpServletResponse response, Model model) {
        Graduate currentStudent = UserUtils.getStudent();
        model.addAttribute("student", currentStudent);
        model.addAttribute("Global", new Global());
        return "modules/sys/studentInfo";
    }

    /**
     * 返回用户信息
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "infoData")
    public Graduate infoData() {
        return  UserUtils.getStudent();
    }

    /**
     * 修改个人用户密码
     * @param oldPassword
     * @param newPassword
     * @param model
     * @return
     */
 	@RequiresPermissions("user")
    @RequestMapping(value = "modifyPwd")
    public String modifyPwd(String oldPassword, String newPassword, Model model) {
        Graduate student = UserUtils.getStudent();
        if (StringUtils.isNotBlank(oldPassword) && StringUtils.isNotBlank(newPassword)){
            if (SystemService.validatePassword(oldPassword, student.getPassword())){
                systemService.updateStudentPasswordById(student.getId(), newPassword);
                model.addAttribute("message", "修改密码成功");
            }else{
                model.addAttribute("message", "修改密码失败，旧密码错误");
            }
        }
        model.addAttribute("student", student);
        return "modules/sys/studentModifyPwd";
    }
}
