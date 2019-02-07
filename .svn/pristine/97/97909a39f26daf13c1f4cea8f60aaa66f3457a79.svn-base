<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : waterPollutionReportList.jsp
	 * Description : 수질오염리포트 관리 화면
	 * Modification Information
	 * 
	 * 수정일				 수정자		 수정내용
	 * ----------		--------	---------------------------
	 * 2014.02.10		lkh			모바일용을 마이그레이션
	 *
	 * author lkh
	 * since 2014.0210
	 *
	 * Copyright (C) 2014 by lkh All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript">
//<![CDATA[
		
	$(function () {
		
		
// 		$("#toTime option[value="+time+"]").attr("selected", "true");
// 		$("#frTime option[value="+fritime+"]").attr("selected", "true");
		
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy-mm-dd',
			showOn: 'both',
			//buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			//buttonImageOnly: true
		});
		$("#rept_date").datepicker({
			//buttonText: '시작일'
		});
		$("#rept_date2").datepicker({
			//buttonText: '종료일'
		});
		$("#rept_date3").datepicker({
			//buttonText: '종료일'
		});
		
// 		var today = new Date(); 
// 		var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 12);
		
		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
	
// 		$("#startDate").val(yday);
// 		$("#endDate").val(today);

	});
	
	//페이지 번호 클릭	
	function linkPage(pageNo){
		reloadData(pageNo);
	}
//]]>
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="wrap">
	
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
			
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->

				<!-- Content Start-->
				<div id="content">
				
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
						
					<!--tab Contnet Start-->
					<div class="tab_container">
						
						<div class="topBx">
							<input type="button" id="btnList" name="btnList" value="목록" class="btn btn_basic" onclick="javascript:fnGoListPage();" alt="목록" />						<!-- IF START 'owner' -->
							<input type="button" id="btnInsert" name="btnInsert" value="저장" class="btn btn_basic" onclick="javascript:fnGoListInsert();" alt="저장" />
							<!-- IF START 'id' -->
							<input type="button" id="btnDelete" name="btnDelete" value="삭제" class="btn btn_basic" onclick="javascript:fnGoListDelete();" alt="삭제" />
							<!-- IF END 'id' -->
						<!-- IF END 'owner' -->
						</div>
					
						<div class="table_wrapper">
							
							<form name="deleteForm" method="post">
								 <input type="hidden" name="mode" value="delete"/>
								 <input type="hidden" name="deleteWhCode" id="deleteWhCode"/>
							</form>
							<form name="modifyForm" method="post" >
								<input type="hidden" name="mode" value="modify"/>
								
								<table summary="수질오염보고서 정보" style="text-align:left;">
									<colgroup>
										<col width="150px"/>
										<col/>
									</colgroup>
									<tr>
										<th>보고자 기관명<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											<input type="text" name="rept_org" size="25" />
										</td>
									</tr>
									<tr>
										<th>보고자 소속<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											<input type="text" name="rept_dept" size="20"/>
										</td>
									</tr>
									<tr>
										<th>보고자 직급<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											<input type="text" name="rept_grade" size="20" />
										</td>
									</tr>
									<tr>
										<th>보고자 성명<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											<input type="text" name="rept_name" size="20" />
										</td>
									</tr>
									<tr>
										<th>보고일시<span class="red">*</span></th>
										<td>
											<p>
