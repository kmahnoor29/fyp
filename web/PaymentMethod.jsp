<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%--
  Created by IntelliJ IDEA.
  User: mano
  Date: 3/22/2020
  Time: 4:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">

  <title></title>

  <!-- Bootstrap Core CSS -->
  <link href="../../css/bootstrap.min.css" rel="stylesheet">

  <!-- MetisMenu CSS -->
  <link href="../../css/metisMenu.min.css" rel="stylesheet">

  <!-- Timeline CSS -->
  <link href="../../css/timeline.css" rel="stylesheet">

  <!-- Custom CSS -->
  <link href="../../css/startmin.css" rel="stylesheet">

  <!-- Morris Charts CSS -->
  <link href="../../css/morris.css" rel="stylesheet">

  <!-- Custom Fonts -->
  <link href="../../css/font-awesome.min.css" rel="stylesheet" type="text/css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->
  <style>

    table.dataTable thead .sorting:after,
    table.dataTable thead .sorting:before,
    table.dataTable thead .sorting_asc:after,
    table.dataTable thead .sorting_asc:before,
    table.dataTable thead .sorting_asc_disabled:after,
    table.dataTable thead .sorting_asc_disabled:before,
    table.dataTable thead .sorting_desc:after,
    table.dataTable thead .sorting_desc:before,
    table.dataTable thead .sorting_desc_disabled:after,
    table.dataTable thead .sorting_desc_disabled:before {
      bottom: .5em;
    }


    .box{

      color: #fff;

      padding: 20px;

      display: none;

      margin-top: 20px;

    }
    .red{ background: #ff0000; }

  </style>
  <script>

    $(document).ready(function(){

      $('input[type="radio"]').click(function(){

        var inputValue = $(this).attr("value");

        var targetBox = $("." + inputValue);

        $(".box").not(targetBox).hide();

        $(targetBox).show();

      });

    });
  </script>
</head>
<body>

<%

  String driverName = "com.mysql.jdbc.Driver";
  String connectionUrl = "jdbc:mysql://localhost:3306/";
  String dbName = "login";
  String userId = "root";
  String password = "";
  String email1 = (String) session.getAttribute("email");

  try {
    Class.forName(driverName);
  } catch (ClassNotFoundException e) {
    e.printStackTrace();
  }
%>

<div id="wrapper">

  <!-- Navigation -->
  <nav class="navbar navbar-inverse navbar-fixed-top"  role="navigation" style="background-color:#008B8B; border-color:#008B8B ;">
    <div class="navbar-header">
      <a class="navbar-brand" href="index.html">
        <div style="color:white; font-size:30px">CD Services</b></div>
      </a>
    </div>

    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
      <span class="sr-only"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>



    <ul class="nav navbar-right navbar-top-links" style="background-color:#008B8B;" >
      <li class="dropdown navbar-inverse"style="background-color:#008B8B;">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#"style="background-color:#008B8B;">
          <i class="fa fa-bell fa-fw" style="color:white;"></i> <b class="caret" style="color:white;"></b>
        </a>
        <ul class="dropdown-menu dropdown-alerts">
          <li>
            <a href="#">
              <div>
                <i class="fa fa-twitter fa-fw"></i> 3 New messages
                <span class="pull-right text-muted small">12 minutes ago</span>
              </div>
            </a>
          </li>




        </ul>
      </li>
      <li class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown" href="#" style="background-color:#008B8B; color:white;">
          <i class="fa fa-user fa-fw" style="color:white;"></i>    <%
          if(session.getAttribute("email")!=null) {


            out.print(email1);
          }
        %><b class="caret" style="color:white;"></b>
        </a>
        <ul class="dropdown-menu dropdown-user">
          <li><a href="customerdashboad.jsp"><i class="fa fa-user fa-fw"></i> User Profile</a>
          <li class="divider"></li>
          <li><a href="/LogoutServlet"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
          </li>
        </ul>
      </li>
    </ul>
  </nav>
  <!-- /.navbar-top-links -->

  <div class="navbar-default sidebar" role="navigation">
    <div class="sidebar-nav navbar-collapse">
      <ul class="nav" id="side-menu">
        <br>
        <br>
        <br>
        <br>

        <li>
          <a href="customerdashboad.jsp" class="active"><i class="fa fa-dashboard fa-fw"></i>  Customer Dashboard</a>
        </li>
        <li>
          <a href="customerprofile.jsp"><i class="fa fa-table fa-fw"></i>Create Profile</a>
        </li>
        <li>
          <a href="customerinfo.jsp"><i class="fa fa-table fa-fw"></i>View General info</a>
        </li>
        <li>
          <a href="placeorder.jsp"><i class="fa fa-table fa-fw"></i>Place Order</a>
        </li>
      </ul>
    </div>
  </div>
  <div id="page-wrapper">
    <div class="container-fluid">
      <div class="row">
        <div class="col-lg-12">
          <h1 class="page-header"> Customer Dashboard</h1>
        </div>
        <!-- /.col-lg-12 -->
      </div>
      <!-- /.row -->

      <div class="row">



        <div class="col-sm-4">
          <div class="tab-content">



            <form class="form" action="/PaymentInsert.jsp" method="post" id="registrationForm">

              <h3>Please Select Your Payment Details.</h3>

              <div class="form-group">
                <label for="inputAddress3">Email</label>
                <input type="text" class="form-control" id="inputAddress3" name="email">
              </div>


              <div class="form-group">
                <div class="form-check">





                  <input class="form-check-input" type="radio" name="cash" id="cashon" value="Cash on Delivery">
                  <label class="form-check-label" for="cash">Cash on Delivery</label>
                  <br>
                  <br>

                  <h3>OR</h3>

                  <br>
                  <input class="form-check-input" type="radio" name="creditcard" id="creditcard" value="Credit Card">
                  <label class="form-check-label" for="cash">Credit Card</label>


                  <div class="form-group">
                    <label for="inputAddress3">Account No.</label>
                    <input type="text" class="form-control" id="inputAddress3" name="accountno"  >
                  </div>
                  <div class="form-group">
                    <label for="inputAddress3">Expire Date</label>
                    <input type="text" class="form-control" id="inputAddress3" name="expirydate" >
                  </div>
                  <div class="form-group">
                    <label for="inputAddress3">CVV</label>
                    <input type="text" class="form-control" id="inputAddress3" name="cvv" >
                  </div>
                </div>
              </div>





              <center><button onclick="clearForm(this.form);" type="reset"><a class="btn btn-success" style="background-color:#008B8B;" > <span>Reset</span></a></button>

                <button type="submit"><a class="btn btn-success" style="background-color:#008B8B;" > <span>Confirm Order</span></a></button>


              </center>

            </form>
            <%
              Connection connection = null;
              Statement statement = null;
              ResultSet resultSet = null;

              try{
              connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
              statement=connection.createStatement();
              String sql ="SELECT id FROM paymentmethod where email='"+email1+"'";

              resultSet = statement.executeQuery(sql);
              while(resultSet.next()){


            %>



            <button type="submit"><a  href="PaymentUpdate.jsp?id=<%=resultSet.getString("id") %>" class="btn btn-success" style="background-color:#008B8B;" > <span>Edit Payment Method?</span></a></button>




            <%


                }
                connection.close();
              }

              catch (Exception e)
              {
                e.printStackTrace();
              }

            %>




          </div>



          <div class="col-sm-4">


          </div><!--/tab-content-->

        </div><!--/col-9-->
      </div><!--/row-->
    </div>
  </div>

</div>
</div>

</div>

</div>
<!-- /#wrapper -->

<!-- jQuery -->
<script src="../../js/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="../../js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="../../js/metisMenu.min.js"></script>

<!-- Morris Charts JavaScript -->
<script src="../../js/raphael.min.js"></script>
<script src="../../js/morris.min.js"></script>
<script src="../../js/morris-data.js"></script>

<!-- Custom Theme JavaScript -->
<script src="../../js/startmin.js"></script>
<script>function clearForm(oForm) {

  var elements = oForm.elements;

  oForm.reset();

  for(i=0; i<elements.length; i++) {

    field_type = elements[i].type.toLowerCase();

    switch(field_type) {

      case "text":
      case "password":
      case "textarea":
      case "hidden":

        elements[i].value = "";
        break;

      case "radio":
      case "checkbox":

        if (elements[i].checked) {
          elements[i].checked = false;
        }
        break;

      case "select-one":
      case "select-multi":
        elements[i].selectedIndex = -1;
        break;

      default:
        break;
    }
  }
}</script>

</body>
</html>
