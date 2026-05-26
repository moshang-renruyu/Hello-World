package com.hrms.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class OnlineCountListener implements HttpSessionListener {

    private static int onlineCount = 0;

    @Override
    public void sessionCreated(HttpSessionEvent event) {
        onlineCount++;
        event.getSession().getServletContext().setAttribute("onlineCount", onlineCount);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        if (onlineCount > 0) {
            onlineCount--;
        }
        event.getSession().getServletContext().setAttribute("onlineCount", onlineCount);
    }

    public static int getOnlineCount() {
        return onlineCount;
    }
}
