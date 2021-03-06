<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : riverMainModify.jsp
	 * Description : 4대강 주요 수계일지 수정화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.10.08	kyr		최초 생성
	 * 
	 * author kyr
	 * since 2014.10.10
	 * 
	 * Copyright (C) 2014 by kyr All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript" src="<c:url value='/js/dailywork.js'/>"></script>
<script type="text/javascript">
//<![CDATA[
	$(function () {
		//시간셋팅
// 		setTime();
		
		$("#dept_app").change(function(){
			setPerson('app'); //직원셋팅
		});
		$("#dept_auth").change(function(){
			setPerson('auth'); //직원셋팅
		});
		
		setDept('app');		//부서셋팅
		setDept('auth');		//부서셋팅
		
	});
	
	function setTime(){
		//============================= 달 력 Start ======================================
		/* shows the loading div every time we have an Ajax call */
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		
		$("#workDay").datepicker({
			buttonText: '일자'
		});
		
		$("#workDay").val("${param.workDay}");
		
	}
	
	//부서생성
	function setDept(gubun){
		var dropDownSet = "";
		if(gubun=='app'){
			dropDownSet = $("#dept_app");
			
			$("#sPerson_app").emptySelect();
				
		}else if(gubun=='auth'){
			dropDownSet = $("#dept_auth");
			
			$("#sPerson_auth").emptySelect();
		}
		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
			{
				orderType:"1"
			},
			//, system:sys_kind},
			function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					
					dropDownSet.loadSelect(data.groupList);
					
					setPerson(gubun);
					//adjustBranchList();
					
				} else {
					return;
				}
		});
	}

	//부서별 직원생성
	function setPerson(gubun){
		var value = "";
		var dropDownSet = "";
		
		if(gubun=='app'){
			value = $("#dept_app > option:selected").val();
			dropDownSet = $("#person_app");
		}else if(gubun=='auth'){
			value = $("#dept_auth > option:selected").val();
			dropDownSet = $("#person_auth");
		}
		
		if(value == undefined)
			return;
		
		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
				{
					orderType:"2",
					value:value
				},
				//, system:sys_kind},
				function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					
					dropDownSet.loadSelect(data.groupList);
					//adjustBranchList();
				
				} else {
					return;
				}
		});
	}


	//직원 추가
	function add(gubun){
		if(gubun=='app'){
			$("#person_app option:selected").each(function(i){
				var addOpt = document.createElement('option'); // 옵션을 설정한다..
				addOpt.value = $(this).val();
				addOpt.appendChild(document.createTextNode($(this).text())); // 셀렉트 박스의 text 를 설정한다.
				
				var flag = false;
				$("#sPerson_app option").each(function(i){
					if($(this).val() == addOpt.value){
						flag = true;
						return false;//break;
					}
				});
				
				if(!flag){
					$("#sPerson_app").append(addOpt);
				}
			});
		}else if(gubun=='auth'){
			$("#person_auth option:selected").each(function(i){
				var addOpt = document.createElement('option'); // 옵션을 설정한다..
				addOpt.value = $(this).val();
				addOpt.appendChild(document.createTextNode($(this).text())); // 셀렉트 박스의 text 를 설정한다.
				
				var flag = false;
				$("#sPerson_auth option").each(function(i){
					if($(this).val() == addOpt.value){
						flag = true;
						return false;//break;
					}
				});
				
				if(!flag){
					$("#sPerson_auth").append(addOpt);
				}
			});
		}
	}

	//직원 삭제
	function del(gubun){
		if(gubun=='app'){
			$("#sPerson_app option:selected").each(function(i){
				//$(this).appendTo('#person');
				$(this).remove();
			});
		}else if(gubun=='auth'){
			$("#sPerson_auth option:selected").each(function(i){
				//$(this).appendTo('#person');
				$(this).remove();
			});
		}
	}
	
	function fnCancel(){
		document.registform.action = "<c:url value='/dailywork/dailyWorkList.do?gubun=R'/>";
		document.registform.submit();
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
// 		layerPopClose("layerGroupIns");
// 		layerPopClose("layerGroupDel");
	}
	
	

	function approvalIdInsert(){
		var sPerson_app		= $('#sPerson_app').val();			//결재자
		
		//결재대상자
		var memberAppId = new Array;	
		var cnt_app = 0;
		
		$("#sPerson_app option").each(function() {
			memberAppId.push($(this).val());
			cnt_app++;
		});
		
		if(cnt_app==0){
			alert("결재자를 선택하여 주십시요.");
			return false;
		}
		
		if(cnt_app > 2 ){
			alert("결재자는 2명까지 선택하여 주십시오.");
			return false;
		}
		
		$("#memberAppId").val(memberAppId);
		
		var temp = $("#memberAppId").val().split(",");
		
		$.ajax({
			type:"post",
			url:"<c:url value='/dailywork/getApprovalInfo.do'/>",
			data:{approvalId1:temp[0],
					 approvalId2:temp[1]
				},
			dataType:"json",
			success:function(result){
				var approvalName1 = result['approvalName1'];
				var approvalName2 = result['approvalName2'];
				
	   			document.getElementById("approvalName1").innerHTML = approvalName1;
	   			document.getElementById("approvalName2").innerHTML = approvalName2;
	    			
	            isProcess = false;
			},
	        error:function(result){
					$("#alertDataList").html("<tr><td colspan='4'>서버접속 실패</td></tr>");
		        }
		});
		
		layerPopClose('layerApprovalIns')
		
		setDept('app');		//부서셋팅
	}
	function authIdInsert(){
		var sPerson_auth		= $('#sPerson_auth').val();		//작성권한
		
		//작성권한대상자
		var member_auth = new Array;	
		var cnt_auth = 0;
		
		$("#sPerson_auth option").each(function() {
			member_auth.push($(this).val());
			cnt_auth++;
		});
		
		if(cnt_auth==0){
			alert("작성권한 대상자를 선택하여 주십시요.");
			return false;
		}
		
		$("#memberAuthId").val(member_auth);
		
		layerPopClose('layerAuthIns')
		
		setDept('auth');		//부서셋팅
	}
	
	function fnSave(modGubun){
		var workDay	= $('#workDay').val();
		
		if(workDay == "") {
			alert("일자를 입력해 주십시요.");
			$("#workDay").focus();
			return false;
		}
		
		$('#modGubun').val(modGubun);
		
		var msg = "";
		
		if(modGubun=="app"){
			msg = "결재상신하시겠습니까?";
		}else{
			msg = "저장 하시겠습니까?";
		}
		
		if(confirm(msg)){
			document.registform.action = "<c:url value='/dailywork/riverMainModProc.do'/>";
			document.registform.submit();
		}
	}
	
	function fnList(){
		var modifyGubun = $('#modifyGubun').val();
		
		if(modifyGubun=='m'){
			document.registform.action = "<c:url value='/dailywork/dailyWorkList.do?gubun=R'/>";
		}else{
			document.registform.action = "<c:url value='/dailywork/receiveApprovalList.do'/>";
		}
		
		document.registform.submit();
	}
	
