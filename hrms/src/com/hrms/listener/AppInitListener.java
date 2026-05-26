package com.hrms.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class AppInitListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        event.getServletContext().setAttribute("appName", "HRMS人事管理系统");
        event.getServletContext().setAttribute("appVersion", "1.0");
        event.getServletContext().setAttribute("onlineCount", 0);
        System.out.println("[HRMS] 系统初始化完成");
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        System.out.println("[HRMS] 系统已关闭");
    }
}