<!-- 											<input type="text" name="rept_date" size="10" onfocus="new CalendarFrame.Calendar(this)" readonly="readonly" /> -->
												<input type="text" id="rept_date" name="rept_date" size="11" onchange="commonWork()" alt="최초보고일"/>
												&nbsp;
												<select name="rept_hh">
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
												&nbsp;
												<select name="rept_mm">
													<option value="00">00</option>
													<option value="05">05</option>
													<option value="10">10</option>
													<option value="15">15</option>
													<option value="20">20</option>
													<option value="25">25</option>
													<option value="30">30</option>
													<option value="35">35</option>
													<option value="40">40</option>
													<option value="45">45</option>
													<option value="50">50</option>
													<option value="55">55</option>
												</select> 분 (최초)
											</p>
											<!-- IF START 'step2' -->
											<p style="margin-top:5px">
											<input type="text" id="rept_date2" name="rept_date" size="10" onchange="commonWork()" alt="2차보고일"/>
												&nbsp;
												<select name="rept_hh2">
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
												&nbsp;
												<select name="rept_mm2">
													<option value="00">00</option>
													<option value="05">05</option>
													<option value="10">10</option>
													<option value="15">15</option>
													<option value="20">20</option>
													<option value="25">25</option>
													<option value="30">30</option>
													<option value="35">35</option>
													<option value="40">40</option>
													<option value="45">45</option>
													<option value="50">50</option>
													<option value="55">55</option>
												</select> 분 (2차)
											</p>
											<!-- IF END 'step2' -->
											<!-- IF START 'step3' -->
											<p style="margin-top:5px">
											<input type="text" id="rept_date3" name="rept_date" size="10" onchange="commonWork()" alt="최종보고일"/>
												&nbsp;
												<select name="rept_hh3">
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
												&nbsp;
												<select name="rept_mm3">
													<option value="00">00</option>
													<option value="05">05</option>
													<option value="10">10</option>
													<option value="15">15</option>
													<option value="20">20</option>
													<option value="25">25</option>
													<option value="30">30</option>
													<option value="35">35</option>
													<option value="40">40</option>
													<option value="45">45</option>
													<option value="50">50</option>
													<option value="55">55</option>
												</select> 분 (최종)
											</p>
											<!-- IF END 'step3' -->
										</td>
									</tr>
									<tr>
										<th>신고자 성명<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											<input type="text" name="alert_name" size="20" />
										</td>
									</tr>
									<tr>
										<th>신고자 전화번호<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											<input type="text" name="alert_phone" size="20" /> ('-'포함입력)
										</td>
									</tr>
									<tr>
										<th>신고 사실여부<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											<input type="text" name="alert_yn" size="20" />
										</td>
									</tr>
									<tr>
										<th>사고일시<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											
											<input type="text" name="case_date" size="10" onfocus="new CalendarFrame.Calendar(this)" readonly="readonly" />
		&nbsp;
		<select name="case_hh">
			<!-- LOOP START 'hours' -->
			<option value="<!-- {{hours.value}} -->"><!-- {{hours.value}} --></option>
			<!-- LOOP END 'hours' -->
		</select> 시
		&nbsp;
		<select name="case_mm">
			<!-- LOOP START 'minutes' -->
			<option value="<!-- {{minutes.value}} -->"><!-- {{minutes.value}} --></option>
			<!-- LOOP END 'minutes' -->
		</select> 분
		
										</td>
									</tr>
									<tr>
										<th>사고장소<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											<input type="text" name="case_area" size="45" /> (소재지, 도로 또는 하천명 등(상세히))
										</td>
									</tr>
									<tr>
										<th>사고내용<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											<p style="margin-bottom:5px">※ 육하원칙에 따라 가능한 상세히 작성.</p>
		<textarea name="case_content" style="width:500px;height:150px"></textarea>
										</td>
									</tr>
									<tr>
										<th>오염물질 유입 수계현황<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											<p style="margin-bottom:5px">예) 사고지점 -> OO천(00km) -> OO강 합류지점(00km) -> OO취수장(00km) -> O해(00km)</p>
		<textarea name="case_stat" style="width:500px;height:70px"></textarea>
										</td>
									</tr>
									<tr>
										<th>취/정수장 영향<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											<p style="margin-bottom:5px">취수량, 정수량, 급수지역, 급수인구</p>
		<p style="margin-bottom:5px">`식용수 실무매뉴얼`에 의한 조치사항 등.</p>
		<textarea name="case_eff" style="width:500px;height:70px"></textarea>
										</td>
									</tr>
									<tr>
										<th>조치사항<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											<p style="margin-bottom:5px">현장 도착 후 조치사항 및 필요사항을 기재. (교통사항 : 기타 사고관련 정보 등 포함)</p>
		<textarea name="case_action" style="width:500px;height:70px"></textarea>
										</td>
									</tr>
									<!-- IF START 'step2' -->
									<tr>
										<th>수습(조치)현황<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											
											<script language="javascript" src="/js/grid.prototype.js"></script>



		<p style="margin:5px 0 5px 0">시간대별 수습(조치)사항</p>

		<table id="grid" class="i_tb01" width="504" cellpadding="0" cellspacing="0">
		<col width="50" />
		<col width="50" />
		<col />
		<col width="40" />
		<thead>
		<tr align="center">
			<td>일 자</td>
			<td>시 간</td>
			<td>주 요 조 치 내 용</td>
			<td><font class="fb01" style="background:silver" onclick="MG.addRow();">추가</font></td>
		</tr>
		</thead>
		<tbody align="center">
		</tbody>
		</table>

		<div style="margin-top:5px">(비어있는 값이 존재하는 줄의 내용은 저장되지 않습니다.)</div>

		<script>
		var MG = new MGRID("grid");
		MG.cells = new Array(
			'<input type="text" name="action_date" size="4" maxlength="5">'
			, '<input type="text" name="action_time" size="4" maxlength="5">'
			, '<input type="text" name="action_content" size="56">'
			, '<font class="fb01" style="background:silver" onclick="MG.del(this);">삭제</font>'
		);
		MG.cellClassName = "i_td01";
		MG.callbackInsert = MG.callbackDelete = "SysCrossResize";

		<!-- IF START 'actions' -->
		<!-- LOOP START 'actions' -->
			MG.addRow();
			SetElementValue(document.getElementsByName("action_date")[/* {{actions.idx}} */], "/* {{actions.action_date}} */");
			SetElementValue(document.getElementsByName("action_time")[/* {{actions.idx}} */], "/* {{actions.action_time}} */");
			SetElementValue(document.getElementsByName("action_content")[/* {{actions.idx}} */], "/* {{actions.action_content}} */");
		<!-- LOOP END 'actions' -->
		MG.setActiveColor(-1);
		<!-- IF END 'actions' -->
		<!-- IFNOT START 'actions' -->
		for(var i=0; i<5; i++) {
			MG.addRow();
			if(i == 0) {
				SetElementValue(document.getElementsByName("action_date")[i], "/* {{md}} */");
				SetElementValue(document.getElementsByName("action_time")[i], "00:00");
			}
		}
		MG.setActiveColor(-1);
		<!-- IFNOT END 'actions' -->
		</script>

		<p style="margin:15px 0 5px 0">인력 및 장비 동원 현황(당일/보고시점 누계)</p>

		<table width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td><textarea name="case_action3" style="width:500px;height:70px"></textarea></td>
		</tr>
		</table>
		
		
		
										</td>
									</tr>
									<tr>
										<th>사고 유발자<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											
											인적사항 : <input type="text" name="case_cause1" size="35" />

		<br/>
		<p style="margin:5px 0 5px 0">조치현황</p>

		<table id="grid2" class="i_tb01" width="504" cellpadding="0" cellspacing="0">
		<col width="50" />
		<col width="50" />
		<col />
		<col width="100" />
		<col width="40" />
		<thead>
		<tr align="center">
			<td>일 자</td>
			<td>시 간</td>
			<td>조 치 내 용</td>
			<td>조 치 기 관</td>
			<td><font class="fb01" style="background:silver" onclick="MG2.addRow();">추가</font></td>
		</tr>
		</thead>
		<tbody align="center">
		</tbody>
		</table>

		<div style="margin-top:5px">(비어있는 값이 존재하는 줄의 내용은 저장되지 않습니다.)</div>

		<script>
		var MG2 = new MGRID("grid2");
		MG2.cells = new Array(
			'<input type="text" name="cause_date" size="4" maxlength="5">'
			, '<input type="text" name="cause_time" size="4" maxlength="5">'
			, '<input type="text" name="cause_content" size="39">'
			, '<input type="text" name="cause_org" size="12">'
			, '<font class="fb01" style="background:silver" onclick="MG2.del(this);">삭제</font>'
		);
		MG2.cellClassName = "i_td01";
		MG2.callbackInsert = MG2.callbackDelete = "SysCrossResize";

		<!-- IF START 'causes' -->
		<!-- LOOP START 'causes' -->
			MG2.addRow();
			SetElementValue(document.getElementsByName("cause_date")[/* /* {{causes.idx}} */ */], "/* /* {{causes.cause_date}} */ */");
			SetElementValue(document.getElementsByName("cause_time")[/* {{causes.idx}} */], "/* {{causes.cause_time}} */");
			SetElementValue(document.getElementsByName("cause_content")[/* {{causes.idx}} */], "/* {{causes.cause_content}} */");
			SetElementValue(document.getElementsByName("cause_org")[/* {{causes.idx}} */], "/* {{causes.cause_org}} */");
		<!-- LOOP END 'causes' -->
		MG2.setActiveColor(-1);
		<!-- IF END 'causes' -->
		<!-- IFNOT START 'causes' -->
		for(var i=0; i<3; i++) {
			MG2.addRow();
			if(i == 0) {
				SetElementValue(document.getElementsByName("cause_date")[i], "/* {{md}} */");
				SetElementValue(document.getElementsByName("cause_time")[i], "00:00");
			}
		}
		MG2.setActiveColor(-1);
		<!-- IFNOT END 'causes' -->
		</script>
		
		
										</td>
									</tr>
									<tr>
										<th>향후조치계획 <span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											
											<p style="margin-bottom:5px">방제작업 완료예정일, 사고원인조사 계획, 향후 조치계획 등을 기재</p>
		<textarea name="case_af_res" style="width:500px;height:70px"></textarea>
										</td>
									</tr>
									<tr>
										<th>기타<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											
											<textarea name="case_etc" style="width:500px;height:40px"></textarea>
										</td>
									</tr>
									<tr>
										<th>보고/전파 기관<span class="red">*</span></th>
										<td>
											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/>
											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"/>
											
											<table id="grid3" class="i_tb01" width="504" cellpadding="0" cellspacing="0">
		<col width="90" />
		<col width="90" />
		<col width="80" />
		<col width="80" />
		<col />
		<col width="40" />
		<thead>
		<tr align="center">
			<td>기관명</td>
			<td>부서명</td>
			<td>전화</td>
			<td>FAX</td>
			<td>받음확인<br/>(일시 및 수신자)</td>
			<td><font class="fb01" style="background:silver" onclick="MG3.addRow();">추가</font></td>
		</tr>
		</thead>
		<tbody align="center">
		</tbody>
		</table>

		<div style="margin-top:5px">(비어있는 값이 존재하는 줄의 내용은 저장되지 않습니다.)</div>

		<script>
		var MG3 = new MGRID("grid3");
		MG3.cells = new Array(
			'<input type="text" name="org_name" size="11">'
			, '<input type="text" name="org_dept" size="11">'
			, '<input type="text" name="org_tel" size="9">'
			, '<input type="text" name="org_fax" size="9">'
			, '<input type="text" name="org_conf" size="16">'
			, '<font class="fb01" style="background:silver" onclick="MG3.del(this);">삭제</font>'
		);
		MG3.cellClassName = "i_td01";
		MG3.callbackInsert = MG3.callbackDelete = "SysCrossResize";

		<!-- IF START 'orgs' -->
		<!-- LOOP START 'orgs' -->
			MG3.addRow();
			SetElementValue(document.getElementsByName("org_name")[/* /* {{orgs.idx}} */ */], "/* {{orgs.org_name}} */");
			SetElementValue(document.getElementsByName("org_dept")[/* {{orgs.idx}} */], "/* {{orgs.org_dept}} */");
			SetElementValue(document.getElementsByName("org_tel")[/* {{orgs.idx}} */], "/* {{orgs.org_tel}} */");
			SetElementValue(document.getElementsByName("org_fax")[/* {{orgs.idx}} */], "/* {{orgs.org_fax}} */");
			SetElementValue(document.getElementsByName("org_conf")[/* {{orgs.idx}} */], "/* {{orgs.org_conf}} */");
		<!-- LOOP END 'orgs' -->
		MG3.setActiveColor(-1);
		<!-- IF END 'orgs' -->
		<!-- IFNOT START 'orgs' -->
		for(var i=0; i<3; i++) {
			MG3.addRow();
		}
		MG3.setActiveColor(-1);
		<!-- IFNOT END 'orgs' -->
		</script>
		
		
										</td>
									</tr>
									<!-- IF END 'step2' -->
									<tr>
										<th>수신자 선택<span class="red">*</span></th>
										<td>