//]]>
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="layerFullBgDiv"></div>
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
					<div >
						<span style="text-align:center;"><u><b><h1>'4대강 주요수계' 상시감시 결과 일일보고</h1></b></u></span>
					</div>
					<div style="float:right; ">
						<table style="width:270px;">
							<colgroup>
							<col width="30px" />
							<col width="120px" />
							<col width="120px" />
							</colgroup>
							<tr>
								<th rowspan="2"  style="height:100px;">결<br/><br/>재</th>
								<td style="height:20px;"><b><span id="approvalName1"><c:out value="${approvalList[0].approvalName}"></c:out></span></b></td>
								<td><b><span id="approvalName2"><c:out value="${approvalList[1].approvalName}"></c:out></span></b></td>
							</tr>
							<tr>
								<td style="height:80px;"></td>
								<td></td>
							</tr>
						</table>
						<c:if test="${modifyGubun == 'm'}">
						<div style="padding-top:10px;">
							<input type="button" id="btnAppPopup" value="결재라인변경" class="btn btn_basic" style="float:right" alt="결재라인변경" onclick="javascript:layerPopOpen('layerApprovalIns');"/>
						</div>
						</c:if>
					</div>	
					<!--tab Contnet Start-->
					<div class="tab_container2">
						<div class="table_wrapper">
							<form name="registform" method="post" onsubmit="return false;">
								<input type="hidden" id="dailyWorkId" name="dailyWorkId" value="<c:out value="${dailyWorkVO.dailyWorkId}"/>"/>
								<input type="hidden" id="memberAppId" name="memberAppId" value=""/>
								<input type="hidden" id="memberAuthId" name="memberAuthId"/>
								<input type="hidden" id="rId" name="rId" value="<c:out value="${riverMainVO.rId}"/>"/>
								<input type="hidden" id="modGubun" name="modGubun" />
								<input type="hidden" id="modifyGubun" name="modifyGubun" value="<c:out value="${modifyGubun}"/>"/>
								
								<span style="float:left"><b>1. 일자</b> : <input type="hidden" id="workDay" name="workDay" size="15" value="<c:out value="${dailyWorkVO.workDay}"></c:out>"/><c:out value="${dailyWorkVO.workDay}"></c:out></span>
								<br />
								<div style="text-align:left;">
									<span><b></b></span> 
								</div>
								<br />
								<div style="text-align:left;">
									<span><b>2. 상시감시 주요결과(방제센터 및 지역본부 방제팀 세부내용)</b></span> <span><input type="button" id="btnAuthPopup" value="작성권한변경" class="btn btn_basic" alt="작성권한변경" onclick="javascript:layerPopOpen('layerAuthIns');"/></span>
								</div>
								<br/>
								<div>
									<table>
										<colgroup>
											<col width="120px" />
											<col width="150px" />
											<col width="150px" />
											<col />
											<col width="200px" />
										</colgroup>
										<tr>
											<th>구분</th>
											<th>감시구간</th>
											<th>감시시간(횟수)</th>
											<th>현장 확인결과 및 조치사항</th>
											<th>특이사항</th>
										</tr>
										<tr>
											<td>수질오염<p>상황팀</p></td>
											<td>4대강 등 <p>주요하천 및 주변</p></td>
											<td>24시간</td>
											<td>
												<textarea name="situationteamContent1" id="situationteamContent1" rows="2" style="width:96%;"><c:out value="${riverMainVO.situationteamContent1}"></c:out></textarea>
											</td>
											<td>
												<textarea name="situationteamContent2" id="situationteamContent2" rows="2" style="width:92%;"><c:out value="${riverMainVO.situationteamContent2}"></c:out></textarea>
											</td>
										</tr>
										<tr>
											<td>수도권<p>동부</p></td>
											<td>한강<p>(북한강, 남한강)</p></td>
											<td>10:00~17:00<p>(일 1회)</p></td>
											<td>
												<textarea name="capitalAreaContent1" id="capitalAreaContent1" rows="2" style="width:96%;"><c:out value="${riverMainVO.capitalAreaContent1}"></c:out></textarea>
											</td>
											<td>
												<textarea name="capitalAreaContent2" id="capitalAreaContent2" rows="2" style="width:92%;"><c:out value="${riverMainVO.capitalAreaContent2}"></c:out></textarea>
											</td>
										</tr>
										<tr>
											<td rowspan="2">경북권</td>
											<td>낙동강(대구청)<p>구미, 상주, 예천</p></td>
											<td>09:30~16:20</td>
											<td>
												<textarea name="gyeongbuk1Content1" id="gyeongbuk1Content1" rows="2" style="width:96%;"><c:out value="${riverMainVO.gyeongbuk1Content1}"></c:out></textarea>
											</td>
											<td>
												<textarea name="gyeongbuk1Content2" id="gyeongbuk1Content2" rows="2" style="width:92%;"><c:out value="${riverMainVO.gyeongbuk1Content2}"></c:out></textarea>
											</td>
										</tr>
										<tr>
											<td>낙동강(낙동강청)<p>창녕, 함안</p></td>
											<td>13:20~18:15</td>
											<td>
												<textarea name="gyeongbuk2Content1" id="gyeongbuk2Content1" rows="2" style="width:96%;"><c:out value="${riverMainVO.gyeongbuk2Content1}"></c:out></textarea>
											</td>
											<td>
												<textarea name="gyeongbuk2Content2" id="gyeongbuk2Content2" rows="2" style="width:92%;"><c:out value="${riverMainVO.gyeongbuk2Content2}"></c:out></textarea>
											</td>
										</tr>
										<tr>
											<td>충청권</td>
											<td>금강<p>서천, 익산, 논산,</p><p>공주, 세종, 옥천</p></td>
											<td>10:00~17:00</td>
											<td>
												<textarea name="chungcheongContent1" id="chungcheongContent1" rows="3" style="width:96%;"><c:out value="${riverMainVO.chungcheongContent1}"></c:out></textarea>
											</td>
											<td>
												<textarea name="chungcheongContent2" id="chungcheongContent2" rows="3" style="width:92%;"><c:out value="${riverMainVO.chungcheongContent2}"></c:out></textarea>
											</td>
										</tr>
										<tr>
											<td>호남권</td>
											<td>영산강<p>극락교, 송촌보,</p><p>죽산보</p></td>
											<td>09:00~17:00<p>(일 1회)</p></td>
											<td>
												<textarea name="honamContent1" id="honamContent1" rows="3" style="width:96%;"><c:out value="${riverMainVO.honamContent1}"></c:out></textarea>
											</td>
											<td>
												<textarea name="honamContent2" id="honamContent2" rows="3" style="width:92%;"><c:out value="${riverMainVO.honamContent2}"></c:out></textarea>
											</td>
										</tr>
									</table>
								</div>
							</form>
							<div style="padding-top:10px;">
								<input type="button" id="btnSave" value="저장" class="btn btn_basic" style="float:right" alt="저장" onclick="javascript:fnSave('mod');"/>
								<c:if test="${modifyGubun == 'm'}">
								<input type="button" id="btnApp" value="결재상신" class="btn btn_basic" style="float:right" alt="결재상신" onclick="javascript:fnSave('app');"/>
								</c:if>
								<input type="button" id="btnList" value="목록" class="btn btn_basic" style="float:right" alt="목록" onclick="javascript:fnList();"/>
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
	<!-- 레이어 팝업 -->
	<div id="layerApprovalIns" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnGroInsXbox" name="btnGroInsXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerApprovalIns');" alt="닫기"/>
		</div>
		<table summary="결재라인선택"style="text-align:left;">
				<tr>
					<th scope="col">결재라인선택</th>
				</tr>
				<tr>
					<td colspan="3" valign="top" style="padding:7px 7px 7px 100px">
						<div class="gBox" style="width:220px">
							<span class="ptit" >
								대상기관
							</span>
							<select multiple="multiple" id="dept_app" style="padding:7px;width:220px;height:190px"></select>
						</div>
						<div style="padding-top:25px;float:left"><img src="/images/renewal/parrow.gif" alt="다음단계"/></div>
						<div class="gBox">
							<span class="ptit">
								담당자
							</span>
							<select multiple="multiple" id="person_app" style="padding:7px;width:180px;height:190px"></select>
						</div>
						<ul class="arrbx">
							<li style="padding-top:70px;"><a href="javascript:add('app')"><img src="<c:url value='/images/renewal/bt_arradd.gif'/>" alt="추가" /></a></li><br/>
							<li><a href="javascript:del('app')"><img src="<c:url value='/images/renewal/bt_arrdel.gif'/>" alt="삭제" /></a></li>
						</ul>
						<div class="gBox">
							<span class="ptit">
								결재자
							</span>
							<select multiple="multiple" id="sPerson_app" style="padding:7px;width:180px;height:190px"></select>
						</div>
					</td>
				</tr>
			</table>
		<div id="btCarea">
			<input type="button" id="btnRegist" name="btnRegist" value="등록" class="btn btn_white" onclick="javascript:approvalIdInsert();" alt="등록"/>
		</div>
	</div>
	<!-- 작성권한자 레이어 팝업 -->
	<div id="layerAuthIns" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnGroInsXbox" name="btnGroInsXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerAuthIns');" alt="닫기"/>
		</div>
		<table summary="작성권한 선택"style="text-align:left;">
				<tr>
					<th scope="col">작성권한 선택</th>
				</tr>
				<tr>
					<td colspan="3" valign="top" style="padding:7px 7px 7px 100px">
						<div class="gBox" style="width:220px">
							<span class="ptit" >
								대상기관
							</span>
							<select multiple="multiple" id="dept_auth" style="padding:7px;width:220px;height:190px"></select>
						</div>
						<div style="padding-top:25px;float:left"><img src="/images/renewal/parrow.gif" alt="다음단계"/></div>
						<div class="gBox">
							<span class="ptit">
								담당자
							</span>
							<select multiple="multiple" id="person_auth" style="padding:7px;width:180px;height:190px"></select>
						</div>
						<ul class="arrbx">
							<li style="padding-top:70px;"><a href="javascript:add('auth')"><img src="<c:url value='/images/renewal/bt_arradd.gif'/>" alt="추가" /></a></li><br/>
							<li><a href="javascript:del('auth')"><img src="<c:url value='/images/renewal/bt_arrdel.gif'/>" alt="삭제" /></a></li>
						</ul>
						<div class="gBox">
							<span class="ptit">
								작성권한
							</span>
							<select multiple="multiple" id="sPerson_auth" style="padding:7px;width:180px;height:190px"></select>
						</div>
					</td>
				</tr>
			</table>
		<div id="btCarea">
			<input type="button" id="btnRegist" name="btnRegist" value="등록" class="btn btn_white" onclick="javascript:authIdInsert();" alt="등록"/>
		</div>
	</div>
</body>
</html>