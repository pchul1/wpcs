<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
  /**
  * @Class Name : alertTaksuConfig.jsp
  * @Description : Alert Target Config List 화면
  * @Modification Information
  * 
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2010.05.20     k        최초 생성
  *
  * author k
  * since 2010.05.20
  *  
  * Copyright (C) 2010 by k  All right reserved.
  */  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />	
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />		
	<sec:authorize ifAnyGranted="ROLE_USER">
		<script  type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
		</script> 
	</sec:authorize>
	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script  type='text/javascript'> -->
<!-- 			alert('로그인이 필요한 페이지 입니다'); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script>  -->
<%-- 	</sec:authorize>	 --%>
	<script>
		var isProcess = false;

		$(function(){
			/*shows the loading div every time we have an Ajax call*/  
		    pageLoding();
			$('#alertListTbody tr:odd').addClass('add');

			$('#search').click(function () {
				if(isProcess) {
					alert("처리중입니다.");
					return; 
				}			
				isProcess = true;		
				getAlertTaksuConfigList();
			});					
					
			getCode("34");			
		});
 
		function getAlertTaksuConfigList() {
			$.ajax({
				type:"post",
				url:"<c:url value='/alert/getAlertTaksuConfigList.do'/>",
				data:{},
				dataType:"json",
				success:function(result){
	                var tot = result['alertTaksuConfigList'].length;
	                $("#alertListTbody").html("");

	                if( tot <= "0" ){
	                	$("#alertListTbody").html("<tr><td colspan='4'>조회 결과가 없습니다</td></td>");
	                } else {	                
		                for(var j=0; j < tot; j++){
		                    var obj = result['alertTaksuConfigList'][j];          
		                    
		                    setRow(obj.factCode, obj.factName, obj.alertFlag, obj.alertDate, j,obj.alertEtcFlag);
		                }
	                }
	                isProcess = false;
				},
	            error:function(result){alert("error");isProcess = false;}
			});			
		}
		
		function saveAlertConfigData(idx){
			var factCode = $('input[name=factCode]').eq(idx).val();
			var alertFlag = $('select[name=alertFlag]').eq(idx).val();
			var alertEtcFlag = $('select[name=alertEtcFlag]').eq(idx).val();

			var msg = ""; 

			if(alertFlag == 0)
				msg = "전파 상태로 변경하시겠습니까?";
			else if(alertFlag == 1)
				msg = "전파를 2일 중지하시겠습니까?";
			else if(alertFlag == 2)
				msg = "전파를 3일 중지하시겠습니까?";
			else if(alertFlag == 3)
				msg = "전파를 4일 중지하시겠습니까?";
			
			if(confirm(msg)) {
				$.ajax({
					type:"post",
					url:"<c:url value='/alert/saveAlertTaksuConfig.do'/>",
					data:{factCode:factCode, alertFlag:alertFlag,alertEtcFlag:alertEtcFlag},
					dataType:"json",
					success:function(result){					 
						alert("저장했습니다.");
						isProcess = false;
						getAlertTaksuConfigList();	
					},
		            error:function(result){alert("error");isProcess = false;}
				});			
			}
		}		

		var alertFlagArr = new Array;
		function getCode(itemCode) {
			$.getJSON("<c:url value='/cmmn/getCode.do'/>", {code_id:itemCode}, function (data, status){
			     if(status == 'success'){     
			    	 alertFlagArr = data.codes;
			    	 
			    	 getAlertTaksuConfigList();
			     } else { 
			        //alert("ERROR!");
			        return;
			     }
			});			
		}		
		function setRow(factCode, factName, alertFlag, alertDate, idx,alertEtcFlag) {
			factCode 		= nullToString(factCode);			
			factName 		= nullToString(factName);			
			alertFlag 		= nullToString(alertFlag);			
			alertDate 		= nullToString(alertDate);
			alertEtcFlag 		= nullToString(alertEtcFlag);

			var selTmp = "<select name='alertFlag'>";
			
			for(var i=0; i<alertFlagArr.length; i++) {
				if(alertFlagArr[i].VALUE == alertFlag)
					selTmp += " <option value='"+alertFlagArr[i].VALUE+"' selected>"+alertFlagArr[i].CAPTION+"</option>";
				else
					selTmp += " <option value='"+alertFlagArr[i].VALUE+"'>"+alertFlagArr[i].CAPTION+"</option>";				
			}	
			selTmp += "</select>";	

			var selEtc = "<select name='alertEtcFlag'>";
				if(alertEtcFlag == 'STOP'){
					selEtc += " <option value='STOP' selected>장비고장</option>";
					selEtc += " <option value='START'>해당없음</option>";
				}else{
					selEtc += " <option value='START' selected>해당없음</option>";
					selEtc += " <option value='STOP'>장비고장</option>"; 
				}

			$('<tr></tr>')
				.append($('<td></td>')
							.append(factName)
							.append($('<input />').attr('name', 'factCode').attr('type', 'hidden').attr('value', factCode)))													
				.append($('<td></td>')
						.append(alertDate))
				.append($('<td></td>')
						.append(selTmp))
				.append($('<td></td>')
						.append(selEtc))								
				.append($('<td></td>')
						.append("<img src='<c:url value='/images/common/btn_save.gif'/>' style='cursor:pointer' onclick='saveAlertConfigData("+idx+")' />"))			
				.appendTo("#alertListTbody");		

			$('#alertListTbody tr:odd').addClass('add');			
		}
	</script>		
</head>
<body>
<div id='loadingDiv' style="visibility:hidden;position:absolute;">
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />	
</div>
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
			<div class="content_wrap page_alarmmng">
				<div class="inner_alarmstand">
					<!-- 경보 기준 설정 검색 -->
					<form action="" class="formBox" onsubmit="return false">
					</form>
					<!-- //경보 기준 설정 검색 -->					
					<!-- 경보 기준 설정 변경 -->					
					<form action="" onsubmit="return false">
						<fieldset>
							<legend class="hidden_phrase">탁수 경보 설정 변경</legend>
							<div class="data_wrap">												
								<div class="overBox">
									<table class="dataTable">
										<colgroup>
											<col width="100px" />																																											
											<col />											
											<col width="200px" />	
											<col width="100px" />										
											<col width="200px" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">공구</th>
												<th scope="col">상태</th>
												<th scope="col">설정</th>	
												<th scope="col">장비설정</th>											
												<th scope="col">저장</th>
											</tr>
										</thead>
										<tbody id="alertListTbody">											
										</tbody>
									</table>
								</div>								
							</div>
						</fieldset>
					</form>
					<!-- //경보 기준 설정 변경 -->
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