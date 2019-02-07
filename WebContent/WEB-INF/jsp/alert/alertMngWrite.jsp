<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
  /**
  * @Class Name : alertMngWrite.jsp
  * @Description : Alert Management Write 화면
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
<%-- 	</sec:authorize>		 --%>
	<script type='text/javascript'>		
		$(function () {

			$.datepicker.setDefaults({
			    monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			    showMonthAfterYear:true,
			    dateFormat: 'yy/mm/dd',
			    showOn: 'both',
			    buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			    buttonImageOnly: true
			});

			
			$("#receiptDate1").datepicker({
			    buttonText: '접수일시'			    
			});

			$("#spreadDate1").datepicker({
			    buttonText: '상황전파일시'			    
			});			

			if("${alertMngVO.sugye}" != "") {
				$('#sugye').attr("value","${alertMngVO.sugye}");
			} else {
				$('#sugye').attr("value","R01");
			}			

			adjustGongkuDropDown2();
			
		  	$('#sugye')
		   	.change(function(){
		   		adjustGongkuDropDown();
		   	})	
			   	
			$('#factCode').change(function(){
				adjustBranchDropDown();
			});	  	   	
		   	

			$('#save').click(function(){
				save();
			});				

			$('#spreadContent').keydown(function() {
				ChkByte(document.getElementById("spreadContent"), 80);
			});			
		});
		
		function adjustGongkuDropDown2()
		{	
			var sugyeCd = $('#sugye').val();
			var dropDownSet = $('#factCode');
			if( sugyeCd == 'all' ){
				dropDownSet.attr("disabled", true);
				dropDownSet.emptySelect();
			}else{
				dropDownSet.attr("disabled", false);
				$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getGongkuList.do", {sugye:sugyeCd}, function (data, status){
				     if(status == 'success'){     
				        //locId 객체에 SELECT 옵션내용 추가.
				        dropDownSet.loadSelect(data.gongku);

				        if("${alertMngVO.factCode}" != "") {
				        	dropDownSet.attr("value", "${alertMngVO.factCode}");
				        }			

				        if(typeof(adjustBranchDropDown) == "function") {
				        	adjustBranchDropDown();
				        }						        	        				             
				     } else { 
				    	 alert("공구 목록 가져오기 실패");
				        return;
				     }
				});
			}		
		}			

		function save() {
			if(!validation()) { return; }

			if($("#regId").val() == "") {
				$("#regId").attr("value", "<sec:authentication property="principal.userVO.id"/>");
			}

			$("#receiptTelNo").attr("value",$("#receiptTelNo1").val() + "-" + $("#receiptTelNo2").val() + "-" + $("#receiptTelNo3").val());
			$("#receiptDate").attr("value",$("#receiptDate1").val2() + addzero(Number($("#receiptDate2").val())) + addzero(Number($("#receiptDate3").val())));
			$("#spreadDate").attr("value",$("#spreadDate1").val2() + addzero(Number($("#spreadDate2").val())) + addzero(Number($("#spreadDate3").val())));
			$("#regId").attr("value","admin");
			document.dataFrm.action = "<c:url value='/alert/alertMngWriteProc.do'/>";
			document.dataFrm.submit();
		}	

		function validation() {
			if($("#mngTitle").val() == "") { alert("제목을 입력하여 주십시요."); return false; }
			if($("#receiptName").val() == "") { alert("이름을 입력하여 주십시요."); return false; }									
			if($("#receiptTelNo1").val() == "") { alert("연락처를 입력하여 주십시요."); return false; }									
			if($("#receiptTelNo2").val() == "") { alert("연락처를 입력하여 주십시요."); return false; }									
			if($("#receiptTelNo3").val() == "") { alert("연락처를 입력하여 주십시요."); return false; }									
			if($("#receiptDate1").val() == "") { alert("접수일시를 입력하여 주십시요."); return false; }															
			if($("#receiptDate2").val() == "") { alert("접수일시를 입력하여 주십시요."); return false; }															
			if($("#receiptDate3").val() == "") { alert("접수일시를 입력하여 주십시요."); return false; }															
			if($("#receiptContent").val() == "") { alert("상황(접수)내용을 입력하여 주십시요."); return false; }															
			if($("#spreadDate1").val() == "") { alert("상황전파일시를 입력하여 주십시요."); return false; }															
			if($("#spreadDate2").val() == "") { alert("상황전파일시를 입력하여 주십시요."); return false; }															
			if($("#spreadDate3").val() == "") { alert("상황전파일시를 입력하여 주십시요."); return false; }
																		
			if($("#sugye").val() == "") { alert("상황전파기관을 선택하여 주십시요."); return false; }															
			if($("#factCode").val() == "") { alert("상황전파기관을 선택하여 주십시요."); return false; }															
			if($("#branchNo").val() == "") { alert("상황전파기관을 선택하여 주십시요."); return false; }
																		
			if($("#spreadContent").val() == "") { alert("상황전파 내용을 입력하여 주십시요."); return false; }															
			if($("#etc").val() == "") { alert("기타내용을 입력하여 주십시요."); return false; }															

			return true;							
		}			

		function list(){
			var pIdx = document.listFrm.pageIndex.value;
			if(pIdx == "")
				document.listFrm.pageIndex.value = 1;		
				
		    document.listFrm.action = "<c:url value='/alert/alertMngList.do'/>";
		    document.listFrm.submit();		    
		}			

		function clearForm() {
			$('#dataFrm').clearForm();
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
		<form:form commandName="alertMngVO" id="dataFrm" name="dataFrm" method="post" onsubmit="return false;">
		<form:hidden path="mngId" />		
		<form:hidden path="receiptTelNo" />
		<form:hidden path="receiptDate" />
		<form:hidden path="spreadDate" />
		<form:hidden path="regId" />		
		<div id="content" class="sub_waterpolmnt">
			<div class="content_wrap page_alarmmng">
				<div class="inner_alertMngList">
					<div class="listView_write">
						<div class="popup_situReceive">
							<fieldset class="first">
								<legend class="hidden_phrase">날짜, 인적사항 입력 폼</legend>
								<table class="dataTable">
									<colgroup>
										<col width="130px" />
										<col width="80px" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">제목</th>
											<td colspan="2">
												<form:input path="mngTitle" cssClass="inputText style1" />
											</td>
										</tr>
										<tr>
											<th scope="row" rowspan="2">신고자 인적사항</th>
											<td class="tit">성명</td>
											<td>
												<form:input path="receiptName" cssClass="inputText style1" />
											</td>
										</tr>
										<tr>
											<td class="tit">연락처</td>
											<td>
												<form:select path="receiptTelNo1">													
													<option value="02">02</option>
													<option value="031">031</option>													
													<option value="032">032</option>
													<option value="033">033</option>		
													<option value="041">041</option>
													<option value="042">042</option>		
													<option value="043">043</option>																																																
													<option value="051">051</option>
													<option value="052">052</option>
													<option value="053">053</option>
													<option value="054">054</option>
													<option value="055">055</option>
													<option value="061">061</option>
													<option value="062">062</option>
													<option value="063">063</option>
													<option value="064">064</option>
													<option value="070">070</option>
													<option value="010">010</option>
													<option value="011">011</option>
													<option value="016">016</option>													
												</form:select>
												-
												<form:input path="receiptTelNo2" cssClass="inputText style2" maxlength="4" />
												-
												<form:input path="receiptTelNo3" cssClass="inputText style2" maxlength="4" />
											</td>
										</tr>
									</tbody>
								</table>
							</fieldset>
							<fieldset>
								<legend class="hidden_phrase">상황 입력 폼</legend>
								<table class="dataTable">
									<colgroup>
										<col width="130px" />
										<col />
									</colgroup>
									<tr>
										<th scope="row">접수일시</th>
										<td>
											<form:input path="receiptDate1" cssClass="inputText style1" />
											<form:input path="receiptDate2" cssClass="inputText style2" maxlength="2" />
											시
											<form:input path="receiptDate3" cssClass="inputText style2" maxlength="2" />
											분
										</td>
									</tr>
									<tr>
										<th scope="row">접수자</th>
										<td>수질 오염 방제 센터</td>
									</tr>
									<tr>
										<th scope="row">상황전파 유형</th>
										<td class="textArea1">
											<form:select path="receiptType" cssStyle="width:120px">											
												<form:option value="">선택</form:option>
											<c:forEach items="${codes}" var="codes">
												<form:option value="${codes.VALUE}" label="${codes.CAPTION}" />
											</c:forEach>												
											</form:select>											
										</td>										
									</tr>									
									<tr>
										<th scope="row">상황(접수)내용<br />(6하원칙)</th>
										<td class="textArea1">
											<form:textarea path="receiptContent" cssClass="textArea" />
										</td>										
									</tr>																		
									<!-- 
									<tr>
										<th scope="row">상황전파일시</th>
										<td>
											<form:input path="spreadDate1" cssClass="inputText style1" />
											<form:input path="spreadDate2" cssClass="inputText style2" maxlength="2" />
											시
											<form:input path="spreadDate3" cssClass="inputText style2" maxlength="2" />
											분
										</td>
									</tr>
									 -->
									<tr>
										<th scope="row">상황전파기관<br />(접수처)</th>										
										<td>
												<form:select path="sugye" cssStyle="width:120px">
												   <option value="R01">한강</option>
												   <option value="R02">낙동강</option>
												   <option value="R03">금강</option>
												   <option value="R04">영산강</option>												
												</form:select>												
												<span class="space">&gt;</span>
												<form:select path="factCode" cssStyle="width:120px">												
												</form:select>														
												<span class="space">&gt;</span>
												<form:select path="branchNo" cssStyle="width:120px">												
												</form:select>
										</td>
									</tr>
									<tr>
										<th scope="row">상황전파 내용</th>
										<td class="textArea2">
											<form:textarea path="spreadContent" cssClass="textArea" />
										</td>
									</tr>
									<tr>
										<th scope="row">기타사항</th>
										<td class="textArea3">
											<form:textarea path="etc" cssClass="textArea" />
										</td>
									</tr>
								</table>
							</fieldset>
							<ul class="btnMenu">
								<li><input id="save" type="image" src="<c:url value='/images/common/btn_regist.gif'/>" alt="등록" /></li>
								<li><a href="javascript:clearForm()"><img src="<c:url value='/images/common/btn_reWrite.gif'/>" alt="다시쓰기" /></a></li>
								<li><a href="javascript:list()"><img src="<c:url value='/images/common/btn_list.gif'/>" alt="목록" /></a></li>								
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div><!-- //content -->
		</form:form>
  		<form:form commandName="alertMngVO" name="listFrm" method="post">		
		<input type="hidden" name="pageIndex" value="${pageIndex}"/>
		</form:form>
	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>

