package crud.test;

import crud.bean.Employee;
import crud.dao.DepartmentMapper;
import crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/*
测试dao层的工作
推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
* 1.导入SpringTest模块
* 2.@ContextConfiguration指定Spring配置文件的位置
* 3.直接autowired要使用的组件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    /*
    测试DepartmentMapper
     */
    @Test
    public void testCRUD() {
        /*
        1.创建SpringIOC容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext("application.xml");
        //2.从容器中获取mapper
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
        */
        System.out.println(departmentMapper);

//        1.插入几个部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));

//        2.生成员工数据，测试员工插入
        //employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jetty@atguigu.com", 1));

        //3.批量生成员工数据
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            /*
            public static String getUUID32(){
    String uuid = UUID.randomUUID().toString().replace("-", "").toLowerCase();
    return uuid;
//  return UUID.randomUUID().toString().replace("-", "").toLowerCase();
}

注：因为一般数据库主键为String类型，所以接收类型为String，生成的uuid数据包含-，所以要去掉-，故UUID.randomUUID().toString().replace("-", "").toLowerCase()
             */
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uid, "M", uid + "@atguigu.com", 1));
        }
        System.out.println("批量完成");
    }
}
