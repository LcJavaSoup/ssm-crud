package crud.bean;

import javax.validation.constraints.Pattern;

public class Employee {


    private Integer empId;

    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",
            message = "jsr303校验，用户不合法")
    private String empName;

    private String gender;

    //https://blog.csdn.net/jinzhencs/article/details/51682830
    //这个网址有各种注解，实现校验功能
    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",
            message = "jsr303校验，邮箱名不合法")
    private String email;

    private Integer dId;

    //希望查询员工的同时部门信息也是查询好的
    private Department department;

    public Employee() {
        super();
    }

    public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
        super();
        this.empId = empId;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
        this.dId = dId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    @Override
    public String toString() {
        return "Employee [empName=" + empName + ", gender=" + gender + ", email=" + email + ", dId=" + dId + "]";
    }
}