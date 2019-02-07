<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	* Class Name : KeywordList.jsp
	* Description : 비밀번호관리 화면
	* Modification Information
	* 
	* 수정일			수정자					수정내용
	* -------		--------	---------------------------
	* 2013.01.13	~			최초 생성
	* 2013.11.01	lkh			리뉴얼
	* 
	* author
	* since 2013.01.13
	* 
	* Copyright (C) 2013 by ~ All right reserved.
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
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="keywordVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript">
	$(function (){
		setDept();		//부서셋팅
		$("#dept").change(function(){
			setPerson(); //직원셋팅
		});
		
		$("#Allckeck").change(function(){
			$("input[name='SeqCheck']").attr("checked",$("#Allckeck").is(":checked"));
		})
		
		$("input[name='SeqCheck']").change(function(){
			if($("input[name='SeqCheck']").length == $("input[name='SeqCheck']:checked").length )
				$("#Allckeck").attr("checked",true);
			else $("#Allckeck").attr("checked",false);
		});
	})
	
	//부서별 직원생성
	function setPerson(){
		var value = $("#dept > option:selected").val();
		var dropDownSet = $("#person");
		
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
	
	function setDept(){
		var dropDownSet = $("#dept");
		
		$("#sPerson").emptySelect();
		
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
					//adjustBranchList();
					
				} else {
					return;
				}
		});
	}
	
	//SMS 보낼 직원 추가
	function add(){
		$("#person option:selected").each(function(i){
			var addOpt = document.createElement('option'); // 옵션을 설정한다..
			addOpt.value = $(this).val();
			addOpt.appendChild(document.createTextNode($(this).text())); // 셀렉트 박스의 text 를 설정한다.
			
			var flag = false;
			$("#sPerson option").each(function(i){
				if($(this).val() == addOpt.value){
					flag = true;
					return false;//break;
				}
			});
			
			if(!flag){
				$("#sPerson").append(addOpt);
			}
		});
	}
	
	//SMS 보낼 직원 삭제
	function del(){
		$("#sPerson option:selected").each(function(i){
			//$(this).appendTo('#person');
			$(this).remove();
		});
	}
	
	function goSave(){
		var member = new Array;	
		var cnt = 0;
		
		$("#sPerson option").each(function() {
			member.push($(this).val());
			cnt++;
		});
		$("#member_id").val(member);
		
		if(cnt == 0) {
			alert("대상자를 선택하여 주십시요.");
			return false;
		}
		
		if(confirm("등록하시겠습니까?"))
		{
			document.frm.action = "/admin/mindataEmployee/MindataEmployeeRegist.do";
			document.frm.submit();
		}
	}
	

	function goDelete(){
		if($("input[name='SeqCheck']:checked").length < 1)
		{
			alert("하나라도 선택하셔야 합니다.");
			return false;
		}
		
		if($("input[name='SeqCheck']").length - $("input[name='SeqCheck']:checked").length < 1)
		{
			alert("한명이상은 담당자가 존재해야 합니다.");
			return false;
		}
		
		if(confirm("선택한 담당자를 삭제하시겠습니까?")){
			document.frm.action = "/admin/mindataEmployee/MindataEmployeeDelete.do";
			document.frm.submit();
		}
	}
	
	function goDefiniteDate(){
		if(confirm('저장하시겠습니까?')){
			document.frm.action = "/admin/mindataEmployee/MindataDefiniteDate.do";
			return true;
		} else{
			return false;
		}
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
			<form id="frm" action="/admin/mindataEmployee/MindataEmployeeRegist.do" name="frm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="return_url" value="/admin/mindataEmployee/MindataEmployee.do"/>
				<input type="hidden" name="gubun" value="S"/>
				<input type="hidden" name="member_id" id="member_id"/>
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
							<div class="btnSearchDiv" style="clear:both;margin: 10px 0;">
								<div style="float:right;">
									알림 일자 : 매월
									<select name="definite_date">
										<c:forEach begin="1" end="28" step="1" var="item">
										<c:set var="min" value="${item}"/>
										<c:if test="${item < 10}">
											<c:set var="min" value="0${item}"/>
										</c:if>
											<option value='<c:out value="${min}"/>'<c:if test="${List[0].definite_date eq min}"> selected="selected"</c:if>><c:out value="${min}"/></option>
										</c:forEach>
									</select>
									<input type="submit" name="btnEgovDefiniteDateMember" value="저장" class="btn btn_search" onclick="goDefiniteDate()" alt="저장" />
								</div>
							</div>
							<table>
								<colgroup>
									<col width="40" />
									<col width="150" />
									<col width="100" />
									<col width="*" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col"><input type="checkbox" id="Allckeck"></th>
										<th scope="col">선별자 ID</th>
										<th scope="col">수신자</th>
										<th scope="col">소속</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${List}">
										<tr>
											<td><input type="checkbox" id="SeqCheck" name="SeqCheck" value="<c:out value="${item.seq}"/>"></td>
											<td><c:out value="${item.member_id}"/></td>
											<td><c:out value="${item.member_name}"/></td>
											<td><c:out value="${item.dept_name}"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							
							<div class="btnSearchDiv" style="clear:both;margin:10px 0;">
								<div style="float:left;color:red">
									※ 설정하신 알림 일자로 담당자에게 선별 및 확정요청 알림이 발송됩니다.
								</div>
								<div style="float:right;">
									<input type="button" id="btnEgovRegistMember" name="btnEgovRegistMember" value="등록" class="btn btn_search" onclick="$('#registlayerid').css('display','');return false;" alt="등록" />
									<input type="button" value="삭제" class="btn btn_search" onclick="return goDelete();" alt="삭제" />
								</div>
							</div>
							
							<div>
								<div id="registlayerid" style="margin-top:20px;display:none;">
									<div>
										<div class="gBox" style="width:340px">
											<span class="ptit" >
												대상기관
											</span>
											<select multiple="multiple" id="dept" style="padding:7px;width:330px;height:190px"></select>
										</div>
										
										<div style="padding-top:25px;float:left"><img src="/images/renewal/parrow.gif" alt="다음단계"/></div>
										
										<div class="gBox" style="width:285px">
											<span class="ptit">
												담당자
											</span>
											<select multiple="multiple" id="person" style="padding:7px;width:280px;height:190px"></select>
										</div>
										
										<ul class="arrbx">
											<li style="padding-top:70px;"><a href="javascript:add()"><img src="<c:url value='/images/renewal/bt_arradd.gif'/>" alt="추가" /></a></li><br/>
											<li><a href="javascript:del()"><img src="<c:url value='/images/renewal/bt_arrdel.gif'/>" alt="삭제" /></a></li>
										</ul>
										
										<div class="gBox" style="width:285px">
											<span class="ptit">
												전파대상자
											</span>
											<select multiple="multiple" id="sPerson" style="padding:7px;width:280px;height:190px"></select>
										</div>
									</div>
									
									<div class="btnSearchDiv" style="clear:both;padding-top:10px;">
										<div style="padding-right:10px;float:right;">
											<input type="button" value="취소" class="btn btn_search" onclick="$('#registlayerid').css('display','none');return false;" alt="취소" />
											<input type="button" id="btnEgovRegistMember" name="btnEgovRegistMember" value="저장" class="btn btn_search" onclick="return goSave();" alt="저장" />
										</div>
									</div>
								</div>
							</div>
						</div>
						<!--tab Contnet End-->
					</div>
					<!-- Content End-->
				</div>
			</form>	
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