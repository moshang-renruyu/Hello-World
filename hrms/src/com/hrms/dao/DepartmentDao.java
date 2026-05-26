package com.hrms.dao;

import com.hrms.model.Department;
import com.hrms.util.DBUtil;
import com.hrms.util.PageBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DepartmentDao {

    public List<Department> findAll() {
        String sql = "SELECT d.*, (SELECT COUNT(*) FROM employee e WHERE e.dept_id=d.id) AS emp_count FROM department d ORDER BY d.sort_order, d.id";
        List<Department> list = new ArrayList<>();
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

    public PageBean<Department> findByPage(int pageNum, int pageSize, String keyword) {
        PageBean<Department> page = new PageBean<>(pageNum, pageSize);
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            where.append(" AND (d.name LIKE ? OR d.code LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        String countSql = "SELECT COUNT(*) FROM department d" + where;
        String listSql = "SELECT d.*, (SELECT COUNT(*) FROM employee e WHERE e.dept_id=d.id) AS emp_count FROM department d" + where + " ORDER BY d.sort_order, d.id LIMIT ?,?";

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
            List<Department> list = new ArrayList<>();
            while (rs.next()) list.add(mapRow(rs));
            page.setList(list);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return page;
    }

    public Department findById(int id) {
        String sql = "SELECT d.*, (SELECT COUNT(*) FROM employee e WHERE e.dept_id=d.id) AS emp_count FROM department d WHERE d.id=?";
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

    public boolean insert(Department dept) {
        String sql = "INSERT INTO department (name,code,manager,phone,description,parent_id,sort_order,status) VALUES (?,?,?,?,?,?,?,?)";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, dept.getName());
            ps.setString(2, dept.getCode());
            ps.setString(3, dept.getManager());
            ps.setString(4, dept.getPhone());
            ps.setString(5, dept.getDescription());
            ps.setInt(6, dept.getParentId());
            ps.setInt(7, dept.getSortOrder());
            ps.setInt(8, dept.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean update(Department dept) {
        String sql = "UPDATE department SET name=?,code=?,manager=?,phone=?,description=?,parent_id=?,sort_order=?,status=? WHERE id=?";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, dept.getName());
            ps.setString(2, dept.getCode());
            ps.setString(3, dept.getManager());
            ps.setString(4, dept.getPhone());
            ps.setString(5, dept.getDescription());
            ps.setInt(6, dept.getParentId());
            ps.setInt(7, dept.getSortOrder());
            ps.setInt(8, dept.getStatus());
            ps.setInt(9, dept.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM department WHERE id=?";
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

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM department";
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

    private Department mapRow(ResultSet rs) throws SQLException {
        Department d = new Department();
        d.setId(rs.getInt("id"));
        d.setName(rs.getString("name"));
        d.setCode(rs.getString("code"));
        d.setManager(rs.getString("manager"));
        d.setPhone(rs.getString("phone"));
        d.setDescription(rs.getString("description"));
        d.setParentId(rs.getInt("parent_id"));
        d.setSortOrder(rs.getInt("sort_order"));
        d.setStatus(rs.getInt("status"));
        d.setCreateTime(rs.getTimestamp("create_time"));
        try { d.setEmpCount(rs.getInt("emp_count")); } catch (SQLException e) {}
        return d;
    }
}
