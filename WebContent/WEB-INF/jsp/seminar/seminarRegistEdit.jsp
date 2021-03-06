<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : seminarRegistEdit.jsp
	 * Description : 교육등록 수정 화면
	 * Modification Information
	 * 
	 * 수정일         		수정자                   수정내용
	 * -------    			--------    ---------------------------
	 * 2014.10.10		mypark		최초생성
	 *
	 * author mypark
	 * since 2014.09.18
	 *  
	 * Copyright (C) 2014 by 이용 All right reserved.
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
<script type="text/javascript" src="<c:url value='/html/util/htmlarea3.0/htmlarea.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/seminar.js'/>" ></script>
<script type="text/javascript">
	_editor_area = "seminarBody";
</script>
<script type="text/javascript">
(function($) {
	//담당자 선택 SELECT OPTION 설정
	$.fn.loadSelectDeptMemList = function(optionsDataArray) {
		return this.emptySelect().each(function(){
			if (this.tagName=='SELECT') {
				var selectElement = this;
				$.each(optionsDataArray,function(idx, optionData){					
					var option;					
					if(optionData.CAPTION != undefined) {
						var strVal = optionData.CAPTION + "//" + optionData.VALUE + "//" + optionData.MOBILE_NO;
						option= new Option(optionData.CAPTION, strVal);
					} else {
						var strVal = optionData.caption + "//" + optionData.value + "//" + optionData.mobile_no;
						option = new Option(optionData.caption, strVal);
					}
					if ($.browser.msie) {
						selectElement.add(option);
					}
					else {
						selectElement.add(option,null);
					}
				});
			}
		});
	};
})(jQuery);

//<![CDATA[
    $(document).ready(function() {
    	setTime(); //시간 세팅
    	$("#dept").change(function(){
			setPerson(); //담당 소속 직원셋팅
		});
    	//부서셋팅
    	setDept();
    	//담당자 선택시
    	$("#person").change(function(){
    		selDeptMem($(this).val()[0]);
			layerPopCloseAll()
		});
	});        	
	//]]>
