package com.hrms.dao;

import com.hrms.model.Salary;
import com.hrms.util.DBUtil;
import com.hrms.util.PageBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SalaryDao {

    public PageBean<Salary> findByPage(int pageNum, int pageSize, String keyword, String month) {
        PageBean<Salary> page = new PageBean<>(pageNum, pageSize);
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            where.append(" AND (e.name LIKE ? OR e.emp_no LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (month != null && !month.isEmpty()) {
            where.append(" AND s.month=?");
            params.add(month);
        }

        String countSql = "SELECT COUNT(*) FROM salary s LEFT JOIN employee e ON s.emp_id=e.id" + where;
        String listSql = "SELECT s.*, e.name AS emp_name, e.emp_no, d.name AS dept_name FROM salary s " +
                "LEFT JOIN employee e ON s.emp_id=e.id LEFT JOIN department d ON e.dept_id=d.id" + where + " ORDER BY s.month DESC, s.id DESC LIMIT ?,?";

        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(countSql);
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            rs = ps.executeQuery();
            if (rs.next()) page.setTotalCount(rs.getInt(1));

            ps = conn.prepareStatement(listSql);
            int idx = 1;
            for (Object p : params) ps.setObject(idx++, p);
            ps.setInt(idx++, page.getStartIndex());
            ps.setInt(idx, pageSize);
            rs = ps.executeQuery();
            List<Salary> list = new ArrayList<>();
            while (rs.next()) list.add(mapRow(rs));
            page.setList(list);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return page;
    }

    public Salary findById(int id) {
        String sql = "SELECT s.*, e.name AS emp_name, e.emp_no, d.name AS dept_name FROM salary s " +
                "LEFT JOIN employee e ON s.emp_id=e.id LEFT JOIN department d ON e.dept_id=d.id WHERE s.id=?";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return null;
    }

    public boolean insert(Salary sal) {
        String sql = "INSERT INTO salary (emp_id,month,base_salary,bonus,allowance,overtime_pay,deduction,insurance,tax,actual_salary,status,remark) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, sal.getEmpId());
            ps.setString(2, sal.getMonth());
            ps.setDouble(3, sal.getBaseSalary());
            ps.setDouble(4, sal.getBonus());
            ps.setDouble(5, sal.getAllowance());
            ps.setDouble(6, sal.getOvertimePay());
            ps.setDouble(7, sal.getDeduction());
            ps.setDouble(8, sal.getInsurance());
            ps.setDouble(9, sal.getTax());
            ps.setDouble(10, sal.getActualSalary());
            ps.setInt(11, sal.getStatus());
            ps.setString(12, sal.getRemark());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean update(Salary sal) {
        String sql = "UPDATE salary SET base_salary=?,bonus=?,allowance=?,overtime_pay=?,deduction=?,insurance=?,tax=?,actual_salary=?,status=?,remark=? WHERE id=?";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setDouble(1, sal.getBaseSalary());
            ps.setDouble(2, sal.getBonus());
            ps.setDouble(3, sal.getAllowance());
            ps.setDouble(4, sal.getOvertimePay());
            ps.setDouble(5, sal.getDeduction());
            ps.setDouble(6, sal.getInsurance());
            ps.setDouble(7, sal.getTax());
            ps.setDouble(8, sal.getActualSalary());
            ps.setInt(9, sal.getStatus());
            ps.setString(10, sal.getRemark());
            ps.setInt(11, sal.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM salary WHERE id=?";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    private Salary mapRow(ResultSet rs) throws SQLException {
        Salary s = new Salary();
        s.setId(rs.getInt("id"));
        s.setEmpId(rs.getInt("emp_id"));
        s.setMonth(rs.getString("month"));
        s.setBaseSalary(rs.getDouble("base_salary"));
        s.setBonus(rs.getDouble("bonus"));
        s.setAllowance(rs.getDouble("allowance"));
        s.setOvertimePay(rs.getDouble("overtime_pay"));
        s.setDeduction(rs.getDouble("deduction"));
        s.setInsurance(rs.getDouble("insurance"));
        s.setTax(rs.getDouble("tax"));
        s.setActualSalary(rs.getDouble("actual_salary"));
        s.setStatus(rs.getInt("status"));
        s.setRemark(rs.getString("remark"));
        s.setCreateTime(rs.getTimestamp("create_time"));
        try { s.setEmpName(rs.getString("emp_name")); } catch (SQLException e) {}
        try { s.setEmpNo(rs.getString("emp_no")); } catch (SQLException e) {}
        try { s.setDeptName(rs.getString("dept_name")); } catch (SQLException e) {}
        return s;
    }
}
