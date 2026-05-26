package com.hrms.dao;

import com.hrms.model.User;
import com.hrms.util.DBUtil;
import com.hrms.util.PageBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    public User login(String username, String password) {
        String sql = "SELECT * FROM sys_user WHERE username=? AND password=? AND status=1";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                User user = mapRow(rs);
                ps = conn.prepareStatement("UPDATE sys_user SET last_login=NOW() WHERE id=?");
                ps.setInt(1, user.getId());
                ps.executeUpdate();
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return null;
    }

    public boolean register(User user) {
        String sql = "INSERT INTO sys_user (username, password, real_name, email, phone) VALUES (?,?,?,?,?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRealName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps);
        }
        return false;
    }

    public boolean existsByUsername(String username) {
        String sql = "SELECT COUNT(*) FROM sys_user WHERE username=?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return false;
    }

    public PageBean<User> findByPage(int pageNum, int pageSize, String keyword) {
        PageBean<User> page = new PageBean<>(pageNum, pageSize);
        StringBuilder countSql = new StringBuilder("SELECT COUNT(*) FROM sys_user WHERE 1=1");
        StringBuilder listSql = new StringBuilder("SELECT * FROM sys_user WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            countSql.append(" AND (username LIKE ? OR real_name LIKE ?)");
            listSql.append(" AND (username LIKE ? OR real_name LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        listSql.append(" ORDER BY id DESC LIMIT ?,?");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(countSql.toString());
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            rs = ps.executeQuery();
            if (rs.next()) page.setTotalCount(rs.getInt(1));

            ps = conn.prepareStatement(listSql.toString());
            int idx = 1;
            for (Object p : params) ps.setObject(idx++, p);
            ps.setInt(idx++, page.getStartIndex());
            ps.setInt(idx, pageSize);
            rs = ps.executeQuery();
            List<User> list = new ArrayList<>();
            while (rs.next()) list.add(mapRow(rs));
            page.setList(list);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return page;
    }

    public User findById(int id) {
        String sql = "SELECT * FROM sys_user WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return null;
    }

    public boolean update(User user) {
        String sql = "UPDATE sys_user SET real_name=?, email=?, phone=?, role=?, status=? WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getRealName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setInt(4, user.getRole());
            ps.setInt(5, user.getStatus());
            ps.setInt(6, user.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps);
        }
        return false;
    }

    public boolean updatePassword(int id, String newPassword) {
        String sql = "UPDATE sys_user SET password=? WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps);
        }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM sys_user WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps);
        }
        return false;
    }

    private User mapRow(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setRealName(rs.getString("real_name"));
        u.setRole(rs.getInt("role"));
        u.setAvatar(rs.getString("avatar"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setStatus(rs.getInt("status"));
        u.setCreateTime(rs.getTimestamp("create_time"));
        u.setLastLogin(rs.getTimestamp("last_login"));
        return u;
    }
}
