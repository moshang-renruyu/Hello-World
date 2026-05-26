package com.hrms.dao;

import com.hrms.model.Employee;
import com.hrms.util.DBUtil;
import com.hrms.util.PageBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDao {

    public PageBean<Employee> findByPage(int pageNum, int pageSize, String keyword, int deptId, int status) {
        PageBean<Employee> page = new PageBean<>(pageNum, pageSize);
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            where.append(" AND (e.name LIKE ? OR e.emp_no LIKE ? OR e.phone LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (deptId > 0) { where.append(" AND e.dept_id=?"); params.add(deptId); }
        if (status > 0) { where.append(" AND e.status=?"); params.add(status); }

        String countSql = "SELECT COUNT(*) FROM employee e" + where;
        String listSql = "SELECT e.*, d.name AS dept_name, p.name AS position_name FROM employee e " +
                "LEFT JOIN department d ON e.dept_id=d.id LEFT JOIN position_info p ON e.position_id=p.id" +
                where + " ORDER BY e.id DESC LIMIT ?,?";

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
            List<Employee> list = new ArrayList<>();
            while (rs.next()) list.add(mapRow(rs));
            page.setList(list);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return page;
    }

    public List<Employee> findAll() {
        String sql = "SELECT e.*, d.name AS dept_name, p.name AS position_name FROM employee e " +
                "LEFT JOIN department d ON e.dept_id=d.id LEFT JOIN position_info p ON e.position_id=p.id ORDER BY e.id";
        List<Employee> list = new ArrayList<>();
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

    public Employee findById(int id) {
        String sql = "SELECT e.*, d.name AS dept_name, p.name AS position_name FROM employee e " +
                "LEFT JOIN department d ON e.dept_id=d.id LEFT JOIN position_info p ON e.position_id=p.id WHERE e.id=?";
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

    public boolean insert(Employee emp) {
        String sql = "INSERT INTO employee (emp_no,name,gender,birth_date,id_card,phone,email,address,photo," +
                "dept_id,position_id,hire_date,status,education,university,major,emergency_contact,emergency_phone," +
                "contract_start,contract_end,remark,hobbies) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, emp.getEmpNo());
            ps.setString(2, emp.getName());
            ps.setInt(3, emp.getGender());
            ps.setObject(4, emp.getBirthDate());
            ps.setString(5, emp.getIdCard());
            ps.setString(6, emp.getPhone());
            ps.setString(7, emp.getEmail());
            ps.setString(8, emp.getAddress());
            ps.setString(9, emp.getPhoto());
            ps.setInt(10, emp.getDeptId());
            ps.setInt(11, emp.getPositionId());
            ps.setObject(12, emp.getHireDate());
            ps.setInt(13, emp.getStatus());
            ps.setString(14, emp.getEducation());
            ps.setString(15, emp.getUniversity());
            ps.setString(16, emp.getMajor());
            ps.setString(17, emp.getEmergencyContact());
            ps.setString(18, emp.getEmergencyPhone());
            ps.setObject(19, emp.getContractStart());
            ps.setObject(20, emp.getContractEnd());
            ps.setString(21, emp.getRemark());
            ps.setString(22, emp.getHobbies());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean update(Employee emp) {
        String sql = "UPDATE employee SET name=?,gender=?,birth_date=?,id_card=?,phone=?,email=?,address=?,dept_id=?,position_id=?,hire_date=?,status=?,education=?,university=?,major=?,emergency_contact=?,emergency_phone=?,contract_start=?,contract_end=?,remark=?,hobbies=? WHERE id=?";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, emp.getName());
            ps.setInt(2, emp.getGender());
            ps.setObject(3, emp.getBirthDate());
            ps.setString(4, emp.getIdCard());
            ps.setString(5, emp.getPhone());
            ps.setString(6, emp.getEmail());
            ps.setString(7, emp.getAddress());
            ps.setInt(8, emp.getDeptId());
            ps.setInt(9, emp.getPositionId());
            ps.setObject(10, emp.getHireDate());
            ps.setInt(11, emp.getStatus());
            ps.setString(12, emp.getEducation());
            ps.setString(13, emp.getUniversity());
            ps.setString(14, emp.getMajor());
            ps.setString(15, emp.getEmergencyContact());
            ps.setString(16, emp.getEmergencyPhone());
            ps.setObject(17, emp.getContractStart());
            ps.setObject(18, emp.getContractEnd());
            ps.setString(19, emp.getRemark());
            ps.setString(20, emp.getHobbies());
            ps.setInt(21, emp.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean updatePhoto(int id, String photo) {
        String sql = "UPDATE employee SET photo=? WHERE id=?";
        Connection conn = null; PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, photo);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps); }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM employee WHERE id=?";
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

    public int countByDept(int deptId) {
        String sql = "SELECT COUNT(*) FROM employee WHERE dept_id=?";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, deptId);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return 0;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM employee";
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

    public int countByStatus(int status) {
        String sql = "SELECT COUNT(*) FROM employee WHERE status=?";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, status);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return 0;
    }

    public String generateEmpNo() {
        String year = String.valueOf(java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
        String sql = "SELECT MAX(emp_no) FROM employee WHERE emp_no LIKE ?";
        Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "EMP" + year + "%");
            rs = ps.executeQuery();
            if (rs.next() && rs.getString(1) != null) {
                String maxNo = rs.getString(1);
                int num = Integer.parseInt(maxNo.substring(7)) + 1;
                return "EMP" + year + String.format("%04d", num);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.close(conn, ps, rs); }
        return "EMP" + year + "0001";
    }

    private Employee mapRow(ResultSet rs) throws SQLException {
        Employee e = new Employee();
        e.setId(rs.getInt("id"));
        e.setEmpNo(rs.getString("emp_no"));
        e.setName(rs.getString("name"));
        e.setGender(rs.getInt("gender"));
        e.setBirthDate(rs.getDate("birth_date"));
        e.setIdCard(rs.getString("id_card"));
        e.setPhone(rs.getString("phone"));
        e.setEmail(rs.getString("email"));
        e.setAddress(rs.getString("address"));
        e.setPhoto(rs.getString("photo"));
        e.setDeptId(rs.getInt("dept_id"));
        e.setPositionId(rs.getInt("position_id"));
        e.setHireDate(rs.getDate("hire_date"));
        e.setLeaveDate(rs.getDate("leave_date"));
        e.setStatus(rs.getInt("status"));
        e.setEducation(rs.getString("education"));
        e.setUniversity(rs.getString("university"));
        e.setMajor(rs.getString("major"));
        e.setEmergencyContact(rs.getString("emergency_contact"));
        e.setEmergencyPhone(rs.getString("emergency_phone"));
        e.setContractStart(rs.getDate("contract_start"));
        e.setContractEnd(rs.getDate("contract_end"));
        e.setRemark(rs.getString("remark"));
        e.setHobbies(rs.getString("hobbies"));
        e.setCreateTime(rs.getTimestamp("create_time"));
        try { e.setDeptName(rs.getString("dept_name")); } catch (SQLException ex) {}
        try { e.setPositionName(rs.getString("position_name")); } catch (SQLException ex) {}
        return e;
    }
}