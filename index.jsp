<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  session = "true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>GSD</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="http://fonts.googleapis.com/earlyaccess/hanna.css" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="./css/main_style.css">
        <link rel="stylesheet" href="./css/show_category.css">
        <link rel="stylesheet" href="./css/accordion.css">
        <link rel="stylesheet" href="./css/jquery-ui-1.8.16.custom.css">
        <script src="./js/jquery-1.11.1.min.js"></script>
        <script src="https://code.jquery.com/ui/1.8.16/jquery-ui.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>

	    <link href="<c:url value="/css/toastr.css"/>" rel="stylesheet"/>
   		<script src="<c:url value="/js/toastr.js"/>"></script>
   		<script src="<c:url value="/js/show_schedule.js"/>"></script>
   		<script src="<c:url value="/js/submit.js"/>"></script>
        <script src="<c:url value="/js/basic_function.js"/>"></script>
        <!-- 창을열고 닫을 때 toggle기능 -->
        <script src="<c:url value="/js/show_category.js"/>"></script>
   		
   		<script>   		
   		$(document).ready(function(){
   			toastr.options = {
   				    timeOut: 0,
   				    extendedTimeOut: 0
   				};
   			<c:forEach items="${workList}" var="work">
   				toastr.warning("마감 기한이 얼마남지 않았습니다.", "${work.workName}");
   			</c:forEach>
   			
   			function close_accordion_section(){
   	   			$('.accordion .accordion-section-title').removeClass('active');
   	   			$('.accordion .accordion-section-content').slideUp(300).removeClass('open');
   			}
   			$('.accordion-section-title').click(function(e) {
   				var currentAttrValue = $(this).attr('href');
   				if($(e.target).is('.active')) {
   					close_accordion_section();
   				}else {
   					close_accordion_section();

   					$(this).addClass('active');
	   				$('.accordion ' + currentAttrValue).slideDown(300).addClass('open');
   				}
   				e.preventDefault();
   			});

   		});	
   		
   		function addCategory(){
   			var inputCategoryNmae = $("#category_name").val();
   			toastr.options = {
   				    timeOut: 1000
   			};
			if(inputCategoryNmae==''||inputCategoryNmae==null)
				toastr.error('NULL Excption');
			else{
				$.post("Category/Submit", {
	   				categoryName : inputCategoryNmae,
	   			},
	   			
	   			function(data){
	   				if(data=='success'){
	   					location.reload();
	   				}else if(data=='fail'){
	   					toastr.error('Exist Category');
	   				}
	   			}); 
			}
   		}
   		
   		function deleteCategory(){
   			
   			alert("입력한 비밀번호와 관리자 비밀번호를 비교하여 디비에서 카테고리 및 그에 속한 프로젝트 그리고 프로젝트에 속한 사원들 정보 모두 삭제");
   		}
   		
   		function addProject(){
   			var inputCategory = $("select[name=category_selected]").val();
			var inputProjectName = $("#project_name").val();
			var inputStartDate = $("#start_date").val();
			var inputEndDate = $("#finish_date").val();
			
			if(inputProjectName==''||inputProjectName==null)
				toastr.error('project name is null');
			else if(inputStartDate==''||inputStartDate==null)
				toastr.error('start date is null');
			else if(inputEndDate==''||inputEndDate==null)
				toastr.error('finish date is null');
			else if(inputEndDate<inputStartDate)
				toastr.error('end date is eailer than start date');
			else {
				$.post("Project/Submit", {
	   				categoryID : inputCategory,
	   				projectName : inputProjectName,
	   				//startDate : inputStartDate,
	   				projectDeadline : inputEndDate,
	   			},
	   			function(data){
	   				if(data=='success'){
	   					location.reload();
	   				}
	   			});
			}

   		}
   		
   		//function move_project_page(category_num, project_num){
   		//	alert(category_num+" "+project_num);
   			
   		//	location.href = "show_schedule";
   		//}
   		
		function move_project_page(category_num, project_num){
   			alert(category_num+" "+project_num);
   			
   			location.href = "show_schedule/"+category_num+"/"+project_num;
   			
   		}
   		
   		function logout(){
			$.post("Logout", {});
			location.href="<c:url value="/"/>";	
   		}
   		
   		function member(){
   			location.href="<c:url value="/Employee"/>";	
   		}
   		
   		</script>
	</head>
	<body class="w3-light-grey">
        <!-- Top container -->
        <div class="w3-bar w3-top w3-black w3-large" style="z-index:4">
            <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  Menu</button>
            <!-- 화면 크기 줄였을때 나오는 메뉴버튼 -->
            <span class="w3-bar-item w3-left" onClick="location.href = 'index';">GSD</span> <!-- 홈버튼 -->
        </div>

        <!-- Sidebar/menu -->
        <nav class="w3-sidebar w3-collapse w3-white w3-animate-left" id="mySidebar"><br>
            <div class="w3-container w3-row">
                <div class="w3-col s4">
                    <img src="./images/user.png" class="w3-circle w3-margin-right" style="width:46px;">
                </div>
                <div class="hide-tag w3-col s8 w3-bar">
                    <span>Welcome, <strong><%= session.getAttribute("name") %></strong></span><br>
                    <a href="#" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i></a>
                    <a href="#" class="w3-bar-item w3-button"><i class="fa fa-user"></i></a>
                    <a href="#" class="w3-bar-item w3-button"><i class="fa fa-cog"></i></a><br>
                    <span class="w3-bar-item w3-left" onClick="logout()">Logout</span> <!-- 로그아웃 -->
                </div>
            </div>
            <hr>
            <div class="w3-container">
                <h5 class="hide-tag">Menu</h5>
            </div>
            <div class="w3-bar-block">
                <!-- 화면 크기 줄였을때 나오는 메뉴버튼 -->
                <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
                <!-- 현재 자신의 프로젝트에 참여중인 member -->
                <a href="#" class="side-meun w3-bar-item w3-button w3-padding">
                    <div class="container">
                        <i class="fa fa-users fa-fw"></i><span class="hide-tag" onClick="member()">  Member Manage</span>
                    </div>
                </a>
                <!-- project 관리 - 클릭하면 프로젝트 수정가능 -->
                <a href=".project-manage" class="side-meun w3-bar-item w3-button w3-padding" data-toggle="modal" data-target="#CategoryManage">
                    <div class="container">
                        <i class="fa fa-archive fa-fw"></i><span class="hide-tag" >  Category Manage</span>
                    </div>
                </a>
            </div>
            <div class="side-change-btn-right w3-bar-item w3-button w3-padding" onclick="sidebarChange('right')"><i class="fa fa-chevron-right"></i></div>
            <div class="side-change-btn-left w3-bar-item w3-button w3-padding" onclick="sidebarChange('left')"><i class="fa fa-chevron-left"></i></div>
        </nav>
		
		<!-- 카테고리 관리 Modal -->
        <div class="modal fade" id="CategoryManage" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <!-- Modal 헤더 -->
                    <div class="modal-header">
                        <h5 class="modal-title">Category Manage</h5>
                        <!-- 닫기 버튼 -->
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <!-- Modal 바디 -->
                    <div class="modal-body"> 
                        <div class="form-group">
                            <label for="category-list">Category</label>
                            <select class="form-control" name="category_selected">
								<c:forEach items="${categoryList}" var="category">
									<option value="${category.categoryID}">${category.categoryName}</option>
	                            </c:forEach>
                            </select>
                            <!-- 존재하는 카테고리목록들 -->
                        </div>
                        <div id="CategoryAdd" class="panel-collapse collapse">	                        
                        	<hr>
                        		<div class="form-group" style="margin-right:0;">
		                            <label for="schedule-name" class="col-form-label">Category Name</label>
		                            <input type="text" class="form-control" name="category_name" id="category_name">
		                            <!-- 추가할 프로젝트 이름 -->
		                        </div>
                           	
                           	<button onClick="addCategory()" class="btn btn-primary">Add</button>
                        </div>
                        <div id="edit_schedule" class="panel-collapse collapse">	                        
                        	<hr>
                        		<div class="form-group" style="margin-right:0;">
		                            <label for="schedule-name" class="col-form-label">Category Name</label>
		                            <input type="text" class="form-control" name="schedule_name">
		                            <!-- 추가할 프로젝트 이름 -->
		                        </div>
                           	
                           	<button type="submit" class="btn btn-primary">Edit Complete</button>
                        </div>
                        <div id="delete_question" class="panel-collapse collapse">
                        	<hr>
                        	<label for="password_ask" class="col-form-label">Password</label>
                           	<input type="text" class="form-control" id="password_ask">
                           	
                           	<button type="submit" class="btn btn-primary" onclick="deleteCategory()">Password Check</button>
                        </div>
                    </div>
                    <div class="modal-footer">
                    	<button type="button" class="btn btn-primary" data-toggle="collapse" data-target="#CategoryAdd">add</button>
                        <button type="button" class="btn btn-success" data-toggle="collapse" data-target="#edit_schedule">Edit</button>
                        <button type="button" class="btn btn-danger" data-toggle="collapse" data-target="#delete_question">Delete</button>
                        <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
		
		
		
		
        <!-- Overlay effect when opening sidebar on small screens -->
        <div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>
		
        <!-- !PAGE CONTENT! -->
        <div class="w3-main" style="margin-left:300px;margin-top:43px; padding-top:70px;">            
		<div class="accordion" style="margin-left:20%; margin-right:30%;">
			<%	int i=1;	%>
			<c:forEach items="${categoryList}" var="category"> <!-- 카테고리 별로 프로젝트 보여주는 부분 -->
			<div class="accordion-section">
				<a class="accordion-section-title" href="#accordion-<%=i%>">${category.categoryName}</a>
				<c:forEach items="${projectList}" var="project">
					<% int j=1; %>
					<c:if test="${category.categoryID==project.categoryID}">
						<% j=j+1; %>
						<div id="accordion-<%=i%>" class="accordion-section-content" onclick="move_project_page(<%=i%>,<%=j%>)">
							<p>${project.projectName} | ${project.projectDeadline}</p>
						</div><!--end .accordion-section-content-->
					</c:if>
				</c:forEach>
				</div><!--end .accordion-section-->
				<% i=i+1; %>
			</c:forEach>	
		</div><!--end .accordion-->
        </div>
        <!-- End page content -->

        <!-- 카테고리와 프로젝트 추가 버튼-->
        <div class="add-btn-group">
            <button type="button" class="add-btn btn btn-info" data-toggle="modal" data-target="#ProjectAdd">
                Project Add
            </button>
        </div>

        <!-- 프로젝트 추가 Modal -->
        <div class="modal fade" id="ProjectAdd" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <!-- Modal 헤더 -->
                    <div class="modal-header">
                        <h5 class="modal-title">Project Add</h5>
                        <!-- 닫기 버튼 -->
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <!-- Modal 바디 -->
                    <div class="modal-body"> 
                        <div class="form-group">
                            <label for="category-list">Category</label>
                            <select class="form-control" name="category_selected">
								<c:forEach items="${categoryList}" var="category">
									<option value="${category.categoryID}">${category.categoryName}</option>
	                            </c:forEach>
                            </select>
                            <!-- 존재하는 카테고리목록들 -->
                        </div>
                        <div class="form-group" style="margin-right:0;">
                            <label for="project-name" class="col-form-label">Project</label>
                            <input type="text" class="form-control" name="project_name" id="project_name">
                            <!-- 추가할 프로젝트 이름 -->
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6" style="margin-right:0;">
                                <label for="start_date" class="col-form-label">Start Date</label>
                                <input type="date" class="form-control" name="start_date" id="start_date">
                                <!-- 추가할 프로젝트 이름 -->
                            </div>
                            <div class="form-group col-md-6" style="margin-right:0;">
                                <label for="finish_date" class="col-form-label">Finish Date</label>
                                <input type="date" class="form-control" name="finish_date" id="finish_date">
                                <!-- 추가할 프로젝트 이름 -->
                            </div>    
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" onclick="addProject()" class="btn btn-primary">Add</button>
                    </div>
                </div>
            </div>
        </div>

		
	</body>
</html>
