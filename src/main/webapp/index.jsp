<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>员工列表</title>
    <%
        request.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!--web路径:
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准（http://localhost:3306);需要加上项目名
                  http://localhost:3306/crud
    -->

    <!--Bootstrap和jQuery的引入-->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!--Bootstrap依赖jQuery,所以要把jQuery放前面,以免Bootstrap在jQuery使用时没法使用，很操蛋，模态框一直没法调用就是因为这个破问题-->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!--员工修改的模态框-->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="true"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交Id即可-->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="true"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交Id即可-->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!--搭建显示页面-->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class=".col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮-->
    <div classs="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <!--  显示表格数据  -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emp_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">
        </div>
        <!--分页条信息-->
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord;

    $(function () {
        to_page(1);
    })

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            //function中的result代表服务器返回的数据，和Msg类中的result无关
            success: function (result) {
                //console.log(result);
                //1、解析显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条信息
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //清空
        $("#emp_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptName = $("<td></td>").append(item.department.deptName);
            /**
             * <botton class="btn btn-primary btn-sm">
             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
             </botton>
             * @type {*|jQuery}
             */
            var editBtn = $("<botton></botton>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-pencil")
                .append("编辑");
            //为编辑按钮添加属性，来表示当前id
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<botton></botton>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-trash")
                .append("删除");
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptName)
                .append(btnTd)
                .appendTo("#emp_table tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append(
            "当前第 " + result.extend.pageInfo.pageNum + " 页" + " 总 "
            + result.extend.pageInfo.pages + " 页" + " 总 "
            + result.extend.pageInfo.total + " 条记录");
        totalRecord = result.extend.pageInfo.pages;
    }

    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }

        firstPageLi.click(function () {
            to_page(1);
        })

        prePageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum - 1);
        })

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));

        nextPageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum + 1);
        })

        lastPageLi.click(function () {
            to_page(result.extend.pageInfo.pages);
        })
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }

            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //表单重置（完整重置）
        reset_form("#myModal form")
        $("#myModal").modal({
            backdrop: "static"
        });
        getDepts("#myModal select");
    });

    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                //console.log(result)
                // $("#dept_add_select").append("")
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele)
                })
            }
        })
    }

    //检验表单数据
    function validate_add_form() {
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            //alert("请正确输入姓名");
            show_validate_msg("#empName_add_input", "error", "请正确输入姓名")
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "")
        }
        ;
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("请正确输入邮箱")
            //清除之前的样式才行
            show_validate_msg("#email_add_input", "error", "请正确输入邮箱地址")
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    function show_validate_msg(ele, status, msg) {
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户名是否可用
    //change方法是触发了$("#empName_add_input")事件就发生，jQuery的一个常用方法
    $("#empName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用
        //this.value 获取 dom对象的值 如 text radio checkbox select 等
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: "empName=" + empName,
            //web.xml中有拦截器
            type: "POST",
            //function中的result代表服务器返回的数据，和Msg类中的result无关
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        })
    });
    $("#emp_save_btn").click(function () {
        //校验
        if (!validate_add_form()) {
            return false;
        } else if ($(this).attr("ajax-va") == "error") {
            return false;
        } else {
            $.ajax({
                    url: "${APP_PATH}/emp",
                    type: "POST",
                    data: $("#myModal form").serialize(),
                    success: function (result) {
                        if (result.code == 100) {
                            $("#myModal").modal("hide");
                            to_page(totalRecord);
                        } else {
                            // console.log(result);
                            //有哪个字段的错误信息就显示哪个字段的；
                            if (undefined != result.extend.errorFields.email) {
                                //显示邮箱错误信息
                                show_validate_msg("#email_add_input", "error", result.extend.errorFields.email)
                            }
                            if (undefined != result.extend.errorFields.empName) {
                                show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName)
                            }
                        }
                    }
                }
            )
        }
    });
    //这里绑定事件要注意,是之后添上去的标签，所以用on绑定单击事件
    $(document).on("click",".edit_btn",function () {
        //alert("fsf")
        //1、查出部门信息，显示部门列表
        getDepts("#empUpdateModal select");
        //3、把员工id传递给更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        //2、查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop:"static"
        })
    });
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/" + id,
            type:"GET",
            success:function (result) {
                // console.log(result)
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                //.val() 能够取到 针对text，hidden可输入的文本框的value值。
                // 而 .attr('value') 可以取到html元素中所设置的属性 value的值，不能获取动态的如input type="text" 的文本框手动输入的值
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name = gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        })
    }

    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        //1、校验邮箱信息
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("请正确输入邮箱")
            //清除之前的样式才行
            show_validate_msg("#email_update_input", "error", "请正确输入邮箱地址")
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        alert("aaa")
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"POST",
            data:$("#empUpdateModal form").serialize()+"&_method=PUT",
            success:function (result) {
                alert(result.msg);
            }
        })
    })
</script>
</body>
</html>