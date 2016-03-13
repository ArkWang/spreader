/**
 * Created by yd on 2016/3/12.
 */
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {
    private String message;

    public void init() throws ServletException
    {
        // 执行必需的初始化
        message = "Login Success";
    }

    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
            throws ServletException, IOException
    {
        // 获取参数
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        String returnMsg = null;
        if (mobile.equals("18100001111") && password.equals("123456"))
        {
             returnMsg = "{"
                     + "\"errorCode\": 0,"
                     + "\"errorMsg:\": \"\","
                     + "\"result\": {\"sessionId\": \"asdf1234\"}"
                     + "}";
        } else {
            returnMsg = "{"
                    + "\"errorCode\": 101,"
                    + "\"errorMsg:\": \"wrong password\","
                    + "\"result\": {}"
                    + "}";
        }
        // 设置响应内容类型
        response.setContentType("application/json");
        // 返回消息
        PrintWriter out = response.getWriter();
        out.println(returnMsg);
    }

    public void destroy()
    {
        // 什么也不做
    }
}
