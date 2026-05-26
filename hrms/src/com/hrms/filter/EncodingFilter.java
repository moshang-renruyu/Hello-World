package com.hrms.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**

 * 【功能说明】
 * 统一设置请求和响应的字符编码为UTF-8
 * 解决中文乱码问题
 * 修复：不对CSS/JS等静态资源设置text/html响应头，避免样式失效
 */
@WebFilter(filterName = "EncodingFilter", urlPatterns = "/*")
public class EncodingFilter implements Filter {

    /**
     * 【1】初始化方法
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("【EncodingFilter】字符编码过滤器初始化完成");
    }

    /**
     * 【1】过滤方法（核心方法，已修复Content-Type覆盖问题）
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 1. 获取请求URI，用于判断是否为CSS/JS等静态资源
        String requestUri = httpRequest.getRequestURI();
        // 定义需要排除的静态资源后缀
        String[] staticSuffixes = {".css", ".js", ".png", ".jpg", ".jpeg", ".gif", ".ico"};
        // 标记是否为静态资源
        boolean isStaticResource = false;

        // 2. 遍历判断当前请求是否是静态资源
        for (String suffix : staticSuffixes) {
            if (requestUri.endsWith(suffix)) {
                isStaticResource = true;
                break;
            }
        }

        // 3. 【所有请求都要设置】请求字符编码，解决POST中文乱码
        httpRequest.setCharacterEncoding("UTF-8");

        // 4. 【仅非静态资源设置】响应编码和Content-Type，避免覆盖CSS的MIME类型
        if (!isStaticResource) {
            httpResponse.setCharacterEncoding("UTF-8");
            httpResponse.setContentType("text/html;charset=UTF-8");
        }

        // 5. 放行请求
        chain.doFilter(request, response);
    }

    /**
     * 【1】销毁方法
     */
    @Override
    public void destroy() {
        System.out.println("【EncodingFilter】字符编码过滤器已销毁");
    }
}