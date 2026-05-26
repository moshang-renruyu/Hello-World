package com.hrms.dao;

import com.hrms.model.Training;
import com.hrms.util.DBUtil;
import com.hrms.util.PageBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TrainingDao {

    public PageBean<Training> findByPage(int pageNum, int pageSize, String keyword, int status) {
        PageBean<Training> page = new PageBean<>(pageNum, pageSize);
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            where.append(" AND (t.title LIKE ? OR t.trainer LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (status > 0) { where.append(" AND t.status=?"); params.add(status); }

        String countSql = "SELECT COUNT(*) FROM training t" + where;
        String listSql = "SELECT t.*, d.name AS dept_name FROM training t LEFT JOIN department d ON t.dept_id=d.id" + where + " ORDER BY t.create_time DESC LIMIT ?,?";

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
            List<Training> list = new ArrayList<>();
            while (rs.next()) list.add(mapRow(rs));
            page.setList(list);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return page;
    }

    public Training findById(int id) {
        String sql = "SELECT t.*, d.name AS dept_name FROM training t LEFT JOIN department d ON t.dept_id=d.id WHERE t.id=?";
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

    public boolean insert(Training t) {
        String sql = "INSERT INTO training (title,type,trainer,dept_id,start_date,end_date,location,content,max_count,status,attachment) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, t.getTitle());
            ps.setInt(2, t.getType());
            ps.setString(3, t.getTrainer());
            ps.setInt(4, t.getDeptId());
            ps.setObject(5, t.getStartDate());
            ps.setObject(6, t.getEndDate());
            ps.setString(7, t.getLocation());
            ps.setString(8, t.getContent());
            ps.setInt(9, t.getMaxCount());
            ps.setInt(10, t.getStatus());
            ps.setString(11, t.getAttachment());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean update(Training t) {
        String sql = "UPDATE training SET title=?,type=?,trainer=?,dept_id=?,start_date=?,end_date=?,location=?,content=?,max_count=?,status=? WHERE id=?";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, t.getTitle());
            ps.setInt(2, t.getType());
            ps.setString(3, t.getTrainer());
            ps.setInt(4, t.getDeptId());
            ps.setObject(5, t.getStartDate());
            ps.setObject(6, t.getEndDate());
            ps.setString(7, t.getLocation());
            ps.setString(8, t.getContent());
            ps.setInt(9, t.getMaxCount());
            ps.setInt(10, t.getStatus());
            ps.setInt(11, t.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM training WHERE id=?";
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
        String sql = "SELECT COUNT(*) FROM training WHERE status IN (1,2)";
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

    private Training mapRow(ResultSet rs) throws SQLException {
        Training t = new Training();
        t.setId(rs.getInt("id"));
        t.setTitle(rs.getString("title"));
        t.setType(rs.getInt("type"));
        t.setTrainer(rs.getString("trainer"));
        t.setDeptId(rs.getInt("dept_id"));
        t.setStartDate(rs.getDate("start_date"));
        t.setEndDate(rs.getDate("end_date"));
        t.setLocation(rs.getString("location"));
        t.setContent(rs.getString("content"));
        t.setMaxCount(rs.getInt("max_count"));
        t.setCurrentCount(rs.getInt("current_count"));
        t.setStatus(rs.getInt("status"));
        t.setAttachment(rs.getString("attachment"));
        t.setCreateTime(rs.getTimestamp("create_time"));
        try { t.setDeptName(rs.getString("dept_name")); } catch (SQLException e) {}
        return t;
    }
}
