<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : checkUseRegist.jsp
	 * Description : 점검및사용일지 등록
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2018.01.15	choi heo seop	
	 * 
	 * author 
	 * since 2018.01.15
	 * 
	 * Copyright (C) 2018 by K-Eco All right reserved.
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

<script type="text/javascript">
//<![CDATA[
	$(function () {
		$("#dept_app").change(function(){
			setPerson('app'); //직원셋팅
		});
		$("#dept_auth").change(function(){
			setPerson('auth'); //직원셋팅
		});
		setDept('auth');		//직원셋팅
		setDept('app');		//부서셋팅
		
		//시간셋팅
		setTime();
	});
	
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
		
		var today = new Date(); 
		today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		$("#workDay").val(today);
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
		}
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
	
	function fnNext(){
		var sPerson_app		= $('#sPerson_app').val();			//결재자
		var sPerson_auth		= $('#sPerson_auth').val();		//작성권한
		
		//결재대상자
		var member_app = new Array;	
		var cnt_app = 0;
		
		$("#sPerson_app option").each(function() {
			member_app.push($(this).val());
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
		
		$("#memberAppId").val(member_app);
		
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
		
// 		alert($("#memberAuthId").val());
		
		if(confirm("저장 하시겠습니까?")){
			document.registform.action = "<c:url value='/dailywork/checkUseRegDetail.do'/>";
			document.registform.submit();
		}
	}
	
	
	function fnCancel(){
		document.registform.action = "<c:url value='/dailywork/checkUseList.do'/>";
		document.registform.submit();
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
						<div class="table_wrapper">
							<form name="registform" method="post" onsubmit="return false;">
								<input type="hidden" id="memberAppId" name="memberAppId"/>
								<input type="hidden" id="memberAuthId" name="memberAuthId"/>
								<input type="hidden" id="gubun" name="gubun" value="${param.gubun }"/>
								<div style="text-align:left; padding-bottom:10px;">
									<span>□ 일자 : <input type="text" id="workDay" name="workDay" size="15"/></span>
								</div>
								<div>
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
									<tr>
										<th scope="col">작성권한선택</th>
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
								</div>
							</form>
							<div style="padding-top:10px;">
								<input type="button" id="btnNext" value="다음" class="btn btn_basic" style="float:right" alt="다음" onclick="javascript:fnNext();"/>
								<input type="button" id="btnCancel" value="취소" class="btn btn_basic" style="float:right" alt="취소" onclick="javascript:fnCancel();"/>
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