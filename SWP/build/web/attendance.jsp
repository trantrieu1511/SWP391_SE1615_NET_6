<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
    DateFormat hf = new SimpleDateFormat("hh:mm");
    String date = df.format(new java.util.Date());
    String hour = hf.format(new java.util.Date());
    String str = date + " " + hour;
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <meta name="description" content="Smarthr - Bootstrap Admin Template">
        <meta name="keywords" content="admin, estimates, bootstrap, business, corporate, creative, management, minimal, modern, accounts, invoice, html5, responsive, CRM, Projects">
        <meta name="author" content="Dreamguys - Bootstrap Admin Template">
        <meta name="robots" content="noindex, nofollow">
        <title>Attendance - HRMS admin template</title>

        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css">

        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!-- Lineawesome CSS -->
        <link rel="stylesheet" href="css/line-awesome.min.css">

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="css/select2.min.css">

        <!-- Datetimepicker CSS -->
        <link rel="stylesheet" href="css/bootstrap-datetimepicker.min.css">

        <!-- Main Stylesheet -->
        <link rel="stylesheet" href="css/style.css">

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
                <script src="js/html5shiv.min.js"></script>
                <script src="js/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <!-- Main Wrapper -->
        <div class="main-wrapper">

            <jsp:include page="index.jsp"></jsp:include>

                <!-- Page Wrapper -->
                <div class="page-wrapper">
                    <div class="content container-fluid">

                        <!-- Page Header -->
                        <div class="page-header">
                            <div class="row">
                                <div class="col-sm-12">
                                    <h3 class="page-title">Attendance</h3>
                                    <ul class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
                                        <li class="breadcrumb-item active">Attendance</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- /Page Header -->

                        <div class="row">
                            <div class="col-md-6">
                                <div class="card punch-status">
                                    <div class="card-body">
                                        <h5 class="card-title">Timesheet <small class="text-muted"><%=date%></small></h5>
                                    <div class="punch-det">
                                        <h6 id="punch-det-text" name="text"></h6>
                                        <p id="inat"></p>
                                    </div>
                                    <div class="punch-info"onload="initClock()">
                                        <div class="punch-hours">
                                            <jsp:include page="clock.jsp"></jsp:include>                                       
                                        </div>
                                    </div>
                                    <div class="punch-btn-section">
                                        <a href="#" button id="in" onclick="punch(this.id)" type="button" class="btn btn-primary punch-btn" name="punch">Punch In</button></a>
                                        <script type="text/javascript">
                                            function punch(id)
                                            {
                                                if (id == "out") {
                                                    document.getElementById(id).href = "attendance?time=<%=str%> out";
                                                    var today = new Date();
                                                    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                                                    document.getElementById(id).innerHTML = "Punch In";
                                                    document.getElementById(id).id = "in";
                                                    document.getElementById("punch-det-text").innerHTML = "Punch Out At";
                                                    document.getElementById("inat").innerHTML = time;
                                                } else {
                                                    document.getElementById(id).href = "attendance?time=<%=str%> in";
                                                    var today = new Date();
                                                    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                                                    document.getElementById(id).innerHTML = "Punch Out";
                                                    document.getElementById(id).id = "out";
                                                    document.getElementById("punch-det-text").innerHTML = "Punch In At";
                                                    document.getElementById("inat").innerHTML = time;
                                                }
                                            }
                                        </script>
                                    </div>                                  
                                </div>
                            </div>
                        </div>
                        <!--                        <div class="col-md-4">
                                                    <div class="card att-statistics">
                                                        <div class="card-body">
                                                            <h5 class="card-title">Statistics</h5>
                                                            <div class="stats-list">
                                                                <div class="stats-info">
                                                                    <p>Today <strong>3.45 <small>/ 8 hrs</small></strong></p>
                                                                    <div class="progress">
                                                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 31%" aria-valuenow="31" aria-valuemin="0" aria-valuemax="100"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="stats-info">
                                                                    <p>This Week <strong>28 <small>/ 40 hrs</small></strong></p>
                                                                    <div class="progress">
                                                                        <div class="progress-bar bg-warning" role="progressbar" style="width: 31%" aria-valuenow="31" aria-valuemin="0" aria-valuemax="100"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="stats-info">
                                                                    <p>This Month <strong>90 <small>/ 160 hrs</small></strong></p>
                                                                    <div class="progress">
                                                                        <div class="progress-bar bg-success" role="progressbar" style="width: 62%" aria-valuenow="62" aria-valuemin="0" aria-valuemax="100"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="stats-info">
                                                                    <p>Remaining <strong>90 <small>/ 160 hrs</small></strong></p>
                                                                    <div class="progress">
                                                                        <div class="progress-bar bg-danger" role="progressbar" style="width: 62%" aria-valuenow="62" aria-valuemin="0" aria-valuemax="100"></div>
                                                                    </div>
                                                                </div>
                                                                <div class="stats-info">
                                                                    <p>Overtime <strong>4</strong></p>
                                                                    <div class="progress">
                                                                        <div class="progress-bar bg-info" role="progressbar" style="width: 22%" aria-valuenow="22" aria-valuemin="0" aria-valuemax="100"></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>-->
                        <div class="col-md-6">
                            <div class="card recent-activity">
                                <div class="card-body">
                                    <h5 class="card-title">Today Activity</h5>
                                    <ul class="res-activity-list">
                                        <li>
                                            <p class="mb-0">Punch In at</p>
                                            <p class="res-activity-time">
                                                <i class="fa fa-clock-o"></i>
                                                10.00 AM.
                                            </p>
                                        </li>
                                        <li>
                                            <p class="mb-0">Punch Out at</p>
                                            <p class="res-activity-time">
                                                <i class="fa fa-clock-o"></i>
                                                11.00 AM.
                                            </p>
                                        </li>
                                        <li>
                                            <p class="mb-0">Punch In at</p>
                                            <p class="res-activity-time">
                                                <i class="fa fa-clock-o"></i>
                                                11.15 AM.
                                            </p>
                                        </li>
                                        <li>
                                            <p class="mb-0">Punch Out at</p>
                                            <p class="res-activity-time">
                                                <i class="fa fa-clock-o"></i>
                                                1.30 PM.
                                            </p>
                                        </li>
                                        <li>
                                            <p class="mb-0">Punch In at</p>
                                            <p class="res-activity-time">
                                                <i class="fa fa-clock-o"></i>
                                                2.00 PM.
                                            </p>
                                        </li>
                                        <li>
                                            <p class="mb-0">Punch Out at</p>
                                            <p class="res-activity-time">
                                                <i class="fa fa-clock-o"></i>
                                                7.30 PM.
                                            </p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Search Filter -->
                    <div class="row filter-row">
                        <div class="col-sm-3">  
                            <div class="form-group form-focus">
                                <div class="cal-icon">
                                    <input type="text" class="form-control floating datetimepicker">
                                </div>
                                <label class="focus-label">Date</label>
                            </div>
                        </div>
                        <div class="col-sm-3"> 
                            <div class="form-group form-focus select-focus">
                                <select class="select floating"> 
                                    <option>-</option>
                                    <option>Jan</option>
                                    <option>Feb</option>
                                    <option>Mar</option>
                                    <option>Apr</option>
                                    <option>May</option>
                                    <option>Jun</option>
                                    <option>Jul</option>
                                    <option>Aug</option>
                                    <option>Sep</option>
                                    <option>Oct</option>
                                    <option>Nov</option>
                                    <option>Dec</option>
                                </select>
                                <label class="focus-label">Select Month</label>
                            </div>
                        </div>
                        <div class="col-sm-3"> 
                            <div class="form-group form-focus select-focus">
                                <select class="select floating"> 
                                    <option>-</option>
                                    <option>2019</option>
                                    <option>2018</option>
                                    <option>2017</option>
                                    <option>2016</option>
                                    <option>2015</option>
                                </select>
                                <label class="focus-label">Select Year</label>
                            </div>
                        </div>
                        <div class="col-sm-3">  
                            <a href="#" class="btn btn-success btn-block"> Search </a>  
                        </div>     
                    </div>
                    <!-- /Search Filter -->

                    <div class="row">
                        <div class="col-lg-12">
                            <div class="table-responsive">
                                <table class="table table-striped custom-table mb-0">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Date </th>
                                            <th>Punch In</th>
                                            <th>Punch Out</th>
                                            <th>Production</th>                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${list_attendance}" var="o">
                                        <td>${o.id}</td>
                                        <td>${o.date}</td>
                                        <td>${o.time_in}</td>
                                        <td>${o.time_out}</td>
                                        <td>${o.production_time}</td>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /Page Content -->

            </div>
            <!-- Page Wrapper -->

        </div>
        <!-- /Main Wrapper -->

        <!-- Select2 JS -->
        <script src="js/select2.min.js"></script>

        <!-- Datetimepicker JS -->
        <script src="js/moment.min.js"></script>
        <script src="js/bootstrap-datetimepicker.min.js"></script>

    </body>
</html>