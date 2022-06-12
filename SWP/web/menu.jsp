<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- use bean -->
        <jsp:useBean id="profile" class="model.DAOProfile" scope="request"></jsp:useBean>
        <jsp:useBean id="account" class="model.DAOAccount" scope="request"></jsp:useBean>
        <jsp:useBean id="project" class="model.DAOProject" scope="request"></jsp:useBean>
        <c:if test="${sessionScope.acc == null}">
            <c:redirect url="login.jsp"></c:redirect>
        </c:if>
        </head>

    
        <body>
            <!-- Main Wrapper -->
            <div class="main-wrapper">

                <!-- Header -->
                <div class="header">

                    <a id="toggle_btn" href="javascript:void(0);">
                        <span class="bar-icon">
                            <span></span>
                            <span></span>
                            <span></span>
                        </span>
                    </a>

                    <a id="mobile_btn" class="mobile_btn" href="#sidebar"><i class="fa fa-bars"></i></a>

                    <!-- Header Menu -->
                    <ul class="nav user-menu">

                        <li class="nav-item dropdown has-arrow main-drop">
                            <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                                <span class="user-img"><img src="img/profiles/avatar-21.jpg" alt="">
                                    <span class="status online"></span></span>
                                <span>${sessionScope.acc.user}</span>
                        </a>
                        <div class="dropdown-menu">
                            
                            <a class="dropdown-item" href="profile.jsp">My Profile</a>
                            <c:if test="${account.getAccount(sessionScope.acc.profile_id).isAdmin == true}">
                            <a class="dropdown-item" href="settings.html">Settings</a>
                            </c:if>
                            <a class="dropdown-item" href="authentication?do=logout">Logout</a>
                        </div>
                    </li>
                </ul>
                <!-- /Header Menu -->

                <!-- Mobile Menu -->
                <div class="dropdown mobile-user-menu">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i
                            class="fa fa-ellipsis-v"></i></a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="profile.html">My Profile</a>
                        <c:if test="${account.getAccount(sessionScope.acc.profile_id).isAdmin == true}">
                        <a class="dropdown-item" href="settings.html">Settings</a>
                        </c:if>
                        <a class="dropdown-item" href="authentication?do=logout">Logout</a>
                    </div>
                </div>
                <!-- /Mobile Menu -->

            </div>
            <div class="sidebar" id="sidebar">
                <div class="sidebar-inner slimscroll">
                    <div id="sidebar-menu" class="sidebar-menu">
                        <ul>
                            <li class="menu-title"> 
                                <span>Main</span>
                            </li>
                            <li class="submenu">
                                <a href="#"><i class="la la-dashboard"></i> <span> Dashboard</span> <span class="menu-arrow"></span></a>
                                <ul style="display: none;">
                                    <c:if test="${profile.getByID(sessionScope.acc.profile_id).reportto == null}">
                                        <li><a href="manager-dashboard.jsp">Dashboard (Manager)</a></li>
                                        </c:if>
                                    <li><a href="employee-dashboard.jsp">Dashboard (Employee)</a></li>

                                </ul>
                            </li>
                            <!--                            <li class="submenu">
                                                            <a href="#"><i class="la la-cube"></i> <span> Apps</span> <span class="menu-arrow"></span></a>
                                                            <ul style="display: none;">
                                                                <li><a href="chat.html">Chat</a></li>
                                                                <li class="submenu">
                                                                    <a href="#"><span> Calls</span> <span class="menu-arrow"></span></a>
                                                                    <ul style="display: none;">
                                                                        <li><a href="voice-call.html">Voice Call</a></li>
                                                                        <li><a href="video-call.html">Video Call</a></li>
                                                                        <li><a href="outgoing-call.html">Outgoing Call</a></li>
                                                                        <li><a href="incoming-call.html">Incoming Call</a></li>
                                                                    </ul>
                                                                </li>
                                                                <li><a href="events.html">Calendar</a></li>
                                                                <li><a href="contacts.html">Contacts</a></li>
                                                                <li><a href="inbox.html">Email</a></li>
                                                                <li><a href="file-manager.html">File Manager</a></li>
                                                            </ul>
                                                        </li>-->
                            <li class="menu-title"> 
                                <span>Employees</span>
                            </li>
                            <li class="submenu">
                                <a href="#" class="noti-dot"><i class="la la-user"></i> <span> Employees</span> <span class="menu-arrow"></span></a>
                                <ul style="display: none;">
                                    <c:if test="${profile.getByID(sessionScope.acc.profile_id).reportto == null && sessionScope.acc.isAdmin == false}">
                                        <li><a href="employees-list.jsp">All Employees</a></li>
                                        </c:if>
                                    <!--
                                    <li><a href="holidays.html">Holidays</a></li>
                                    <li><a href="leaves.html">Leaves (Admin) <span class="badge badge-pill bg-primary float-right">1</span></a></li>
                                    <li><a href="leaves-employee.html">Leaves (Employee)</a></li>
                                    <li><a href="leave-settings.html">Leave Settings</a></li>-->
                                    <c:if test="${profile.getByID(sessionScope.acc.profile_id).reportto == null && sessionScope.acc.isAdmin == false}">
                                        <li><a href="attendance-manager.jsp">Attendance (Manager)</a></li>
                                        </c:if>
                                    <li><a href="employee?do=attendance">Attendance (Employee)</a></li>
                                    <li><a href="departments.jsp">Departments</a></li>
                                    <li><a href="designations.jsp">Designations</a></li>
                                    <li><a href="timesheet.jsp">Timesheet</a></li>
                                    <!--                                    <li><a href="shift-scheduling.html">Shift & Schedule</a></li>
                                                                        <li><a href="overtime.html">Overtime</a></li>-->
                                </ul>
                            </li>
                            <li> 
                                <a href="clients.jsp"><i class="la la-users"></i> <span>Clients</span></a>
                            </li>
                            <li class="submenu">
                                <a href="#"><i class="la la-rocket"></i> <span> Projects</span> <span class="menu-arrow"></span></a>
                                <ul style="display: none;">
                                    <li><a href="project-view.jsp">Projects</a></li>
                                        <c:if test="${project.getProject(sessionScope.acc.profile_id) != null}">
                                        <li><a href="task-board.jsp">Task Board</a></li>
                                    </c:if>
                            </ul>
                        </li>
                        <li> 
                            <a href="leads.jsp"><i class="la la-user-secret"></i> <span>Leads</span></a>
                        </li>
                        <!--                            <li> 
                                                        <a href="tickets.html"><i class="la la-ticket"></i> <span>Tickets</span></a>
                                                    </li>-->
                        <li class="menu-title"> 
                            <span>HR</span>
                        </li>
                        <!--                            <li class="submenu">
                                                        <a href="#"><i class="la la-files-o"></i> <span> Sales </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="estimates.html">Estimates</a></li>
                                                            <li><a href="invoices.html">Invoices</a></li>
                                                            <li><a href="payments.html">Payments</a></li>
                                                            <li><a href="expenses.html">Expenses</a></li>
                                                            <li><a href="provident-fund.html">Provident Fund</a></li>
                                                            <li><a href="taxes.html">Taxes</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="submenu">
                                                        <a href="#"><i class="la la-files-o"></i> <span> Accounting </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="categories.html">Categories</a></li>
                                                            <li><a href="budgets.html">Budgets</a></li>
                                                            <li><a href="budget-expenses.html">Budget Expenses</a></li>
                                                            <li><a href="budget-revenues.html">Budget Revenues</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="submenu">
                                                        <a href="#"><i class="la la-money"></i> <span> Payroll </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="salary.html"> Employee Salary </a></li>
                                                            <li><a href="salary-view.html"> Payslip </a></li>
                                                            <li><a href="payroll-items.html"> Payroll Items </a></li>
                                                        </ul>
                                                    </li>
                                                    <li> 
                                                        <a href="policies.html"><i class="la la-file-pdf-o"></i> <span>Policies</span></a>
                                                    </li>
                                                    <li class="submenu">
                                                        <a href="#"><i class="la la-pie-chart"></i> <span> Reports </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="expense-reports.html"> Expense Report </a></li>
                                                            <li><a href="invoice-reports.html"> Invoice Report </a></li>
                                                            <li><a href="payments-reports.html"> Payments Report </a></li>
                                                            <li><a href="project-reports.html"> Project Report </a></li>
                                                            <li><a href="task-reports.html"> Task Report </a></li>
                                                            <li><a href="user-reports.html"> User Report </a></li>
                                                            <li><a href="employee-reports.html"> Employee Report </a></li>
                                                            <li><a href="payslip-reports.html"> Payslip Report </a></li>
                                                            <li><a href="attendance-reports.html"> Attendance Report </a></li>
                                                            <li><a href="leave-reports.html"> Leave Report </a></li>
                                                            <li><a href="daily-reports.html"> Daily Report </a></li>
                                                        </ul>
                                                    </li>-->
                        <li class="menu-title"> 
                            <span>Performance</span>
                        </li>
                        <!--                            <li class="submenu">
                                                        <a href="#"><i class="la la-graduation-cap"></i> <span> Performance </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="performance-indicator.html"> Performance Indicator </a></li>
                                                            <li><a href="performance.html"> Performance Review </a></li>
                                                            <li><a href="performance-appraisal.html"> Performance Appraisal </a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="submenu">
                                                        <a href="#"><i class="la la-crosshairs"></i> <span> Goals </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="goal-tracking.html"> Goal List </a></li>
                                                            <li><a href="goal-type.html"> Goal Type </a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="submenu">
                                                        <a href="#"><i class="la la-edit"></i> <span> Training </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="training.html"> Training List </a></li>
                                                            <li><a href="trainers.html"> Trainers</a></li>
                                                            <li><a href="training-type.html"> Training Type </a></li>
                                                        </ul>
                                                    </li>
                                                    <li><a href="promotion.html"><i class="la la-bullhorn"></i> <span>Promotion</span></a></li>
                                                    <li><a href="resignation.html"><i class="la la-external-link-square"></i> <span>Resignation</span></a></li>
                                                    <li><a href="termination.html"><i class="la la-times-circle"></i> <span>Termination</span></a></li>-->
                        <li class="menu-title"> 
                            <span>Administration</span>
                        </li>
                        <!--                            <li> 
                                                        <a href="assets.html"><i class="la la-object-ungroup"></i> <span>Assets</span></a>
                                                    </li>
                                                    <li class="submenu">
                                                        <a href="#"><i class="la la-briefcase"></i> <span> Jobs </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="user-dashboard.html"> User Dasboard </a></li>
                                                            <li><a href="jobs-dashboard.html"> Jobs Dasboard </a></li>
                                                            <li><a href="jobs.html"> Manage Jobs </a></li>
                                                            <li><a href="manage-resumes.html"> Manage Resumes </a></li>
                                                            <li><a href="shortlist-candidates.html"> Shortlist Candidates </a></li>
                                                            <li><a href="interview-questions.html"> Interview Questions </a></li>
                                                            <li><a href="offer_approvals.html"> Offer Approvals </a></li>
                                                            <li><a href="experiance-level.html"> Experience Level </a></li>
                                                            <li><a href="candidates.html"> Candidates List </a></li>
                                                            <li><a href="schedule-timing.html"> Schedule timing </a></li>
                                                            <li><a href="apptitude-result.html"> Aptitude Results </a></li>
                                                        </ul>
                                                    </li>
                                                    <li> 
                                                        <a href="knowledgebase.html"><i class="la la-question"></i> <span>Knowledgebase</span></a>
                                                    </li>
                                                    <li> 
                                                        <a href="activities.html"><i class="la la-bell"></i> <span>Activities</span></a>
                                                    </li>
                                                    <li> 
                                                        <a href="users.html"><i class="la la-user-plus"></i> <span>Users</span></a>
                                                    </li>
                                                    <li> 
                                                        <a href="settings.html"><i class="la la-cog"></i> <span>Settings</span></a>
                                                    </li>-->
                        <li class="menu-title"> 
                            <span>Pages</span>
                        </li>
                        <!--                            <li class="submenu">
                                                        <a href="#"><i class="la la-user"></i> <span> Profile </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="profile.html"> Employee Profile </a></li>
                                                            <li><a href="client-profile.html"> Client Profile </a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="submenu">
                                                        <a href="#"><i class="la la-key"></i> <span> Authentication </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="login.html"> Login </a></li>
                                                            <li><a href="register.html"> Register </a></li>
                                                            <li><a href="forgot-password.html"> Forgot Password </a></li>
                                                            <li><a href="otp.html"> OTP </a></li>
                                                            <li><a href="lock-screen.html"> Lock Screen </a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="submenu">
                                                        <a href="#"><i class="la la-exclamation-triangle"></i> <span> Error Pages </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="error-404.html">404 Error </a></li>
                                                            <li><a href="error-500.html">500 Error </a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="submenu">
                                                        <a href="#"><i class="la la-hand-o-up"></i> <span> Subscriptions </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="subscriptions.html"> Subscriptions (Admin) </a></li>
                                                            <li><a href="subscriptions-company.html"> Subscriptions (Company) </a></li>
                                                            <li><a href="subscribed-companies.html"> Subscribed Companies</a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="submenu">
                                                        <a href="#"><i class="la la-columns"></i> <span> Pages </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="search.html"> Search </a></li>
                                                            <li><a href="faq.html"> FAQ </a></li>
                                                            <li><a href="terms.html"> Terms </a></li>
                                                            <li><a href="privacy-policy.html"> Privacy Policy </a></li>
                                                            <li><a href="blank-page.html"> Blank Page </a></li>
                                                        </ul>
                                                    </li>-->
                        <li class="menu-title"> 
                            <span>UI Interface</span>
                        </li>
                        <!--                            <li> 
                                                        <a href="components.html"><i class="la la-puzzle-piece"></i> <span>Components</span></a>
                                                    </li>
                                                    <li class="submenu">
                                                        <a href="#"><i class="la la-object-group"></i> <span> Forms </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="form-basic-inputs.html">Basic Inputs </a></li>
                                                            <li><a href="form-input-groups.html">Input Groups </a></li>
                                                            <li><a href="form-horizontal.html">Horizontal Form </a></li>
                                                            <li><a href="form-vertical.html"> Vertical Form </a></li>
                                                            <li><a href="form-mask.html"> Form Mask </a></li>
                                                            <li><a href="form-validation.html"> Form Validation </a></li>
                                                        </ul>
                                                    </li>
                                                    <li class="submenu">
                                                        <a href="#"><i class="la la-table"></i> <span> Tables </span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li><a href="tables-basic.html">Basic Tables </a></li>
                                                            <li><a href="data-tables.html">Data Table </a></li>
                                                        </ul>
                                                    </li>-->
                        <li class="menu-title"> 
                            <span>Extras</span>
                        </li>
                        <!--                            <li> 
                                                        <a href="#"><i class="la la-file-text"></i> <span>Documentation</span></a>
                                                    </li>
                                                    <li> 
                                                        <a href="javascript:void(0);"><i class="la la-info"></i> <span>Change Log</span> <span class="badge badge-primary ml-auto">v3.4</span></a>
                                                    </li>
                                                    <li class="submenu">
                                                        <a href="javascript:void(0);"><i class="la la-share-alt"></i> <span>Multi Level</span> <span class="menu-arrow"></span></a>
                                                        <ul style="display: none;">
                                                            <li class="submenu">
                                                                <a href="javascript:void(0);"> <span>Level 1</span> <span class="menu-arrow"></span></a>
                                                                <ul style="display: none;">
                                                                    <li><a href="javascript:void(0);"><span>Level 2</span></a></li>
                                                                    <li class="submenu">
                                                                        <a href="javascript:void(0);"> <span> Level 2</span> <span class="menu-arrow"></span></a>
                                                                        <ul style="display: none;">
                                                                            <li><a href="javascript:void(0);">Level 3</a></li>
                                                                            <li><a href="javascript:void(0);">Level 3</a></li>
                                                                        </ul>
                                                                    </li>
                                                                    <li><a href="javascript:void(0);"> <span>Level 2</span></a></li>
                                                                </ul>
                                                            </li>
                                                            <li>
                                                                <a href="javascript:void(0);"> <span>Level 1</span></a>
                                                            </li>
                                                        </ul>
                                                    </li>-->
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- /Sidebar -->

</body>