<%-- 											<input style="width:240px;" type="text" name="whName" id="whName" value="${resultDetail.whName}"/> --%>
<%-- 											<input type="hidden" id="whCode" name="whCode" value="${resultDetail.whCode}"> --%>
											
											<p>
		<select name="recv_id1">
			<option value="">- 선택 -</option>
			<!-- LOOP START 'members' -->
			<option value="<!-- {{members.member_id}} -->"><!-- {{members.addr}} / {{members.grade_name}} / {{members.member_name}} --></option>
			<!-- LOOP END 'members' -->
		</select>
		</p>
		<p style="margin-top:5px">
		<select name="recv_id2">
			<option value="">- 선택 -</option>
			<!-- LOOP START 'members' -->
			<option value="<!-- {{members.member_id}} -->"><!-- {{members.addr}} / {{members.grade_name}} / {{members.member_name}} --></option>
			<!-- LOOP END 'members' -->
		</select>
		</p>
		<p style="margin-top:5px">
		<select name="recv_id3">
			<option value="">- 선택 -</option>
			<!-- LOOP START 'members' -->
			<option value="<!-- {{members.member_id}} -->"><!-- {{members.addr}} / {{members.grade_name}} / {{members.member_name}} --></option>
			<!-- LOOP END 'members' -->
		</select>
		</p>
		<p style="margin-top:5px">
		<select name="recv_id4">
			<option value="">- 선택 -</option>
			<!-- LOOP START 'members' -->
			<option value="<!-- <!-- {{members.member_id}} --> -->"><!-- {{members.addr}} / {{members.grade_name}} / {{members.member_name}} --></option>
			<!-- LOOP END 'members' -->
		</select>
		</p>
		
		
		
											<!-- IF START 'step3' -->
										</td>
									</tr>
									<tr>
										<th>보고서 정보 <span class="red">*</span></th>
										<td>
											<input type="text" name="case_desc" size="50" /> 예) 00. 00. 00일 00기관 00부서장
										</td>
									</tr>
									<tr>
										<th>사고 개요 <span class="red">*</span></th>
										<td>
											<p style="margin-bottom:5px">00.00.00일 00소재 00사고 원인, 피해상황 등을 간략히 기재</p>
											<textarea name="case_intro" style="width:500px;height:70px"></textarea>
										</td>
									</tr>
									<tr>
										<th>추진실적 <span class="red">*</span></th>
										<td>
											<p style="margin-bottom:5px">
												1. <input type="text" name="case_res1_tit" value="" size="40" /> 예) 00년 00월 00일 현재 추진실적
											</p>
											<p style="margin-bottom:5px">
												조치(복구) 사항 등을 기재(물량환산. 00%)
												<br/>
												※ 인력 및 장비 투입 현황
												<br/>
												- 연인원 : 000명(공무원, 군인, 경찰, 소방관, 단체 및 주민)
												<br/>
												- 장 &nbsp; 비 : 중장비 00대(굴삭기 등), 오일휀스 등 방제장비
											</p>
											<textarea name="case_res1" style="width:500px;height:70px"></textarea>
										</td>
									</tr>
									<tr>
										<th>수질상태 및<br/>취/정수장 관리 상황 <span class="red">*</span></th>
										<td>
											<p style="margin-bottom:5px">
												2. <input type="text" name="case_res2_tit" value="" size="40" /> 예) 수질상태 및 취 / 정수장 관리 상황
											</p>
											<p style="margin-bottom:5px">
												수질 : 납, 비소, 시안, 페놀 등 유해물질 농도(채수지점도 첨부)
												<br/>
												취 / 정수장 관리현황 : 취수 중단여부 등
											</p>
											<textarea name="case_res2" style="width:500px;height:70px"></textarea>
										</td>
									</tr>
									<tr>
										<th>관계기관 대책회의 결과 <span class="red">*</span></th>
										<td>
											<p style="margin-bottom:5px">
												3. <input type="text" name="case_res3_tit" value="" size="40" /> 예) 관계기관 대책회의 결과
											</p>
											<p style="margin-bottom:5px">
												회의 개최시 결과보고서를 첨부
											</p>
											<textarea name="case_res3" style="width:500px;height:70px"></textarea>
										</td>
									</tr>
									<tr>
										<th>향후 계획 <span class="red">*</span></th>
										<td>
											<p style="margin-bottom:5px">
												4. <input type="text" name="case_res4_tit" value="" size="40" /> 예) 향후 계획
											</p>
											<p style="margin-bottom:5px">
												복구 완료 시 까지의 추진계획을 단기대책과 장기대책을 구분 기재
											</p>
											<textarea name="case_res4" style="width:500px;height:70px"></textarea>
										</td>
									</tr>
									<tr>
										<th>수신기관명 <span class="red">*</span></th>
										<td>
											<textarea name="case_res5" style="width:500px;height:40px"></textarea>
										</td>
									</tr>
									<!-- IF END 'step3' -->
									
								</table>
							</form>
							<div id="btArea" class="mtop10">
								<input type="button" id="goDeleteBtn" name="goDeleteBtn" value="삭제" class="btn btn_basic" onclick="javascript:fnGoDelete();" style="display:none;" />
								<input type="button" id="goModifyBtn" name="goModifyBtn" value="저장" class="btn btn_basic" onclick="javascript:fnGoModify();" style="display:none;" />
							</div>
						</div>
						
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
</body>
</html>