/**
 * Created by yd on 2016/3/13.
 */
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LogoutServlet extends HttpServlet {
    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
            throws ServletException, IOException {
        // 获取参数
        String sessionId = request.getParameter("sessionId");
        String returnMsg = null;
        if (sessionId.equals("asdf1234")) {
            returnMsg = "{"
                    + "\"errorCode\": 0,"
                    + "\"errorMsg:\": \"\","
                    + "\"result\": {}"
                    + "}";
        } else {
            returnMsg = "{"
                    + "\"errorCode\": 101,"
                    + "\"errorMsg:\": \"parameter error\","
                    + "\"result\": \"{}\""
                    + "}";
        }
        // 设置响应内容类型
        response.setContentType("application/json");
        // 返回消息
        PrintWriter out = response.getWriter();
        out.println(returnMsg);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
