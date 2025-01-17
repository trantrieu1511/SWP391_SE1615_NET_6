/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import entity.Account;
import entity.Attendance;
import entity.Departments;
import entity.Experience;
import entity.FamilyInfo;
import entity.Jobs;
import entity.Profile;
import entity.ProfileDetail;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DAOAccount;
import model.DAOAttendance;
import model.DAODepartment;
import model.DAOExperience;
import model.DAOFamilyInfo;
import model.DAOJob;
import model.DAOProfile;
import model.DAOProfileDetail;
import model.DAOSchedule;
import model.DAOTask;

/**
 *
 * @author Khanh
 */
@WebServlet(name = "ControllerManager", urlPatterns = {"/manager"})
public class ControllerManager extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            /* TODO output your page here. You may use following sample code. */
            String service = request.getParameter("do");
            DAOAttendance daoAttendance = new DAOAttendance();
            DAOProfile daoProfile = new DAOProfile();
            DAODepartment daoDepartment = new DAODepartment();
            DAOJob daoJob = new DAOJob();
            DAOTask daoTask = new DAOTask();
            DAOAccount daoAccount = new DAOAccount();
            DAOProfileDetail daoProfileDetail = new DAOProfileDetail();
            DAOFamilyInfo daoFamilyInfo = new DAOFamilyInfo();
            DAOExperience daoExperience = new DAOExperience();
            DAOSchedule daoSchedule = new DAOSchedule();

            HttpSession session = request.getSession();
            Account acc = (Account) session.getAttribute("acc");
            // check session for user logged in
            if (acc == null) {
                response.sendRedirect("login.jsp");
            } else {
                // attendance 
                if (service.equals("attendance")) {
                    List<Attendance> listAttendance = daoAttendance.listAllAttendance(acc.getProfile_id());
                    for (Attendance a : listAttendance) {
                        a.setEmployee_id(daoProfile.getByID(a.getEmployee_id()).getFirst_name() + " " + daoProfile.getByID(a.getEmployee_id()).getLast_name());
                    }
                    request.setAttribute("list", listAttendance);
                    request.setAttribute("name", "");
                    request.setAttribute("date", "");
                    request.setAttribute("filter", "no");
                    RequestDispatcher dispath = request.getRequestDispatcher("attendance-manager.jsp");
                    dispath.forward(request, response);
                }

                // searchAttendance attendance
                if (service.equals("searchAttendance")) {
                    String name = request.getParameter("name");
                    String date_search = request.getParameter("date");
                    List<Attendance> listAttendance = daoAttendance.searchAttendance(date_search, name, acc.getProfile_id());
                    for (Attendance a : listAttendance) {
                        a.setEmployee_id(daoProfile.getByID(a.getEmployee_id()).getFirst_name() + " " + daoProfile.getByID(a.getEmployee_id()).getLast_name());
                    }
                    request.setAttribute("list", listAttendance);
                    request.setAttribute("name", name);
                    request.setAttribute("date", date_search);
                    request.setAttribute("filter", "yes");
                    RequestDispatcher dispath = request.getRequestDispatcher("attendance-manager.jsp");
                    dispath.forward(request, response);
                }

                if (service.equals("list")) {
                    //Thong bao khi insert, update, delete
                    String edit = request.getParameter("edit");
                    String add = request.getParameter("add");
                    String delete = request.getParameter("delete");
                    String alert = "";
                    if (edit != null && edit.equals("success")) { //edit
                        alert = "New staff information have been saved!";
                    }
                    if (edit != null && edit.equals("fail")) { //edit
                        alert = "Edit failed!";
                    }
                    if (add != null && add.equals("success")) { //add
                        alert = "Successfully added new staff information!";
                    }
                    if (add != null && add.equals("fail")) { //add
                        alert = "Add failed!";
                    }
                    if (delete != null && delete.equals("success")) { //delete
                        alert = "Delete staff successfully!";
                    }
                    if (delete != null && delete.equals("fail")) { //delete
                        alert = "Delete failed!";
                    }
                    List<Profile> list = daoProfile.listAllStaff(acc.getProfile_id());
                    List<Departments> listDp = daoDepartment.listAllDepartment();
                    List<Jobs> listJ = daoJob.listAllJob();
                    for (Profile p : list) {
                        p.setJob_title(daoJob.getJobById(p.getJob_id()).getTitle());
                        p.setDepartment_name(daoDepartment.getDepartmentByID(p.getDepartment_id()).getName());
                        Account accStaff = daoAccount.getAccount(p.getProfile_id());
                        if (accStaff != null) {
                            p.setUser_display(daoAccount.getAccount(p.getProfile_id()).getUser());
                            p.setPass_display(daoAccount.getAccount(p.getProfile_id()).getPass());
                        }
                    }
                    request.setAttribute("filter", "yes");
                    request.setAttribute("alert", alert);
                    request.setAttribute("list", list);
                    request.setAttribute("department", listDp);
                    request.setAttribute("job", listJ);
                    RequestDispatcher dispath = request.getRequestDispatcher("employees-list.jsp");
                    dispath.forward(request, response);
                }

                // homepage
                if (service.equals("dashboard")) {
                    RequestDispatcher dispath = request.getRequestDispatcher("manager-dashboard.jsp");
                    dispath.forward(request, response);
                }

                if (service.equals("filter")) {
                    String eid = request.getParameter("eid");
                    String ename = request.getParameter("ename");
                    String ejob = request.getParameter("ejob");
                    List<Profile> list = new ArrayList<>();
                    List<Departments> listDp = daoDepartment.listAllDepartment();
                    List<Jobs> listJ = daoJob.listAllJob();
                    String alert = "";
                    if (ejob.equals("")) {
                        list = daoProfile.searchStaff1(eid, ename);
                    } else {
                        list = daoProfile.searchStaff2(eid, ename, ejob);
                    }
                    for (Profile p : list) {
                        p.setJob_title(daoJob.getJobById(p.getJob_id()).getTitle());
                        p.setDepartment_name(daoDepartment.getDepartmentByID(p.getDepartment_id()).getName());
                    }

                    request.setAttribute("list", list);
                    request.setAttribute("filter", "no");
                    request.setAttribute("alert", alert);
                    request.setAttribute("department", listDp);
                    request.setAttribute("job", listJ);
                    request.setAttribute("ename", ename);
                    request.setAttribute("ejob", ejob);
                    request.setAttribute("eid", eid);
                    RequestDispatcher dispath = request.getRequestDispatcher("employees-list.jsp");
                    dispath.forward(request, response);
                }

                if (service.equals("addStaff")) {
//                    String profile_id = request.getParameter("profile_id");
                    String first_name = request.getParameter("first_name").trim();
                    String last_name = request.getParameter("last_name").trim();
                    String username = request.getParameter("username").trim();
                    String password = request.getParameter("password").trim();
                    String email = request.getParameter("email").trim();
                    String phone_number = request.getParameter("phone_number").trim();
                    String hire_date = request.getParameter("hire_date").trim();
                    String ReportsTo = request.getParameter("ReportsTo");
                    int job_id = Integer.parseInt(request.getParameter("job_id"));
                    int department_id = Integer.parseInt(request.getParameter("department_id"));

                    Profile pro = new Profile(first_name, last_name,
                            email, phone_number, hire_date, job_id, department_id,
                            ReportsTo);
                    boolean statusPro = daoProfile.addStaff(pro);

                    if (statusPro) {
                        String profile_id = daoProfile.getGeneratedProfileID();
                        daoSchedule.addSchedule(profile_id, " ");
                        daoAccount.addAccount(profile_id, username, password);
                        ProfileDetail pd = new ProfileDetail(profile_id, "01/01/1900",
                                "notAvailable", true, "notAvailable", "notAvailable", false, 0, "notAvailable", "notAvailable");
                        daoProfileDetail.addProfileDetail(pd);
//                        FamilyInfo f = new FamilyInfo(profile_id, "notAvailable", "notAvailable",
//                                "01/01/1900", "notAvailable");
//                        daoFamilyInfo.addFamilyInfo(f);
//                        Experience exp = new Experience(profile_id, "notAvailable", "01/01/1900",
//                                "01/01/1900");
//                        daoExperience.addExperience(exp);
                        response.sendRedirect("manager?do=list&add=success");
                    } else {
                        response.sendRedirect("manager?do=list&add=fail");
                    }
                }

                if (service.equals("editStaff")) {
                    String profile_id = request.getParameter("profile_id");
                    String first_name = request.getParameter("first_name").trim();
                    String last_name = request.getParameter("last_name").trim();
                    String username = request.getParameter("username").trim();
                    String password = request.getParameter("password").trim();
                    String email = request.getParameter("email").trim();
                    String phone_number = request.getParameter("phone_number").trim();
                    String hire_date = request.getParameter("hire_date").trim();
                    String ReportsTo = request.getParameter("ReportsTo");
                    int job_id = Integer.parseInt(request.getParameter("job_id"));
                    int department_id = Integer.parseInt(request.getParameter("department_id"));
                    daoProfile.editStaff(new Profile(profile_id, first_name,
                            last_name, email, phone_number, hire_date, job_id,
                            department_id, ReportsTo));
                    boolean status = daoAccount.editAccount(profile_id, username, password);
                    if (status) {
                        response.sendRedirect("manager?do=list&edit=success");
                    }
                    else{
                        response.sendRedirect("manager?do=list&edit=fail");
                    }
                    
                }

                if (service.equals("deleteStaff")) {
                    String profile_id = request.getParameter("profile_id");
                    daoSchedule.deleteScheduleFromStaff(profile_id);
                    daoAccount.deleteAccount(profile_id);
                    daoProfileDetail.deleteProfileDetail(profile_id);
                    daoFamilyInfo.deleteAllFamilyInfo(profile_id);
                    daoExperience.deleteAllExperience(profile_id);
                    boolean status = daoProfile.deleteProfile(profile_id);
                    if (status) {
                        response.sendRedirect("manager?do=list&delete=success");
                    }else{
                        response.sendRedirect("manager?do=list&delete=fail");
                    }
                }

                if (service.equals("addTask")) {
                    String name = request.getParameter("name");
                    int priority = Integer.parseInt(request.getParameter("priority"));
                    String deadline = request.getParameter("deadline");
                    int status = 0;
                    String assigned = request.getParameter("assigned");
                    String project = request.getParameter("project");
                    daoTask.addTask(name, priority, deadline, status, assigned, project);
                    response.sendRedirect("task-board.jsp");
                }

                if (service.equals("searchAttendance")) {
                    String name = request.getParameter("name");
                    String date = request.getParameter("date");
                    List<Attendance> listAttendance = daoAttendance.searchAttendance(name, date);
                    request.setAttribute("list", listAttendance);
                    RequestDispatcher dispath = request.getRequestDispatcher("attendance-manager.jsp");
                    dispath.forward(request, response);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("error404.jsp");
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            ex.printStackTrace();
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            ex.printStackTrace();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
