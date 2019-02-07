<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
/**
 * Class Name : alertSmsMsg.jsp
 * Description : 사용자가 발송했떤 SMS 메시지 목록을 가져온다.
 * Modification Information
 * 
 * 수정일			수정자			수정내용
 * -------		--------	---------------------------	
 * 2010.05.20	k			최초 생성
 * 2013.11.06	lkh			리뉴얼
 * 
 * author k
 * since 2010.05.20
 * 
 * Copyright (C) 2010 by k All right reserved.
 */ 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->
<script type="text/javascript">
	function setSmsMsg(str, smsHistId) {
		$.ajax({
			type: "POST",
			url: "<c:url value='/alert/alertSmsSettingMember.do?'/>",
			data: {
					smsHistId:smsHistId
				},
			dataType:"json",
			beforeSend : function(){},
			success : function(result){
				
				// 아이템 데이터 세팅
				var tot = result['list'].length;
				
				if( tot <= 0 ){
					alert("error")
				}else{
					opener.document.getElementById("smsMsg").value = str;
					opener.ChkByte1(str,80);
					opener.document.getElementById("sPerson").options.length = 0;
					
					for(var i=0; i < tot; i++){
						var obj = result['list'][i];
						var item =  "<option value="+ obj.MEMBERID +">" + obj.MEMBERNAME + "</>";
						
						if(obj.MEMBERID != '' && obj.MEMBERID != null){
							$("#sPerson", opener.document).append(item);
							$("#phoneNo", opener.document).val('');
						}else{
							opener.document.getElementById("sPerson").options.length = 0;
							$("#phoneNo", opener.document).val(obj.MOBILENO);
						}
					}
					self.close();
				}
			}
		});
	}
	
	function fnViewSmsMember(smsHistId){
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 200;
		var winWidth = 380;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		window.open("<c:url value='/alert/alertSmsMemberList.do?'/>smsHistId=" + smsHistId,
				'msgMemberPop','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
</script>
</head>
	
<body class="subPop"><!-- 추가 및 수정 -->
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1 style='font-size:large;font-weight:bold;color:white'>SMS 통보 이력</h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad"><!-- //추가 및 수정 -->
				<div class="asmPop" style="padding-top:5px">
					<div class="content">
					<div class="overBox">
						<table class="dataTable">
							<colgroup>
								<col />
								<col width="120px" />
								<col width="30px" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">메시지</th>
									<th scope="col">일자</th>
									<th scope="col">수신</th>
								</tr>
							</thead>
							<tbody id="userTbody">
								<c:forEach items="${msgList}" var="msg" varStatus="status">
									<tr>
										<td style="text-align: left;"><a href="#" onclick="setSmsMsg('${msg.SMSMSG}','${msg.SMSHISTID}')">&nbsp;${msg.SMSMSG}</a></td>
										<td>&nbsp;${msg.REGDATE}</td>
										<td><a href="#" onclick="fnViewSmsMember('${msg.SMSHISTID}')">&nbsp;${msg.CNT}</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->	
</body>
</html>
