package crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import crud.bean.Employee;
import crud.bean.Msg;
import crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
处理员工CRUD请求
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @ResponseBody
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 按照员工id查询员工
     *
     * @param id
     * @return
     */
    //rest风格的url
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }


    /**
     * 检查用户名是否可用
     *
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName") String empName) {
        //先判断用户名是否合法
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg", "合法校验:用户名不合法");
        }

        //数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名重复校验：不可用");
        }
    }

    /**
     * 员工保存
     * 1、支持JSR303校验
     * 2、导入Hibernate-Validator
     *
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    //@Valid和@Pattern或者@NotBlank等等使用（具体看bean中的注释），校验功能，
    // @Valid获取参数，校验的结果放在BindingResult中
    //继承了error接口，里面有方法为hasErrors,boolean类型
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            //校验失败，
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名：" + fieldError.getField());
                System.out.println("错误的信息：" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 需要导入json包
     *
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(
            @RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //这不是一个分页查询
        //引入PageHelper分页插件
        //在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo查询包装后的结果，只需要把PageInfo交给页面就行
        //封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }
    /**
     * 查询员工数据（分页查询）
     * @return
     */
//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn ,
//                          Model model){
//        //这不是一个分页查询
//        //引入PageHelper分页插件
//        //在查询之前只需要调用，传入页码，以及每页的大小
//        PageHelper.startPage(pn,5);
//        //startPage后面紧跟的这个查询就是一个分页查询
//        List<Employee> emps = employeeService.getAll();
//        //使用PageInfo查询包装后的结果，只需要把PageInfo交给页面就行
//        //封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
//        PageInfo page = new PageInfo(emps,5);
//        //这里面把page给pageInfo（addAttribute里的pageInfo，这个单词换什么都行，前台页面通过${}方式呈现，和其他无关），在前端页面展示
//        model.addAttribute("pageInfo",page);
//        return "list";
//    }
}
