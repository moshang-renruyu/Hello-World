package com.hrms.dao;

import com.hrms.model.LeaveRequest;
import com.hrms.util.DBUtil;
import com.hrms.util.PageBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LeaveDao {

    public PageBean<LeaveRequest> findByPage(int pageNum, int pageSize, String keyword, int status) {
        PageBean<LeaveRequest> page = new PageBean<>(pageNum, pageSize);
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            where.append(" AND (e.name LIKE ? OR e.emp_no LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (status >= 0) { where.append(" AND l.status=?"); params.add(status); }

        String countSql = "SELECT COUNT(*) FROM leave_request l LEFT JOIN employee e ON l.emp_id=e.id" + where;
        String listSql = "SELECT l.*, e.name AS emp_name, e.emp_no, d.name AS dept_name FROM leave_request l " +
                "LEFT JOIN employee e ON l.emp_id=e.id LEFT JOIN department d ON e.dept_id=d.id" + where + " ORDER BY l.create_time DESC LIMIT ?,?";

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
            List<LeaveRequest> list = new ArrayList<>();
            while (rs.next()) list.add(mapRow(rs));
            page.setList(list);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return page;
    }

    public LeaveRequest findById(int id) {
        String sql = "SELECT l.*, e.name AS emp_name, e.emp_no, d.name AS dept_name FROM leave_request l " +
                "LEFT JOIN employee e ON l.emp_id=e.id LEFT JOIN department d ON e.dept_id=d.id WHERE l.id=?";
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

    public boolean insert(LeaveRequest lr) {
        String sql = "INSERT INTO leave_request (emp_id,type,start_date,end_date,days,reason,attachment,status) VALUES (?,?,?,?,?,?,?,0)";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, lr.getEmpId());
            ps.setInt(2, lr.getType());
            ps.setObject(3, lr.getStartDate());
            ps.setObject(4, lr.getEndDate());
            ps.setDouble(5, lr.getDays());
            ps.setString(6, lr.getReason());
            ps.setString(7, lr.getAttachment());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean approve(int id, int status, int approverId, String remark) {
        String sql = "UPDATE leave_request SET status=?, approver_id=?, approve_time=NOW(), approve_remark=? WHERE id=?";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, approverId);
            ps.setString(3, remark);
            ps.setInt(4, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM leave_request WHERE id=?";
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

    public int countPending() {
        String sql = "SELECT COUNT(*) FROM leave_request WHERE status=0";
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

    private LeaveRequest mapRow(ResultSet rs) throws SQLException {
        LeaveRequest l = new LeaveRequest();
        l.setId(rs.getInt("id"));
        l.setEmpId(rs.getInt("emp_id"));
        l.setType(rs.getInt("type"));
        l.setStartDate(rs.getDate("start_date"));
        l.setEndDate(rs.getDate("end_date"));
        l.setDays(rs.getDouble("days"));
        l.setReason(rs.getString("reason"));
        l.setAttachment(rs.getString("attachment"));
        l.setStatus(rs.getInt("status"));
        l.setApproverId(rs.getInt("approver_id"));
        l.setApproveTime(rs.getTimestamp("approve_time"));
        l.setApproveRemark(rs.getString("approve_remark"));
        l.setCreateTime(rs.getTimestamp("create_time"));
        try { l.setEmpName(rs.getString("emp_name")); } catch (SQLException e) {}
        try { l.setEmpNo(rs.getString("emp_no")); } catch (SQLException e) {}
        try { l.setDeptName(rs.getString("dept_name")); } catch (SQLException e) {}
        return l;
    }
}
