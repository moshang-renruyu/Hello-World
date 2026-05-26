package com.hrms.dao;

import com.hrms.model.Position;
import com.hrms.util.DBUtil;
import com.hrms.util.PageBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PositionDao {

    public List<Position> findAll() {
        String sql = "SELECT p.*, d.name AS dept_name FROM position_info p LEFT JOIN department d ON p.dept_id=d.id ORDER BY p.dept_id, p.level DESC";
        List<Position> list = new ArrayList<>();
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return list;
    }

    public List<Position> findByDeptId(int deptId) {
        String sql = "SELECT p.*, d.name AS dept_name FROM position_info p LEFT JOIN department d ON p.dept_id=d.id WHERE p.dept_id=? ORDER BY p.level DESC";
        List<Position> list = new ArrayList<>();
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, deptId);
            rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return list;
    }

    public PageBean<Position> findByPage(int pageNum, int pageSize, String keyword, int deptId) {
        PageBean<Position> page = new PageBean<>(pageNum, pageSize);
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            where.append(" AND (p.name LIKE ? OR p.code LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (deptId > 0) { where.append(" AND p.dept_id=?"); params.add(deptId); }

        String countSql = "SELECT COUNT(*) FROM position_info p" + where;
        String listSql = "SELECT p.*, d.name AS dept_name FROM position_info p LEFT JOIN department d ON p.dept_id=d.id" + where + " ORDER BY p.dept_id, p.level DESC LIMIT ?,?";

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
            List<Position> list = new ArrayList<>();
            while (rs.next()) list.add(mapRow(rs));
            page.setList(list);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return page;
    }

    public Position findById(int id) {
        String sql = "SELECT p.*, d.name AS dept_name FROM position_info p LEFT JOIN department d ON p.dept_id=d.id WHERE p.id=?";
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

    public boolean insert(Position pos) {
        String sql = "INSERT INTO position_info (name,code,dept_id,level,salary_min,salary_max,description,status) VALUES (?,?,?,?,?,?,?,?)";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, pos.getName());
            ps.setString(2, pos.getCode());
            ps.setInt(3, pos.getDeptId());
            ps.setInt(4, pos.getLevel());
            ps.setDouble(5, pos.getSalaryMin());
            ps.setDouble(6, pos.getSalaryMax());
            ps.setString(7, pos.getDescription());
            ps.setInt(8, pos.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean update(Position pos) {
        String sql = "UPDATE position_info SET name=?,code=?,dept_id=?,level=?,salary_min=?,salary_max=?,description=?,status=? WHERE id=?";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, pos.getName());
            ps.setString(2, pos.getCode());
            ps.setInt(3, pos.getDeptId());
            ps.setInt(4, pos.getLevel());
            ps.setDouble(5, pos.getSalaryMin());
            ps.setDouble(6, pos.getSalaryMax());
            ps.setString(7, pos.getDescription());
            ps.setInt(8, pos.getStatus());
            ps.setInt(9, pos.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM position_info WHERE id=?";
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

    private Position mapRow(ResultSet rs) throws SQLException {
        Position p = new Position();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setCode(rs.getString("code"));
        p.setDeptId(rs.getInt("dept_id"));
        p.setLevel(rs.getInt("level"));
        p.setSalaryMin(rs.getDouble("salary_min"));
        p.setSalaryMax(rs.getDouble("salary_max"));
        p.setDescription(rs.getString("description"));
        p.setStatus(rs.getInt("status"));
        p.setCreateTime(rs.getTimestamp("create_time"));
        try { p.setDeptName(rs.getString("dept_name")); } catch (SQLException e) {}
        return p;
    }
}
