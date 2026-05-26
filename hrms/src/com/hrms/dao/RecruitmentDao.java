package com.hrms.dao;

import com.hrms.model.Recruitment;
import com.hrms.util.DBUtil;
import com.hrms.util.PageBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RecruitmentDao {

    public PageBean<Recruitment> findByPage(int pageNum, int pageSize, String keyword, int status) {
        PageBean<Recruitment> page = new PageBean<>(pageNum, pageSize);
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            where.append(" AND (r.title LIKE ? OR r.position_name LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (status > 0) { where.append(" AND r.status=?"); params.add(status); }

        String countSql = "SELECT COUNT(*) FROM recruitment r" + where;
        String listSql = "SELECT r.*, d.name AS dept_name FROM recruitment r LEFT JOIN department d ON r.dept_id=d.id" + where + " ORDER BY r.create_time DESC LIMIT ?,?";

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
            List<Recruitment> list = new ArrayList<>();
            while (rs.next()) list.add(mapRow(rs));
            page.setList(list);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return page;
    }

    public Recruitment findById(int id) {
        String sql = "SELECT r.*, d.name AS dept_name FROM recruitment r LEFT JOIN department d ON r.dept_id=d.id WHERE r.id=?";
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

    public boolean insert(Recruitment rec) {
        String sql = "INSERT INTO recruitment (title,dept_id,position_name,head_count,education,experience,salary_range,description,requirement,status,publisher,publish_date,deadline) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, rec.getTitle());
            ps.setInt(2, rec.getDeptId());
            ps.setString(3, rec.getPositionName());
            ps.setInt(4, rec.getHeadCount());
            ps.setString(5, rec.getEducation());
            ps.setString(6, rec.getExperience());
            ps.setString(7, rec.getSalaryRange());
            ps.setString(8, rec.getDescription());
            ps.setString(9, rec.getRequirement());
            ps.setInt(10, rec.getStatus());
            ps.setString(11, rec.getPublisher());
            ps.setObject(12, rec.getPublishDate());
            ps.setObject(13, rec.getDeadline());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean update(Recruitment rec) {
        String sql = "UPDATE recruitment SET title=?,dept_id=?,position_name=?,head_count=?,education=?,experience=?,salary_range=?,description=?,requirement=?,status=?,deadline=? WHERE id=?";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, rec.getTitle());
            ps.setInt(2, rec.getDeptId());
            ps.setString(3, rec.getPositionName());
            ps.setInt(4, rec.getHeadCount());
            ps.setString(5, rec.getEducation());
            ps.setString(6, rec.getExperience());
            ps.setString(7, rec.getSalaryRange());
            ps.setString(8, rec.getDescription());
            ps.setString(9, rec.getRequirement());
            ps.setInt(10, rec.getStatus());
            ps.setObject(11, rec.getDeadline());
            ps.setInt(12, rec.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM recruitment WHERE id=?";
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

    public int countActive() {
        String sql = "SELECT COUNT(*) FROM recruitment WHERE status=1";
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

    private Recruitment mapRow(ResultSet rs) throws SQLException {
        Recruitment r = new Recruitment();
        r.setId(rs.getInt("id"));
        r.setTitle(rs.getString("title"));
        r.setDeptId(rs.getInt("dept_id"));
        r.setPositionName(rs.getString("position_name"));
        r.setHeadCount(rs.getInt("head_count"));
        r.setEducation(rs.getString("education"));
        r.setExperience(rs.getString("experience"));
        r.setSalaryRange(rs.getString("salary_range"));
        r.setDescription(rs.getString("description"));
        r.setRequirement(rs.getString("requirement"));
        r.setStatus(rs.getInt("status"));
        r.setPublisher(rs.getString("publisher"));
        r.setPublishDate(rs.getDate("publish_date"));
        r.setDeadline(rs.getDate("deadline"));
        r.setCreateTime(rs.getTimestamp("create_time"));
        try { r.setDeptName(rs.getString("dept_name")); } catch (SQLException e) {}
        return r;
    }
}
