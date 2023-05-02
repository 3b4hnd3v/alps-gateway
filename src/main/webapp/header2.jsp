      <header class="main-header">
        <!-- Logo -->
        <a href="index.jsp" class="logo img-responsive">
          <!-- mini logo for sidebar mini 50x50 pixels -->
      	  <span class="logo-mini"><b>A</b>LPS</span>
      	  <!-- logo for regular state and mobile devices -->
      	  <span class="logo-lg"><b>ALPS</b> Gateway</span>
          <!-- mini logo for sidebar mini 50x50 pixels 
          <span class="logo-mini"><img alt="ALPS Gateway" width="50px" height="50px" class="img-responsive" src="dist/img/wheel.png"></span>-->
          <!-- logo for regular state and mobile devices 
          <span class="logo-lg"><img alt="ALPS Gateway" class="img-responsive" src="dist/img/wheel.png"></span>-->
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
          </a>
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <!-- Messages: style can be found in dropdown.less-->
              
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <img src="dist/img/avatar5.png" class="user-image" alt="User Image">
                  <span class="hidden-xs"><% out.println(session.getAttribute("name"));%> - <% out.println(session.getAttribute("role"));%></span>
                </a>
                <ul class="dropdown-menu">
                  <!-- User image -->
                  <li class="user-header">
                    <img src="dist/img/avatar5.png" class="img-circle" alt="User Image">
                    <p>
                      <% out.println(session.getAttribute("name"));%> - <% out.println(session.getAttribute("dept"));%>
                      <small>Admin Member</small>
                    </p>
                  </li>
                  <!-- Menu Body -->
                  <li class="user-body">
                    <div class="row">
                      <div class="col-xs-4 text-center">
                        <a href="#"><i class="fa fa-cubes"></i></a>
                      </div>
                      <div class="col-xs-4 text-center">
                        <a href="#"><i class="fa fa-diamond"></i></a>
                      </div>
                      <div class="col-xs-4 text-center">
                        <a href="#"><i class="fa fa-empire"></i></a>
                      </div>
                    </div>
                  </li>
                  <!-- Menu Footer-->
                  <li class="user-footer">
                    <div class="pull-left">
                      <a href="user_profile.jsp" class="btn btn-default btn-flat">Profile</a>
                    </div>
                    <div class="pull-right">
                      <a href="login.jsp?q=logout" class="btn btn-default btn-flat">Sign out</a>
                    </div>
                  </li>
                </ul>
              </li>
              <!-- Control Sidebar Toggle Button -->
              <li>
                <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
              </li>
            </ul>
          </div>
        </nav>
      </header>
