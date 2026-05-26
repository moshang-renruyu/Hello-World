package com.hrms.dao;

import com.hrms.model.Attendance;
import com.hrms.util.DBUtil;
import com.hrms.util.PageBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDao {

    public PageBean<Attendance> findByPage(int pageNum, int pageSize, String keyword, String workDate) {
        PageBean<Attendance> page = new PageBean<>(pageNum, pageSize);
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            where.append(" AND (e.name LIKE ? OR e.emp_no LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (workDate != null && !workDate.isEmpty()) {
            where.append(" AND a.work_date=?");
            params.add(workDate);
        }

        String countSql = "SELECT COUNT(*) FROM attendance a LEFT JOIN employee e ON a.emp_id=e.id" + where;
        String listSql = "SELECT a.*, e.name AS emp_name, e.emp_no, d.name AS dept_name FROM attendance a " +
                "LEFT JOIN employee e ON a.emp_id=e.id LEFT JOIN department d ON e.dept_id=d.id" + where + " ORDER BY a.work_date DESC, a.id DESC LIMIT ?,?";

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
            List<Attendance> list = new ArrayList<>();
            while (rs.next()) list.add(mapRow(rs));
            page.setList(list);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return page;
    }

    public boolean insert(Attendance att) {
        String sql = "INSERT INTO attendance (emp_id, work_date, check_in, check_out, status, remark) VALUES (?,?,?,?,?,?)";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, att.getEmpId());
            ps.setObject(2, att.getWorkDate());
            ps.setString(3, att.getCheckIn());
            ps.setString(4, att.getCheckOut());
            ps.setInt(5, att.getStatus());
            ps.setString(6, att.getRemark());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean update(Attendance att) {
        String sql = "UPDATE attendance SET check_in=?, check_out=?, status=?, remark=? WHERE id=?";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, att.getCheckIn());
            ps.setString(2, att.getCheckOut());
            ps.setInt(3, att.getStatus());
            ps.setString(4, att.getRemark());
            ps.setInt(5, att.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM attendance WHERE id=?";
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

    public Attendance findById(int id) {
        String sql = "SELECT a.*, e.name AS emp_name, e.emp_no, d.name AS dept_name FROM attendance a " +
                "LEFT JOIN employee e ON a.emp_id=e.id LEFT JOIN department d ON e.dept_id=d.id WHERE a.id=?";
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

    public int countTodayNormal() {
        String sql = "SELECT COUNT(*) FROM attendance WHERE work_date=CURDATE() AND status=1";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return 0;
    }

    public int countTodayLate() {
        String sql = "SELECT COUNT(*) FROM attendance WHERE work_date=CURDATE() AND status=2";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return 0;
    }

    private Attendance mapRow(ResultSet rs) throws SQLException {
        Attendance a = new Attendance();
        a.setId(rs.getInt("id"));
        a.setEmpId(rs.getInt("emp_id"));
        a.setWorkDate(rs.getDate("work_date"));
        a.setCheckIn(rs.getString("check_in"));
        a.setCheckOut(rs.getString("check_out"));
        a.setStatus(rs.getInt("status"));
        a.setRemark(rs.getString("remark"));
        a.setCreateTime(rs.getTimestamp("create_time"));
        try { a.setEmpName(rs.getString("emp_name")); } catch (SQLException e) {}
        try { a.setEmpNo(rs.getString("emp_no")); } catch (SQLException e) {}
        try { a.setDeptName(rs.getString("dept_name")); } catch (SQLException e) {}
        return a;
    }
}
