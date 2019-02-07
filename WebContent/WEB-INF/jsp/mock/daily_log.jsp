<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

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
<%-- 	</sec:authorize> --%>
	
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	
	<c:if test="${isOk != null}">
		<script type="text/javascript">
			var test = "${isOk}";
			if(test == "ok")
				alert("등록되었습니다");
			else
				alert("등록실패!");
		</script>
	</c:if>
	<script type="text/javascript">
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
		
		$("#daylogDate").datepicker({
		    buttonText: '일자'		    
		});
				
		var today = new Date(); 

		todate = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());

		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}

		$("#daylogDate").val(todate);

		var time = today.getHours();

		$("#daylogTime > option[value="+time+"]").attr("selected", "selected");

		setPerson();
	});


	function setPerson()
	{
		var dropDownSet1 = $("#pWorker1");
		var dropDownSet2 = $("#pWorker2");
		var dropDownSet3 = $("#pWorker3");
		var dropDownSet4 = $("#pWorker4");

		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>", 
				{
					orderType:"2",
					value:"1001"
				},
				//, system:sys_kind}, 
				function (data, status){
			     if(status == 'success'){     
			        //locId 객체에 SELECT 옵션내용 추가.
			       
			        dropDownSet1.loadSelect(data.groupList);
			        dropDownSet2.loadSelect(data.groupList);
			        dropDownSet3.loadSelect(data.groupList);
			        dropDownSet4.loadSelect(data.groupList);
					//adjustBranchList();
						
			     } else { 
			        return;
			     }
		});
	}

	function save()
	{
		if(validate())
		{
			if(confirm("근무기록을 저장하시겠습니까?"))
			{
				$("#daylogDate").val($("#daylogDate").val2());
	
	
				document.frm.worker1.value = $("#pWorker1 option:selected").text();
				document.frm.worker2.value = $("#pWorker2 option:selected").text();
				document.frm.worker3.value = $("#pWorker3 option:selected").text();
				document.frm.worker4.value = $("#pWorker4 option:selected").text();
				
				document.frm.action = "<c:url value='/mock/insertDayLog.do'/>";
				document.frm.submit();
			}
		}
		else
		{
			alert("데이터를 입력해 주세요");			
		}
	}

	function validate()
	{
		if($("#content1").val() == ""){
			$("#content1").focus();
			return false;
		}
		if($("#content_2").val() == ""){
			$("#content_2").focus();
			return false;
		}
		if($("#content3").val() == ""){
			$("#content3").focus();
			return false;
		}
		if($("#wrkNote").val() == ""){
			$("#wrkNote").focus();
			return false;
		}
		if($("#wrkContent").val() == ""){
			$("#wrkContent").focus();
			return false;
		}

		return true;
	}
	function commonWork() {
		var stdt = document.getElementById("daylogDate");
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;

		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				
				var returnValue = commonWork2(stdt.value, "daylogDate");
				
				//숫자만 입력 체크를 통과못하면.
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					stdt.value = "";
					stdt.focus;
					return false;
				}
			}
		}

	}
	
	//숫자만 입력했을때 자동완성을 위한 함수
	// 1. 8자리 체크
	// 2. 1000 년이후 체크
	// 3. 월 체크
	// 4. 일 체크
	function commonWork2(dateValue, inputId){
		var returnValue = "";
		var checkNum = "";
		
		for(var i=0 ; i<dateValue.length ; i++){
			var checkCode = dateValue.charCodeAt(i);
			
			//숫자로만 이루어져 있는지 여부 체크.
			if( checkCode >= 48 && checkCode <= 57 ){
				checkNum    = "true";
			}else{
				returnValue = "false";
				checkNum    = "false";
				break;
			}
		}
		
		//숫자로만 이루어져 있다면.
		if(checkNum == "true"){
			if( dateValue.length != 8){ //8자리가 아니면 false;
				returnValue = "false";
			}else{
				
				//년 비교
				if( !(1000 < Number(dateValue.substr(0,4)) && Number(dateValue.substr(0,4)) <= 9999 )){
					returnValue = "false";
				}else{
					var month = ["01","02","03","04","05","06","07","08","09","10","11","12"];
					var monthCheck = 'false';
					
					for(var j=0 ; j < month.length ; j++){
						if(Number(dateValue.substr(4,2)) == month[j]){
							monthCheck = 'true';
							break;
						}
					}
					
					//월 비교 통과했다면.
					if(monthCheck == 'true'){
						var day = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
						var dayCheck = 'false';
						
						for(var k=0 ; k < day.length ; k++){
							if(Number(dateValue.substr(6,2)) == day[k]){
								dayCheck = 'true';
								break;
							}
						}
						
						//일체크를 통과했다면.
						if(dayCheck == 'true'){
							var tempVar = dateValue.substr(0,4) + '/' + dateValue.substr(4,2) + '/' + dateValue.substr(6,2);
							document.getElementById(inputId).value = tempVar;
							returnValue = 'true';
						}else{
							returnValue = "false";
						}
						
					}else{
						returnValue = "false";
					}						
				}				
			}	
		}
		return returnValue;
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
			<form name="frm" method="post">
			<div class="content_wrap page_alarmmng">
				<div class="inner_alarmhis">					
					
                    <!-- 1.일자 --> 
					<div class="data_wrap">
					     <dl class="tit_h4" style="font-weight:bold;">
                         	<dt>1. 일자 :</dt>
                         	<dd class="time">
										<input type="text" class="inputText"  id="daylogDate" name="daylogDate" size="15" onchange="commonWork()"/>
											<select id="daylogTime" name="daylogTime" style="width:50px">
												<option value="00">00</option>
												<option value="01">01</option>
												<option value="02">02</option>
												<option value="03">03</option>
												<option value="04">04</option>
												<option value="05">05</option>
												<option value="06">06</option>
												<option value="07">07</option>
												<option value="08">08</option>
												<option value="09">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23">23</option>
											</select> 시
							</dd>
                            <dt class="right">날씨 :</dt>
                         	<dd>
										<select id="weather" name="weather" style="width:100px">
											<option value="S">맑음</option>
											<option value="C">흐림</option>
											<option value="R">비</option>
											<option value="N">눈</option>
											<option value="M">안개</option>
										</select>
							</dd>
                         </dl>
                       <!-- 1.일자 --> 	
                    
                   	<!-- 2.근무상황 --> 
					     <div style="padding:7px 0 10px 0; font-weight:bold;">2. 근무 상황</div> 
							<table class="dataTable">
									<colgroup>
										<col width="220" />
                                        <col />
									</colgroup>
									<thead>
										<tr>
											<th class="bgStyle" scope="col">구분</th>
											<th class="bgStyle" scope="col">내용</th>
										</tr>
								   </thead>
								   <tbody>
                                    <tr>
										<th class="txtP" scope="row">
                                         <ul class="checkList4">
                                         <li>오전 (07:00 ~ 15:00)</li>
                                         <li>
                                         근무자 : 
                                         <select id="pWorker1" name="paramWorker1" style="width:120px">
											<option value=""></option>
										 </select>
										 <input type="hidden" name="worker1"/>
                                         </li>
                                         </ul>
                                        </th>
                                        <td>
                                         <textarea class="checkList4" id="content1" name="content1"></textarea>
                                        </td>
									</tr>
                                    <tr>
										<th class="txtP" scope="row">
                                         <ul class="checkList4">
                                         <li>오후 (15:00 ~ 23:00)</li>
                                         <li>
                                         근무자 : 
                                         <select id="pWorker2" name="paramWorker2" style="width:120px">
										 </select>
										 <input type="hidden" name="worker2"/>
                                         </li>
                                         </ul>
                                        </th>
                                        <td>
                                         <textarea class="checkList4" id="content_2" name="content2"></textarea>
                                        </td>
									</tr>
                                    <tr>
										<th class="txtP" scope="row">
                                         <ul class="checkList4">
                                         <li>야간 (23:00 ~ 07:00)</li>
                                         <li>
                                         근무자 : 
                                         <select id="pWorker3" name="paramWorker3" style="width:120px">
										 </select>
										 <input type="hidden" name="worker3"/>
                                         </li>
                                         </ul>
                                        </th>
                                        <td>
                                         <textarea class="checkList4" id="content3" name="content3"></textarea>
                                        </td>
									</tr>
                                    <tr>
										<td colspan="2" class="txtP">
                                        <dl class="tit_h5">
                         				<dt class="sp1">특이사항</dt>
                         				<dd class="sp2">
										<textarea class="checkList5" id="wrkNote" name="wrkNote"></textarea>
										</dd>
                         				</dl>
                                       </td>
									</tr>
                                    <tr>
										<th class="txtP" scope="row">당일근무</th>
                                        <td class="txtP">
                                         <div class="sp2">
                                         시간 ( 
                                         	<select id="hTime1" name="HTime1" style="width:50px">
											<%for(int i = 0 ; i < 24 ; i ++){%>
												<option value="<%=i%>"><%=i%></option>
											<%}%>
											</select> : 
                                            <select id="mTime1" name="MTime1" style="width:50px">
											<%for(int i = 0 ; i < 60 ; i += 10){%>
												<option value="<%=i%>"><%=i%></option>
											<%}%>
											</select>
											~ 
                                            <select id="hTime2" name="HTime2" style="width:50px">
											<%for(int i = 0 ; i < 24 ; i ++){%>
												<option value="<%=i%>"><%=i%></option>
											<%}%>
											</select> : 
                                            <select id="mTime2" name="MTime2" style="width:50px">
											<%for(int i = 0 ; i < 60 ; i += 10){%>
												<option value="<%=i%>"><%=i%></option>
											<%}%>
											</select>
                                             )
                                            </div>
                                        </td>
									</tr>
                                    <tr>
										<td colspan="2" class="txtP">
                                        <dl class="tit_h5">
                         				<dt class="sp3">-<br /><br />-</dt>
                         				<dd class="sp4">
										<textarea class="checkList6" id="wrkContent" name="wrkContent"></textarea>
										</dd>
                         				</dl>
                                       </td>
									</tr>
                                    <tr>
										<td colspan="2" class="num">
                                        <div class="sp5">
                                        근무자 : 
                                         <select id="pWorker4" name="paramWorker4" style="width:120px">
										 </select>
										 <input type="hidden" name="worker4"/>
                                        </div>
                                       </td>
									</tr>
                                   </tbody>
								</table>
					<!--// 2.근무상황 --> 
                    
                    
                                
                                
                              <!-- Btn -->   
                             <ul class="btnMenu">
								<li><a href="javascript:save()"><img src="<c:url value='/images/common/btn_save2.gif'/>" alt="저장"/></a></li>
								<li><a href=""><img src="<c:url value='/images/common/btn_cancel2.gif'/>" alt="취소"/></a></li>
							</ul>
                            <!--// Btn -->      
                               
					</div>
					
                    
                         
                               
                    
				</div>
			</div>
			</form>
		</div><!-- //content -->

	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>
