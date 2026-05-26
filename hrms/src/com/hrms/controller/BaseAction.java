package com.hrms.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;

public abstract class BaseAction {

    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String method = request.getParameter("method");
        if (method == null || method.isEmpty()) {
            method = "list";
        }
        Method m = this.getClass().getMethod(method, HttpServletRequest.class, HttpServletResponse.class);
        return (String) m.invoke(this, request, response);
    }
}
