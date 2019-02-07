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
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>	
	
	<script language="javascript">
	$(function(){
		$("#dataList tr:odd").attr("class","add");
	});

	function setRegdate(value, idx)
	{
		if(value == "NO")
			$("#reg_date_"+idx).text('-');
		else
		{
			get_regDate($("#reg_date_"+idx), value);
		}
	}


	//선택된 지점에 해당하는 등록일을 가져옵니다.
	function get_regDate(obj, value)
	{	
		$.getJSON("<c:url value='/waterpolmnt/algasmng/getAlgaPoint.do'/>", {value:value}, function (data, status){
		     if(status == 'success'){  
			     if(data.algasPoint != null && data.algasPoint.length != 0)
			     {   
		       		 obj.text(data.algasPoint[0].reg_Date);
			     }
		     } else { 
		    	alert(status);
		        return;
		     }
		});
	}

	
	function save()
	{
		var cnt = $("#cnt").val();

		for(var idx = 0 ; idx < cnt ; idx++)
		{
			var id = $("#uniq_id_" + idx).val();
			var value = $("#survey_point_" + idx).val();

			$.getJSON("<c:url value='/waterpolmnt/algasmng/insertPointMap.do'/>", {point_id:value, uniq_id:id}, function (data, status){
			     if(status == 'success'){  
				   	saveSuccess();
			     } else { 
			    	alert(status);
			        return;
			     }
			});
		}
	}

	var successCnt = 0;
	function saveSuccess()
	{
		successCnt++;
		
		var cnt = $("#cnt").val();

		if(cnt <= successCnt)
		{
			alert("저장되었습니다.");
			successCnt = 0;
		}
	}
	</script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<c:import url="/common/menu/header.do" />
	</div><!-- //header -->
	<div id="container">
		<!-- 사이드 리스트 -->
		<div id="snb" class="snb">
			<c:import url="/common/menu/left.do" />
		</div>
		<!-- //사이드 리스트 -->
		<!-- navi 리스트 -->
		<div>
			<c:import url="/common/menu/navi.do" />
		</div>
		<!-- //navi 리스트 -->
		
		<!-- content -->
		<div id="content" class="sub_waterpolmnt">
			<div class="content_wrap page_waterinfo">
				<div class="inner_alga_point_mnt">
					<form  id="insertForm" method="post" class="formBox">
					<input type="hidden" id="cnt" name="cnt"></input>
						<table class="dataTable">
							<colgroup>
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">이름</th>
									<th scope="col">관리기관</th>
									<th scope="col">수질검사기관</th>
									<th scope="col">직급</th>
									<th scope="col">연락처</th>
									<th scope="col">지점</th>
									<th scope="col">시행년도</th>
								</tr>
							</thead>
							<tbody id="dataList">
								<c:forEach items="${algaPointMnt}"  var="algaPointMnt"  varStatus="status">
									<tr>
										<td>${algaPointMnt.member_nm}<input type="hidden" id="uniq_id_${status.index}" value="${algaPointMnt.uniq_id}"/></td>
										<td>${algaPointMnt.address}</td>
										<td>${algaPointMnt.dept_name}</td>
										<td>${algaPointMnt.grade_name}</td>
										<td>${algaPointMnt.mobile_no}</td>
										<td>
											<script language="javascript">
											 	var flag = false;
											</script>
											<select id="survey_point_${status.index}" name="survey_point_${status.index}" style="width:120px;" onchange="setRegdate(this.value, '${status.index}')">
													<option value="NO">없음</option>
												<c:forEach items="${algaPoint}"  var="algaPoint"  varStatus="status2">
													<option value="${algaPoint.value}">${algaPoint.caption}</option>
													<script language="javascript">
													    if(!flag)
													    {
															var algaPointName = '${algaPoint.caption}';
															var algaPointValue = '';
	
															if(algaPointName == '${algaPointMnt.point_name}')
															{
																algaPointValue = '${algaPoint.value}';
																flag = true;
															}
															else
																algaPointValue = 'NO';			
													    }
													</script>
												</c:forEach>
											</select>
											<script language="javascript">
												$("#survey_point_${status.index} > option[value="+ algaPointValue +"]").attr("selected", "true");
												$("#cnt").val("${status.count}");
											</script>
										</td>
										<td><span id="reg_date_${status.index}">${algaPointMnt.reg_date}</span></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<ul class="dataBtn">
							<li><a href="javascript:save()"><img src="<c:url value='/images/common/btn_save2.gif'/>" alt="저장" /></a></li>
							<li><a href="./goAlgaPointMnt.do"><img src="<c:url value='/images/common/btn_cancel2.gif'/>" alt="취소" /></a></li>
						</ul>
					</form>
				</div>
			</div>
		</div><!-- //content -->
	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>
