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
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->
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
		var factCode = "${param.factCode}";
	 	var branchNo = "${param.branchNo}";

		$(function(){
			loadAlertList();
		});
	 	
	 	function loadAlertList(){
			$.ajax({
				type:"post",
				url:"<c:url value='/alert/alertListView.do'/>",
				data:{factCode:factCode, branchNo:branchNo, startDate:"", endDate:"", type:"ALL"},
				dataType:"json",
				success:function(result){
	                var tot = result['alertList'].length;
	                var item;
	                
	                $("#dataList").html("");

	                if( tot <= "0" ){
	                	$("#dataList").html("<tr><td colspan='8'>조회 결과가 없습니다</td></td>");
	                }else{
		                for(var i=0; i < tot; i++){
		                    var obj = result['alertList'][i];
		
							//TR 색 변경                
		                    if(i%2!=0){ 
		                        trClass = "add";
		                    }else{
		                        trClass = "";
		                    }
		                    
		                   	item = "<tr class='"+trClass+"'><td>"+(i+1)+"</td>" 
								 +"<td id='rem"+i+"'>"+obj.sendDate+"</td>"
		    	                 +"<td id='rem"+i+"'>"+obj.part+"</td>"
		                       	 +"<td id='rem"+i+"'>"+obj.name+"</td>"
		                         +"<td id='rem"+i+"'>"+obj.telNo+"</td>"
		                         +"<td id='rem"+i+"'>"+obj.gubun+"</td>"
		                         +"<td id='rem"+i+"'>"+obj.susin+"</td>"
		                         +"<td id='rem"+i+"'>"+obj.smsMsg+"</td>"
		                 		 +"</tr>";
		                 		 
		           			$("#dataList").append(item);
		                    
		                }
	                }
				},
	            error:function(result){alert("error");}
			});
			
		}
	</script>		
</head>
<body class="subPop"><!-- 추가 및 수정 -->
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1>상황전파 이력</h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad"><!-- //추가 및 수정 -->
			
<div class="totalmntPop1">
		<div class="content">
			<table class="dataTable">
				<colgroup>
					<col width="40px" />
					<col width="100px" />
					<col width="140px" />
					<col width="70px" />
					<col width="90px"/>
					<col width="60px" />
					<col width="70px" />
					<col width="" />
				</colgroup>
				<thead id="dataHeader">
					<tr>
						<th scope="col">NO</th>
						<th scpoe="col">발송시간</th>
						<th scope="col">소속</th>
						<th scope="col">성명</th>
						<th scope="col">전화번호</th>
						<th scope="col">종류</th>
						<th scope="col">수신여부</th>
						<th scope="col">전송메시지</th>
					</tr>
				</thead>
			</table>
		<div class="overBox" style="border-top:solid 0px white">
			<table class="dataTable">
				<colgroup>
					<col width="40px" />
					<col width="100px" />
					<col width="140px" />
					<col width="70px" />
					<col width="90px"/>
					<col width="60px" />
					<col width="70px" />
					<col width="" />
				</colgroup>
				<tbody id="dataList">
					<tr>
						<td colspan="8">데이터를 불러오는 중 입니다...</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
</div><!-- 추가 및 수정 -->
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
</body>
</html>

