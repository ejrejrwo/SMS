<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<html>
<head>
<meta charset="UTF-8">

<title>${InsertTitle }</title>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>SB Admin 2 - Dashboard</title>

<!-- Custom fonts for this template-->
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<tiles:insertAttribute name="admin_import"/>
</head>
<body id="page-top">
	<div id="wrapper">
	    <div id="content-wrapper" class="d-flex flex-column">
      		<div id="content">
		        <div class="container-fluid">
		          <div class="d-sm-flex align-items-center justify-content-between mb-4" style="margin-top: 1.5rem!important;">
		            <h1 class="h3 mb-0 text-gray-800">${doc_title }</h1>
		          </div>
					<!-- DataTales Example -->		          
					<div class="card shadow mb-4">
					  <div class="card-header py-3">
					    <h6 class="m-0 font-weight-bold text-primary">${doc_sub_title }</h6>
					  </div>
				    	<tiles:insertAttribute name="admin_content"/>
					 </div>		          							        
		        </div>
		      <!-- Footer -->
		      <footer class="sticky-footer bg-white">
		        <div class="container my-auto">
		          <div class="copyright text-center my-auto">
		            <span>Copyright &copy; SMS 2019</span>
		          </div>
		        </div>
		      </footer>
		      <!-- End of Footer -->		        
      		</div>
		</div>
	</div>



  <!-- Bootstrap core JavaScript-->
  <!-- <script src="vendor/jquery/jquery.min.js"></script> -->
  <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/admin-js/sb-admin-2.min.js"></script>	
</body>
</html>