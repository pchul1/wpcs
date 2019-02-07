<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<script type="text/javascript">
		var admin;
	</script>
	
	<c:if test="${isAirGroup == false}">
<%-- 		<sec:authorize ifNotGranted="ROLE_ADMIN"> --%>
<!-- 			<script language="javascript"> -->
<!-- 				alert("항공감시 정보를 입력할 권한이 없습니다!"); -->
<!-- 				history.back(); -->
<%-- 				//window.location = "<c:url value='/'/>";  --%>
<!-- 			</script> -->
<%-- 		</sec:authorize> --%>
		<sec:authorize ifAnyGranted="ROLE_ADMIN">
			<script type="text/javascript">
				admin = true;
			</script>
		</sec:authorize>
	</c:if>
	
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
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>		
	
	<script type="text/javascript">

	
	$(function () {	

		//user deptNo에 따른 수계 고정
		set_User_deptNo(user_dept_no, "sugye");

		
		var regok = '${param.airmntreg}';

		if(regok != null)
		{
			if(regok == 'true')
			{
				if(confirm("항공감시 정보 등록에 성공했습니다. 항공감시 목록으로 이동하시겠습니까?"))
				{
					window.location = "<c:url value='/waterpolmnt/waterinfo/goAirMnt.do'/>";
				}
			}
			else if(regok == 'false')
			{
				alert("항공감시 등록 실패!");
			}
		}

		$.datepicker.setDefaults({
		    monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		    showMonthAfterYear:true,
		    dateFormat: 'yy/mm/dd',
		    showOn: 'both',
		    buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
		    buttonImageOnly: true
		});

		$("#flight_date").datepicker({
		    buttonText: '운항일자'
		});
		var today = new Date(); 
		
		today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}
		
		$("#flight_date").val(today);
	});
	
	function validation()
	{
		for(var idx = 1 ; idx <= 30; idx++)
		{
			var value = $("#param" + idx).val();
			
			if(value == "")
			{
				alert("데이터를 입력해 주세요");
				$("#param" + idx).focus();
				
				return false;
			}
		}
		
		return true;
	}
	
	function insert() {
	
		if(validation())
		{	
			if(confirm("항공감시정보를 등록하시겠습니까?"))
			{
				document.airmnt.action = "<c:url value='/waterpolmnt/airmntmng/insertAirMnt.do'/>";
				$("#flight_date").val($("#flight_date").val2());
				document.airmnt.submit();
			}
		}
	}

	//지점 목록 가져오기
	function fill_point_selectBox()
	{	
		
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
		
		<form name="airmnt" method="post" enctype="multipart/form-data" >
		<!-- content -->
		<div id="content" class="sub_waterpolmnt">
			<div class="content_wrap page_waterinfo">
				<div class="inner_airmnt">
					<div class="airmnt_inner">
						<h4 class="buSqu_tit">운항 및 감시 일지</h4>
							<br/><br/>
							<table class="dataTable" style="width:254px">
								<tr>
									<th>지대</th>
									<td>
										<select id="sugye" name="sugye" style="width:98px">
												<option value="R01">한강</option>
												<option value="R02">낙동강</option>
												<option value="R03">금강</option>
												<option value="R04">영산강</option>
										</select>
									</td>
								</tr>
							</table>
							<br/><br/>
							<table class="dataTable">
								<colgroup>
									<col width="" />
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
										<th scope="col">호기</th>
										<th scope="col">비행구간</th>
										<th scope="col">착륙횟수</th>
										<th scope="col">출발시간</th>
										<th scope="col">도착시간</th>
										<th scope="col">비행시간</th>
										<th scope="col">기장</th>
										<th scope="col">동승자</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<input type="text" id="param1" name="plane" size="10" maxlength="20"/>
										</td>
										<td>
											<input type="text" id="param2" name="fly_section" size="10" maxlength="5"/>
										</td>
										<td>
											<input type="text" id="param3" name="land_cnt"  size="10" maxlength="20"/>
										</td>
										<td>
											<input type="text" id="param4" id="start_time" name="start_time"  size="10" maxlength="20"/>
										</td>
										<td>
											<input type="text" id="param5" id="reach_time" name="reach_time"  size="10" maxlength="20" />
										</td>
										<td>
											<input type="text" id="param6" name="flight_time"  size="10" maxlength="20"/>
										</td>
										<td>
											<input type="text" id="param7" name="pilot"  size="10" maxlength="20"/>
										</td>
										<td>
											<input type="text" id="param8" name="rider"  size="10" maxlength="20"/>
										</td>
									</tr>
									<tr>
										<th scope="row">운항일자</th>
										<td>
											<input type="text" id="param9" name="flight_date" maxlength="20" size="10"  id="flight_date"/>
										</td>
										<th scope="row">특이사항</th>
										<td colspan="5">
											<input type="text"  id="param10" name="note" maxlength="50" size="95"/>
										</td>
									</tr>
									<tr>
										<th scope="row">기상</th>
											<td>
												<select name="weather"  id="param11" style="width:98px">
													<option>맑음</option>
													<option>구름조금</option>
													<option>구름많음</option>
													<option>흐림</option>
													<option>비</option>
													<option>눈</option>
													<option>안개</option>
													<option>황사</option>
												</select>
											</td>
										<th scope="row">일출</th>
										<td>
											<input type="text"  id="param12" name="sunrise" maxlength="20" size="10" />
										</td>
										<th scope="row">일몰</th>
										<td>
											<input type="text"  id="param13" name="sunset" maxlength="20" size="10" />
										</td>
										<th scope="row">예보</th>
										<td>
											<select name="forecast"  id="param14" style="width:98px">
													<option>맑음</option>
													<option>구름조금</option>
													<option>구름많음</option>
													<option>흐림</option>
													<option>비</option>
													<option>눈</option>
													<option>안개</option>
													<option>황사</option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
							<table class="dataTable spacing1">
								<colgroup>
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="3px" />
									<col width="" />
									<col width="" />
									<col width="" />
									<col width="" />
								</colgroup>
								<tr>
									<th scope="col" colspan="9" class="bgStyle">시간대별 기상상태</th>
								</tr>
								<tr>
									<th scope="col">시간</th>
									<th scope="col">풍향/풍속</th>
									<th scope="col">시정</th>
									<th scope="col">운량/운고</th>
									<th scope="col" rowspan="3" class="bgStyle"></th>
									<th scope="col">시간</th>
									<th scope="col">풍향/풍속</th>
									<th scope="col">시정</th>
									<th scope="col">운량/운고</th>
								</tr>
								<tr>
									<td>
										<input type="text"  id="param15" name="weather_time1" maxlength="20" size="10" />
									</td>
									<td>
										<input type="text"  id="param16" name="wind1" maxlength="20" size="9" />
									</td>
									<td>
										<input type="text"  id="param17" name="sight1" maxlength="20" size="9" />
									</td>
									<td>
										<input type="text"  id="param18" name="cloud1" maxlength="20" size="9" />
									</td>
									<td>
										<input type="text"  id="param19" name="weather_time2" maxlength="20" size="9" />
									</td>
									<td>
										<input type="text"  id="param20" name="wind2" maxlength="20" size="9" />
									</td>
									<td>
										<input type="text"  id="param21" name="sight2" maxlength="20" size="9" />
									</td>
									<td>
										<input type="text"  id="param22" name="cloud2" maxlength="20" size="9" />
									</td>
								</tr>
								<tr>
									<td>
										<input type="text"  id="param23" name="weather_time3" maxlength="20" size="10" />
									</td>
									<td>
										<input type="text"  id="param24" name="wind3" maxlength="20" size="9" />
									</td>
									<td>
										<input type="text"  id="param25" name="sight3" maxlength="20" size="9" />
									</td>
									<td>
										<input type="text"  id="param26" name="cloud3" maxlength="20" size="9" />
									</td>
									<td>
										<input type="text"  id="param27" name="weather_time4" maxlength="20" size="9" />
									</td>
									<td>
										<input type="text"  id="param28" name="wind4" maxlength="20" size="9" />
									</td>
									<td>
										<input type="text"  id="param29" name="sight4" maxlength="20" size="9" />
									</td>
									<td>
										<input type="text"  id="param30" name="cloud4" maxlength="20" size="9" />
									</td>
								</tr>
							</table>
							<table class="dataTable spacing2">
								<colgroup>
									<col width="140px"/>
									<col />
									<col width="90px" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col" colspan="3" class="bgStyle">환경 항공 감시 결과</th>
									</tr>
									<tr>
										<th scope="col">구   분</th>
										<th scope="col">확인사항</th>
										<th scope="col">이상유무</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td rowspan="4">하천수질<br/>오    염</td>
										<td class='txtP'><span>○ 유류(기름띠) 및 공장 축산폐수 무단방류행위</span></td>
										<td><input type="checkbox" class="inputCheck" name="result1" value="Y"/></td>
									</tr>
									<tr>
										<td class='txtP'><span>○ 물고기폐사, 물색깔 변화(녹조 또는 부영양화현상 등)</span></td>
										<td><input type="checkbox" class="inputCheck" name="result2" value="Y"/></td>
									</tr>
									<tr>
										<td class='txtP'><span>○ 하천에서의 세차, 골재채취, 공사등으로 인한 부유물질 확산여부</span></td>
										<td><input type="checkbox" class="inputCheck" name="result3" value="Y"/></td>
									</tr>
									<tr>
										<td class='txtP'><span>○ 육상의 쓰레기 하천유입, 행락지 낙시터 등 쓰레기투기 여부</span></td>
										<td><input type="checkbox" class="inputCheck" name="result4" value="Y"/></td>
									</tr>
									<tr>
										<td rowspan="6">하천주변<br/>환    경</td>
										<td class='txtP'><span>○ 하천변 임야에서 건설폐기물, 산업폐기물 등 투기행위</span></td>
										<td><input type="checkbox" class="inputCheck" name="result5" value="Y"/></td>
									</tr>
									<tr>
										<td class='txtP'><span>○ 골프장, 채석장 등에서의 토사유출</span></td>
										<td><input type="checkbox" class="inputCheck" name="result6" value="Y"/></td>
									</tr>
									<tr>
										<td class='txtP'><span>○ 하천변에서의 폐선박, 폐차 등 방치행위</span></td>
										<td><input type="checkbox" class="inputCheck" name="result7" value="Y"/></td>
									</tr>
									<tr>
										<td class='txtP'><span>○ 타이어, 폐비닐 등 불법소각행위</span></td>
										<td><input type="checkbox" class="inputCheck" name="result8" value="Y"/></td>
									</tr>
									<tr>
										<td class='txtP'><span>○ 산불발생, 산림훼손 등 자연환경 훼손 행위</span></td>
										<td><input type="checkbox" class="inputCheck" name="result9" value="Y"/></td>
									</tr>
									<tr>
										<td class='txtP'><span>○ 어류불법포획 등 하천생태계 파괴행위 </span></td>
										<td><input type="checkbox" class="inputCheck" name="result10" value="Y"/></td>
									</tr>
									<tr>
										<td>기    타</td>
										<td class='txtP'><span>○ 하천관리실태 및 철새도래 관찰 등</span></td>
										<td><input type="checkbox" class="inputCheck" name="result11" value="Y"/></td>
									</tr>
								</tbody>
							</table>
							<!-- 
							<table class="dataTable">
								<colgroup>
									<col width="220px" />
									<col />
								</colgroup>
								<tr>
									<th scope="row">첨부자료</th>
									<td>
										<ul>
											<li><a href="#">오염상태.jpg</a></li>
										</ul>
									</td>
								</tr>
							</table>
							 -->
							<ul class="btnMenu" style="float:right">
								<li><a href="javascript:insert()"><img src="<c:url value='/images/common/btn_regist.gif'/>" alt="등록" /></a></li>
								<!-- <li><input type="image" src="<c:url value='/images/common/btn_del.gif'/>" alt="삭제" /></li>
								<li><a href="#"><img src="<c:url value='/images/common/btn_list2.gif'/>" alt="목록" /></a></li> -->
							</ul>
					</div>
				</div>
			</div>
		</div><!-- //content -->
</form>
	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>
