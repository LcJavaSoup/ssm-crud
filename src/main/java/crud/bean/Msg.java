package crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用提示的类
 */
public class Msg {
    //状态码 100-成功 200-失败
    private int code;
    //提示信息
    private String msg;

    //用户要返回给浏览器的数据
    //在add方法中有getExtend取得键值
    private Map<String,Object> extend = new HashMap<>();

    public static Msg success(){
        //result为了调用setCode和setMsg，并不是浏览器的数据结果，数据在extend中
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }

    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }

    public Msg add(String key,Object value){
        this.getExtend().put(key, value);
        return this;
    }
    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    public int getCode() {

        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