</script>
<script type="text/javascript">
	function fn_regist() {
		document.seminarInput.onsubmit();
		//입력값 체크
		if(fnInputCheck()) {
			if (confirm('<spring:message code="common.update.msg" />')) {
				document.seminarInput.action = "<c:url value='/seminar/UpdateSeminarInfo.do'/>";
				document.seminarInput.submit();					
			}
		}
	}
	
	function fn_List() {
		document.board.action = "<c:url value='/seminar/SeminarRegistList.do'/>";
		document.seminarInput.submit();	
	}	
	
	function selDeptMem(str) {
 		var memInfo = str;
		if(memInfo.split("//").length > 1) {
 			$("#seminarLectName").val(memInfo.split("//")[0]);
 			$("#seminarLectId").val(memInfo.split("//")[1]);
 		    $("#seminarLectTel").val(memInfo.split("//")[2]);
 		    $("#sLectTel").val(memInfo.split("//")[2]);
 		}
	}
	
	function setTime() {
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		$("#seminarDateFrom").datepicker({
			buttonText: '교육시작'
		});
		$("#seminarDateTo").datepicker({
			buttonText: '교육종료'
		});
		
		$("#seminarEntryDateFrom").datepicker({
			buttonText: '신청기간시작'
		});
		$("#seminarEntryDateTo").datepicker({
			buttonText: '신청기간종료'
		});
	}
	
	//부서별 직원생성
	function setPerson(){
		var value = $("#dept > option:selected").val();
		var dropDownSet = $("#person");
		
		if(value == undefined)
		return;
		
		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",{
			orderType:"2",
			value:value
		},
		//, system:sys_kind},
		function (data, status){
			if(status == 'success'){
				dropDownSet.loadSelectDeptMemList(data.groupList);
			} else {
				return;
			}
		});
	}
	
	//부서생성
	function setDept(){
		var dropDownSet = $("#dept");
		$("#person").emptySelect();
		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
		{
			orderType:"1"
		},
		//, system:sys_kind},
		function (data, status){
			if(status == 'success'){
				//locId 객체에 SELECT 옵션내용 추가.
				dropDownSet.loadSelect(data.groupList);
				setPerson();
			} else {
				return;
			}
		});
	}

	/*담당자 선택 레이어 닫기*/
	function layerPopCloseAll() {
		$("#person").emptySelect();
		layerPopClose("layerDeptMemList");
	}
	
	function commonWork1() {
		var stdt = document.getElementById("seminarDateFrom");
		var endt = document.getElementById("seminarDateTo");
		var seminarId = document.getElementById("seminarId");
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("교육신청 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
		
		if(stdt.value != '' && endt.value != '') {
			$.ajax({
				type: "POST",
				url: "<c:url value='/seminar/selectCheckSeminarDate.do'/>",
				data: {startDt:stdt.value, endDt:endt.value, seminarId:seminarId.value},
				dataType:"json",
				success : function(result){
					if(result['msg'] == "duplication") {
						alert("교육 일정이 중복되었습니다. \n\n다시 확인 하시기 바랍니다.");
						/* stdt.value = "";
						endt.value = ""; */
						stdt.focus();
					}
				}
			});
		}
	}
	
	function commonWork2() {
		var stdt = document.getElementById("seminarEntryDateFrom");
		var endt = document.getElementById("seminarEntryDateTo");

		if(endt.value != '' && stdt.value > endt.value) {
			alert("신청기간 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
	}
	
	//일정보기
	function fn_open_cal() {
		window.open("<c:url value='/seminar/SeminarSchedule.do?urlStr=popupCal'/>",'popupCal','resizable=no,scrollbars=no,width=960,height=750');
	}
	
	function fn_egov_list(){
		location.href = "/seminar/SeminarRegistList.do";
	}
	
</script>
<style type="text/css">
	.noStyle {background:ButtonFace !important; BORDER-TOP:0px !important; BORDER-bottom:0px !important; BORDER-left:0px !important; BORDER-right:0px !important;}
  	.noStyle th{background:ButtonFace !important; padding-left:0px !important;padding-right:0px !important;}
  	.noStyle td{background:ButtonFace !important; padding-left:0px !important;padding-right:0px !important;}
</style>
</head>
<body onLoad="HTMLArea.init(); HTMLArea.onload = initEditor; document.seminarInput.seminarTitle.focus();">
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

						<form:form commandName="seminarInput" name="seminarInput" method="post" enctype="multipart/form-data" >
							<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
							<input type="hidden" name="seminarId" id="seminarId" value="<c:out value='${result.seminarId}'/>" />
							<input type="hidden" name="returnUrl" value="<c:url value='/seminar/SeminarView.do'/>"/>
							<input type="hidden" name="urlStr" value="<c:out value='${searchVO.urlStr}'/>" />
							<!-- 글등록 폼 -->
							<form action="">
								<div class="table_wrapper">
									<!-- 글작성 내용 -->
									<table summary="교육 등록 폼. 제목, 작성자, 참여자, 이메일, 교육기간, 교육시간, 신청기간, 주최, 담당자연락처, 내용, 파일을 입력">
										<colgroup>
										<col width="120px" />
										<col width="160px" />
										<col width="120px" />
										<col width="100px" />
										<col width="120px" />
										<col width="120px" />
										<col width="100px" />
										<col width="100px" />
										<col width="60px" />
										</colgroup>
										<tr>
											<th><label for="">제목</label></th>
											<td colspan="4" class="txtL">
												<c:if test="${deptFlas == 'Y'}">
													<select name="seminarGubun" id="seminarGubun" class="select">
													<option value="L" <c:if test="${result.seminarGubun == 'L'}">selected="selected"</c:if>>강사신청</option>
													</select>
												</c:if>
												<c:if test="${deptFlas == 'N'}">
													<select name="seminarGubun" id="seminarGubun" class="select">
													<option value="L" <c:if test="${result.seminarGubun == 'L'}">selected="selected"</c:if>>강사신청</option>
													<option value="S" <c:if test="${result.seminarGubun == 'S'}">selected="selected"</c:if>>교육신청</option>
													</select>
												</c:if>
												&nbsp;&nbsp;<input type="text" name="seminarTitle" id="seminarTitle" size="50" title="제목 입력"  value="<c:out value='${result.seminarTitle}'/>"/>
											</td>
											<th><label for="">참여자수</label></th>
											<td class="txtL" ><input name="seminarCount" type="text" id="seminarCount"  size="3" maxlength="3" value="<c:out value='${result.seminarCount}'/>" /> 명</td>
											<th><label for="">조회수</label></th>
											<td class="txtL" ><label for=""><c:out value='${result.readCnt}'/></label></td>
										</tr>
										<tr>
											<th><label for="">작성자</label></th>
											<td class="txtL">
												<c:out value='${result.writerName}'/>
												<input type="hidden" name="writerId" id="writerId" value="<c:out value='${result.writerId}'/>" title="작성자 아이디" />
											</td>
											<th><label for="">E.mail</label></th>
											<td class="txtL" colspan="2">
												<input name="seminarLectEmail" type="text" id="seminarLectEmail" size="30" value="<c:out value='${result.seminarLectEmail}'/>"/>
											</td>
											<th><label for="">등록일</label></th>
											<td class="txtL" colspan="3"><label for=""><c:out value='${result.regDate}'/></label></td>
										</tr>
										<tr>
											<th><label for="">교육기간</label></th>
											<td class="txtL" colspan="4">
												<input type="text" id="seminarDateFrom" name="seminarDateFrom" size="13" value="<c:out value='${result.seminarDateFrom}'/>" onchange="commonWork1()" alt="교육기간From"/>
												<span>~</span>
												<input type="text" id="seminarDateTo" name="seminarDateTo" size="13" value="<c:out value='${result.seminarDateTo}'/>" onchange="commonWork1()" alt="교육기간To"/>
												<input type="button" id="btnSearch" name="btnSearch" value="일정보기" class="btn btn_search" onclick="javascript:fn_open_cal();" alt="일정보기" />
											</td>
											<th><label for="">교육시간</label></th>
											<td class="txtL" colspan="3">
												<select id="seminarTimeFrom" name="seminarTimeFrom" >
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
												</select>
												<span>~</span>
												<select id="seminarTimeTo" name="seminarTimeTo" >
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
													<option value="23" selected="selected">23</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><label for="">신청기간</label></th>
											<td class="txtL" colspan="4">
												<input type="text" id="seminarEntryDateFrom" name="seminarEntryDateFrom" size="13" value="<c:out value='${result.seminarEntryDateFrom}'/>" onchange="commonWork2()" alt="신청기간From"/>
												<span>~</span>
												<input type="text" id="seminarEntryDateTo" name="seminarEntryDateTo" size="13" value="<c:out value='${result.seminarEntryDateTo}'/>" onchange="commonWork2()" alt="신청기간To"/>
											</td>
											<th><label for="">교육장소</label></th>
											<td class="txtL" colspan="3"><input type="text" id="seminarPlace" name="seminarPlace"  value="<c:out value='${result.seminarPlace}'/>"  alt="교육장소"/></td>
										</tr>
										<tr>
											<th><label for="">담당자</label></th>
											<td class="txtL" colspan="2">
												<input type="text" id="seminarLectName" name="seminarLectName" size="20" value="<c:out value='${result.seminarLectName}'/>" alt="담당자명"  disabled="true" readonly="true" />
												<input type="hidden" id="seminarLectId" name="seminarLectId" value="<c:out value='${result.seminarLectId}'/>"  alt="담당자 ID"/>
												&nbsp;&nbsp;&nbsp;
												<input type="button" id="btnSearch" name="btnSearch" value="선택" class="btn btn_search" onclick="javascript:layerPopOpen('layerDeptMemList');" />
											</td>
											<th><label for="">주최</label></th>
											<td class="txtL" >
												<input type="text" id="seminarHost" name="seminarHost"  value="<c:out value='${result.seminarHost}'/>" alt="주최"/>
											</td>
											<th><label for="">담당자연락처</label></th>
											<td class="txtL" colspan="3">
												<input type="text" id="sLectTel" name="sLectTel" size="20" value="<c:out value='${result.seminarLectTel}'/>" alt="연락처"  disabled="true" readonly="true" />
												<input type="hidden" id="seminarLectTel" name="seminarLectTel"  value="<c:out value='${result.seminarLectTel}'/>" alt="담당자 연락처"    />
											</td>
										</tr>
										<tr>
											<th><label for="">내용</label></th>
											<td colspan="8">
												<table width="100%" border="0" cellpadding="0" cellspacing="0" class="noStyle">
											    	<tr>
											    		<td class="txtL">
											      			<textarea id="seminarBody" name="seminarBody" style="width:863px;height:300px;"><c:out value="${result.seminarBody}" escapeXml="false" /></textarea>
											      			<form:errors path="seminarBody" />
											      		</td>
											      	</tr>
											    </table>
											</td>
										</tr>
										<tr class="borderNone">
											<th >파일</th>
											<td colspan="8"  class="txtL" >
									<!-- 기존 첨부파일 -->
									<c:if test="${not empty result.atchFileId}">
										<c:import url="/cmmn/selectFileInfsForUpdate.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${result.atchFileId}" />
										</c:import>
										<c:if test="${empty result.atchFileId}">
												<input type="hidden" name="fileListCnt" value="0" />
										</c:if> 
											<input name="file_1" id="egovComFileUploader" type="file"  style="width:500px;"/>&nbsp;&nbsp;
											<div id="egovComFileList"></div>
									</c:if>
									<c:if test="${empty result.atchFileId}">
											<input name="file_1" id="egovComFileUploader" type="file"  style="width:500px;"/>&nbsp;&nbsp;
											<div id="egovComFileList"></div>
									</c:if>
											</td>
										</tr>
									</table>
									<!-- //글수정 내용 -->
									<!-- 버튼 메뉴 -->
									<div id="btArea" style="margin-top:10px">
										<input type="button" id="btnRegist" name="btnRegist" value="수정" class="btn btn_basic" onclick="javascript:fn_regist();return false;" alt="수정"/>
										<input type="button" id="btnList" name="btnList" value="목록" class="btn btn_basic" onclick="javascript:fn_egov_list();" alt="목록"/>
									</div>      	
									<!-- //버튼 메뉴 -->
								</div>
							
							</form>
							<!-- //글쓰기 폼 -->
						</form:form>

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
	<!-- 담당자 선택 레이어 -->
	<div id="layerDeptMemList" class="divPopup" style="background-color:#FFFFFF;">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnFacSizeModXbox" name="btnFacSizeModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopCloseAll('layerDeptMemList');" alt="닫기" />
		</div>
		<form id="modifySizeForm" name="modifySizeForm" method="post">
			<div id="deptList" style="background-color:#FFFFFF;">
				<div class="gBox" style="width:220px">
					<span class="ptit" >
						대상기관
					</span>
					<select multiple="multiple" id="dept" style="padding:7px;width:220px;height:190px"></select>
				</div>
				<div style="padding-top:25px;float:left"><img src="/images/renewal/parrow.gif" alt="다음단계"/></div>
				<div class="gBox">
					<span class="ptit">
						담당자
					</span>
					<select multiple="multiple" id="person" style="padding:7px;width:180px;height:190px"></select>
				</div>
			</div>
		</form>
	</div>
</body>
</html>