<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
	
	<script type='text/javascript'>
	var fact_code;
	var branch_no;
	var branch_name;
	
	$(function(){

		fact_code = '${param.fact_code}';
		branch_no = '${param.branch_no}';
		branch_name = '${param.branchName}'; 
		
		alertTargetList();

		$("#branch_name").text(branch_name);
		$("#atDepth").change(function(){ changeDepth(); });
	});

	function changeDepth()
	{
		alertTargetList();
	}
		
	function alertTargetList(){

		$("#alertDataList").html("");
		$("#alertDataList").html("<tr><td colspan='4'>데이터를 불러오는 중 입니다...</td></tr>");
		
		var atDepth = $("#atDepth").val();

		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getAlertTargetList.do'/>",
			data:{factCode:fact_code,
					branchNo:branch_no,
					atDepth:atDepth},
			dataType:"json",
			success:function(result){
	            var tot = result['refreshData'].length;  
				var trClass;
				
	            $("#alertDataList").html("");
	
	            if( tot <= "0" ){
					$("#alertDataList").html("<tr><td colspan='4'>조회 결과가 없습니다</td></tr>");
	
					// for(var i=0; i<1000; i++){
					//		$("#dataList").append("<tr code=1234 branchNo='1'><td colspan='4'>"+i+"조회 결과가 없습니다</td></tr>");
				    // }	
	            }else{
					for(var i=0; i < tot; i++){
						var obj = result['refreshData'][i];
		
		                var item;
		                    
						item = "<tr>"
								+"<td>"+obj.atName+"</td>"
								+"<td>"+obj.atPart+"</td>"
								+"<td>"+obj.atPosition+"</td>"
								+"<td>"+obj.atSmsTele+"</td>"
								+"</tr>";
								
						$("#alertDataList").append(item);
		                    
					}
	            }

	            $("#alertDataList tr:odd").addClass("add");	
	
			},

			
	        error:function(result){
					$("#alertDataList").html("<tr><td colspan='4'>서버접속 실패</td></tr>");
		        }
		});
	}
	
	</script>		
</head>
<body class="pop_basic">
<div class="totalmntPop1">
	<div class="header">
		<h1>측정소 상황전파 대상자 정보</h1>
	</div>
	<div class="content">
		<div>
			<form action="" style="display:none;">
				<ul class="selectList">
					<li><span class="buArrow_tit">경보단계</span>
							<select id="atDepth">
								<option value="all">전체</option>
								<option value="0">정상</option>
								<option value="1">관심</option>
								<option value="2">주의</option>
								<option value="3">경계</option>
								<option value="4">심각</option>
							</select>
					</li>
				</ul>
			</form>
		</div>
		<table class="dataTable" style="margin-top:20px;">
			<colgroup>
				<col width="120px" />
				<col width="200px" />
				<col width="90px" />
				<col width="" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">이름</th>
					<th scope="col">소속</th>
					<th scope="col">직책</th>
					<th scope="col">연락처</th>
				</tr>
			</thead>
		</table>
	<div class="overBox overBoxOther"  style="border-top:solid 0px white">
		<table class="dataTable">
			<colgroup>
				<col width="120px" />
				<col width="200px" />
				<col width="90px" />
				<col width="" />
			</colgroup>
			<tbody id="alertDataList">
				<tr>
				<td colspan="4">데이터를 불러오는 중 입니다...</td>
				</tr>
			</tbody>
		</table>
	</div>
		</div>
	</div>
</body>
</html>

