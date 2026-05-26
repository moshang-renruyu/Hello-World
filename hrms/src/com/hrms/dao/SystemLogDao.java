package com.hrms.dao;

import com.hrms.model.SystemLog;
import com.hrms.util.DBUtil;
import com.hrms.util.PageBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SystemLogDao {

    public void insert(SystemLog log) {
        String sql = "INSERT INTO system_log (user_id, username, operation, module, ip) VALUES (?,?,?,?,?)";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, log.getUserId());
            ps.setString(2, log.getUsername());
            ps.setString(3, log.getOperation());
            ps.setString(4, log.getModule());
            ps.setString(5, log.getIp());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
    }

    public PageBean<SystemLog> findByPage(int pageNum, int pageSize, String keyword, String module) {
        PageBean<SystemLog> page = new PageBean<>(pageNum, pageSize);
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            where.append(" AND (username LIKE ? OR operation LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (module != null && !module.isEmpty()) {
            where.append(" AND module=?");
            params.add(module);
        }

        String countSql = "SELECT COUNT(*) FROM system_log" + where;
        String listSql = "SELECT * FROM system_log" + where + " ORDER BY create_time DESC LIMIT ?,?";

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
            List<SystemLog> list = new ArrayList<>();
            while (rs.next()) list.add(mapRow(rs));
            page.setList(list);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return page;
    }

    public boolean clearAll() {
        String sql = "DELETE FROM system_log";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    private SystemLog mapRow(ResultSet rs) throws SQLException {
        SystemLog l = new SystemLog();
        l.setId(rs.getInt("id"));
        l.setUserId(rs.getInt("user_id"));
        l.setUsername(rs.getString("username"));
        l.setOperation(rs.getString("operation"));
        l.setModule(rs.getString("module"));
        l.setIp(rs.getString("ip"));
        l.setCreateTime(rs.getTimestamp("create_time"));
        return l;
    }
}
