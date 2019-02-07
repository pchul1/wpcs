<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : alertSmsSend.jsp
	 * Description : SMS통보 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2013.10.31	lkh			리뉴얼
	 * 
	 * author lkh
	 * since 2013.10.31
	 * 
	 * Copyright (C) 2013 by lkh All right reserved.
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

<%-- <script type="text/javascript" src="<c:url value='/psupport/history/history.js'/>"></script> --%>
<script type="text/javascript">
	$(function(){
		if ($.browser.safari || $.browser.opera)
			$("#smsMsg").attr("rows",8);
		
		$("#system").change(function(){
			adjustGongku();
		});
		
		$('#sugye').change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			adjustBranch();
		});
		
		$('#branchNo').change(function(){
			//getGroupList();
			setDept();
		});
		
		$('#sendSmsBtn').click(function(){
			sendSms();
		});
		
		$('#sendSmsImg').click(function(){
			sendSms();
		});
		
		$('#smsMsg').keyup(function(){
			var bytes = ChkByte1(smsForm.smsMsg,80);
			
			$('#byteSpan').html(bytes);
			
			/*
			if(bytes > 80){
				 var objstrlen = smsForm.value.length;
				 //$('#byteSpan').html(objstrlen); 
			}else{
				$('#byteSpan').html(bytes);
			}
			*/
		});
		
		/*
		$('#smsMsg').keydown(function(){
			if( $('#smsMsg').val().length > 80){
				
				var tempStr = $('#smsMsg').val().substr(0, 79);
				
				$('#smsMsg').val(tempStr);
				$('#byteSpan').html($('#smsMsg').val().length);
				
				alert('80byte 이상 입력할 수 없습니다.');
			}
		});
		*/
		
		$('#msgPop').click(function(){
			openMsgPop();
		});
		
		$("#dept").change(function(){
			setPerson();
		});
		
		setDept();
		
		adjustGongku();
	});
	
	function ChkByte1(objname, maxlength) {
		var objstr = objname.value;			// 입력된 문자열을 담을 변수
		var objstrlen = objstr.length;		// 전체길이
		
		// 변수초기화 
		var maxlen = maxlength;		// 제한할 글자수 최대크기 
		var i = 0;					// for문에 사용 
		var bytesize = 0;			// 바이트크기 
		var strlen = 0;				// 입력된 문자열의 크기
		var onechar = "";			// char단위로 추출시 필요한 변수 
		var objstr2 = "";			// 허용된 글자수까지만 포함한 최종문자열
		
		var cutLength = 0;
		
		// 입력된 문자열의 총바이트수 구하기
		for(i=0; i< objstrlen; i++) {
			// 한글자추출 
			onechar = objstr.charAt(i);
			
			if (escape(onechar).length > 4) {
				bytesize += 2;		// 한글이면 2를 더한다.
			} else {
				bytesize++;			// 그밗의 경우는 1을 더한다.
			}
			
			if(bytesize <= maxlen){		// 전체 크기가 maxlen를 넘지않으면 
				strlen = i + 1;			// 1씩 증가
			}
		}
		
		// 총바이트수가 허용된 문자열의 최대값을 초과하면	
		if(bytesize > maxlen) {
			
			var bytesize2 = 0;
			
			alert('80byte 이상 입력할 수 없습니다');
			
			for(i=0; i< objstrlen; i++) {
				// 한글자추출 
				onechar = objstr.charAt(i);
				
				if (escape(onechar).length > 4) {
					bytesize2 += 2;		// 한글이면 2를 더한다.
				} else {
					bytesize2++;		// 그밗의 경우는 1을 더한다.
				} 
				
				if(bytesize2 > 80){
					cutLength = i-1;
					break;
				}
			}
			
			objstr2 = objstr.substr(0, cutLength);
			objname.value = objstr2;
			
			var bytesize3 = 0;
			
			for(i=0; i< objstr2.length; i++) {
				// 한글자추출
				//onechar = objstr2.charAt(i); 
				onechar = objstr2.charCodeAt(i);
				
				//if (escape(objstr2).length > 4) {
				if( onechar > 0x3130 && onechar < 0x318F){
					bytesize3 += 2;		// 한글이면 2를 더한다.
				} else {
					bytesize3++;		// 그밗의 경우는 1을 더한다.
				}
			}
			bytesize = bytesize3;
		}
		return bytesize;
	}
	
	function sendSms(){
		var system = $("#system").val();
		var sugye = $('#sugye').val();
		var factCode = $('#factCode').val();
		var branchNo = $('#branchNo').val();
		var actKind = $("#actKind").val();
		var phoneNo = $('#phoneNo').val();
		var member="";
		var regId = "<sec:authentication property="principal.userVO.id"/>";
		
		var cnt = 0;
		var cnt2 = 0;
		$("#sPerson option").each(function() {
			if(cnt!=0) member += ",";
			member += $(this).val();
			cnt++;
		});
		
		if(phoneNo != ''){
			cnt2++;
		}
		
		if(cnt > 0 && cnt2 > 0){
			alert("번호입력과 선택입력 둘중에 하나만 가능합니다.");
			$('#phoneNo').focus();
			return;	
		}
		
		/*
		$('input[name=memberId]:checked').each(function() {
			member.push(this.value);
			cnt++
		});
		*/
		
		var smsMsg = $('#smsMsg').val();
		
		if(smsMsg == "") {
			alert("SMS 메시지를 입력하여 주십시요.");
			return;
		}
		
		if(cnt2 == 0 && cnt == 0){
			alert("대상자를 선택하거나 번호를 입력해주십시요.");
			return;
		}

		$.ajax({
			type:"post",
			url:"<c:url value='/alert/sendSms.do'/>",
			data:{system:system, sugye:sugye, factCode:factCode, branchNo:branchNo, memberId:member,
					smsMsg:smsMsg, regId:regId, actKind:actKind, phoneNo:phoneNo},
			dataType:"json",
			success:function(result){
				var cnt = result['cnt'];
				if(cnt == '0') {
					alert("전송에 실패했습니다.");
				} else {
					alert("SMS 발송을 등록하였습니다\n(실제 발송 여부는 TMS의 SMS서버 상태에 따라 다를 수 있습니다.");
					$('#smsMsg').attr('value','');
				}
			},
			error:function(result){alert("error");isProcess = false;}
		});
	}
	
	function openMsgPop() {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 420;
		var winWidth = 700;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		window.open("<c:url value='/alert/alertSmsMsg.do' />",
				'msgPop','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	// 공구 목록 가져오기
	function adjustGongku(){
		var system = $('#system').val();
		var sugyeCd = $('#sugye').val();
		var dropDownSet = $('#factCode');
		var dropDownSetBranch = $('#branchNo');
		
		if( sugyeCd == 'all' ){
			dropDownSet.attr("disabled", true);
			dropDownSet.emptySelect2();
			dropDownSetBranch.attr("disabled", true);
			dropDownSetBranch.emptySelect2();
			
			//getGroupList();
			setDept();
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getGongkuList.do", {system:system, sugye:sugyeCd}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect2(data.gongku);
					
					adjustBranch();
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	//측정소 목록 가져오기
	function adjustBranch()
	{	
		var factCode = $('#factCode').val();
		var dropDownSet = $('#branchNo');
		if( factCode == 'all' ){
			dropDownSet.attr("disabled", true);
			dropDownSet.emptySelect2();
			
			//getGroupList();
			setDept();
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getBranchList.do", {factCode:factCode}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect2(data.branch);
					
					setDept();
					//getGroupList();
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	function chkMember(obj, target) {
		var c = $(obj).attr('checked');
		$("#"+target+" :input[name=memberId]").attr('checked',c);
	}
	
	function checkAll(){
		var c = $('#checkA').attr('checked');
		$('input[name=groupId]').attr('checked',c);
		$('input[name=memberId]').attr('checked',c);
	}
	
	function setDept(){
		var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
		var system = $("#system").val();
		var sugye = $("#sugye").val();
		
		var dropDownSet = $("#dept");
		
		$("#sPerson").emptySelect();
		
		/* $.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
			{
				orderType:"1",
				branchNo:branchNo,
				factCode:factCode,
				system:system,
				sugye:sugye
			},
			//, system:sys_kind},
			function (data, status){
			if(status == 'success'){
				//locId 객체에 SELECT 옵션내용 추가.
				dropDownSet.loadSelect(data.groupList);
				
				$("#dept > option:first").attr("selected","selected");
				
				setPerson();
				//adjustBranchList();
			} else {
				return;
			}
		}); */
		
		$.getJSON("<c:url value='/alert/getSmsGroupListMobile.do'/>",
				{
					orderType:"1",
					branchNo:branchNo,
					factCode:factCode,
					system:system,
					sugye:sugye
				},
				//, system:sys_kind},
				function (data, status){
					if(status == 'success'){
						//locId 객체에 SELECT 옵션내용 추가.
						
						dropDownSet.loadSelect(data.groupList);
						
						$("#dept > option:first").attr("selected","selected");
						
						setPerson();
						//adjustBranchList();
						
					} else {
						return;
					}
			});
	}
	
	function setPerson(){
		/* var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
		var system = $("#system").val();
		var sugye = $("#sugye").val(); */
		
		var value = $("#dept > option:selected").val();
		var dropDownSet = $("#person");
		
		if(value == undefined)
			return;
		
		/* $.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
			{
				orderType:"2",
				value:value,
				branchNo:branchNo,
				factCode:factCode,
				system:system,
				sugye:sugye
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
			}); */
			
			$.getJSON("<c:url value='/alert/getSmsMemberList.do'/>",
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
	
	function add(){
		$("#person option:selected").each(function(i){
			
			var addOpt = document.createElement('option'); // 옵션을 설정한다..
			addOpt.value = $(this).val();
			addOpt.appendChild(document.createTextNode($(this).text())); // 셀렉트 박스의 text 를 설정한다.
			
			var flag = false;
			$("#sPerson option").each(function(i){
				if($(this).val() == addOpt.value)
				{
					flag = true;
					return false;//break;
				}
			});
			
			if(!flag){
				$("#sPerson").append(addOpt);
			}
		});
	}
	
	function del(){
		$("#sPerson option:selected").each(function(i){
			//$(this).appendTo('#person');
			$(this).remove();
		});
	}
		
	//숫자체크
	function checkNum(inputValue){
		var checkCode = inputValue.value.charCodeAt(inputValue.value.length-1);
		var str; 
		
		if(checkCode >= 33 && checkCode <= 47 || checkCode >= 58 && checkCode <= 125){
			alert("숫자만 입력가능합니다.");
		
			str = inputValue.value.substring(0,inputValue.value.length-1);
			inputValue.value = str;  
			inputValue.focus();
		}else if( checkCode >= 48 && checkCode <= 57 ){
			inputValue.focus();
		}
	}
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
						
						<div class="divisionBx">
							
							<form name="smsForm" action="" onsubmit="return false;">
								
								<div class="smsbx">
									<div style="padding:0px 7px 5px 7px;color:#fff;font-weight:600">문자입력</div>
									<textarea id="smsMsg" name="smsMsg" rows="10" cols="19" class="textArea" style="overflow:visible;"></textarea>
									<div class="right" style="padding:6px 50px 5px 7px;"><span id="byteSpan">0</span>/80byte</div>
									<div style="padding-top:50px;">
										<span style="line-height:30px;font-weight:600">번호 직접 입력 : </span>
										<input type="text" id="phoneNo" name="phoneNo" size="11" maxlength="11" style="ime-mode:disabled;width:145px;" onkeyup="checkNum(this)"/>
										<img src="/images/renewal/btn_send.png" id="sendSmsImg" alt="보내기" style="cursor:pointer"/>
									</div>
								</div>
								<div class="smsOutbx">
									<div class="smsInbx">
										
										<div class="pinfobx">
											<div>
												<h3>대상자선택</h3>
												<ul>
													<li>
														<span>시스템 </span>: 
														<select id="system" name="system" style="width:150px">
															<option value="all">전체</option>
															<!-- <option value="T">탁수 모니터링</option> -->
															<option value="U">이동형측정기기</option>
															<option value="A">국가수질자동측정망</option>
														</select>
														<span style="margin-left:105px;">유형 </span>: 
														<select id="actKind" name="actKind" style="width:150px">
															<option value="E">긴급</option>
															<option value="W">기상</option>
															<option value="T">훈련</option>
															<option value="C">점검</option>
															<option value="A">기타</option>
														</select>
													</li>
													<li>
														<span>장소 </span>:
														<select id="sugye" name="sugye">
															<option value="all">전체</option>
															<option value="R01">한강</option>
															<option value="R02">낙동강</option>
															<option value="R03">금강</option>
															<option value="R04">영산강</option>
														</select>
														&gt;
														<select id="factCode" name="factCode" _style="width:100px"></select>
														&gt;
														<select id="branchNo" name="branchNo" _style="width:100px"></select>
													</li>
													<li>
														<span style="float:left;">그룹 </span>
														
														<div class="gBox" style="width:220px">
															<span class="ptit" >대상기관</span>
															<select multiple="multiple" id="dept" style="padding:7px;width:220px;height:190px"></select>
														</div>
														<div style="padding-top:25px;float:left"><img src="/images/renewal/parrow.gif" alt="다음단계"/></div>
														<div class="gBox">
															<span class="ptit">담당자</span>
															<select multiple="multiple" id="person" style="padding:7px;width:180px;height:190px"></select>
														</div>
														<ul class="arrbx">
<%-- 															<li style="padding-top:70px;"><a href="javascript:add()"><img src="<c:url value='/images/common/btn_getIns.gif'/>" alt="추가" /></a></li> --%>
															<li style="padding-top:70px;"><a href="javascript:add()"><img src="<c:url value='/images/renewal/bt_arradd.gif'/>" alt="추가" /></a></li><br/>
<%-- 															<li><a href="javascript:del()"><img src="<c:url value='/images/common/btn_getDel.gif'/>" alt="삭제" /></a></li> --%>
															<li><a href="javascript:del()"><img src="<c:url value='/images/renewal/bt_arrdel.gif'/>" alt="삭제" /></a></li>
														</ul>
														<div class="gBox">
															<span class="ptit">전파대상자</span>
															<select multiple="multiple" id="sPerson" style="padding:7px;width:180px;height:190px"></select>
														</div>
													</li>
												</ul>
											</div>
										</div>
										
										<ul style="display:inline-block;padding-top:10px;text-align:left;" id="menuAuth1">
											<li style="display:inline;"><input type="image" id="sendSmsBtn" src="<c:url value='/images/waterpolmnt/btn_send.gif'/>" alt="전송" /></li>
											<li style="display:inline;"><input type="image" id="msgPop" src="<c:url value='/images/common/btn_premsg.gif'/>" alt="이전메세지" /></li>
										</ul>
									</div>
								</div>
										<div align="right">
											<input type="button" id="btnDownload" name="btnDownload" value="비상연락망다운" class="btn btn_basic" onclick="javascript:fn_egov_downFile('FILE_000000000000001','${fileSeq}');" alt="비상연락망다운">
											<sec:authorize ifAnyGranted="ROLE_ADMIN">
											<input type="button" id="btnUpload" name="btnUpload" value="비상연락망등록" class="btn btn_basic" onclick="javascript:fn_address_upload('FILE_000000000000001','${fileSeq}');" alt="비상연락망등록">
											</sec:authorize>
										</div>
							</form>
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
	<script language="javascript">
	function fn_egov_downFile(atchFileId, fileSn){
		window.open("<c:url value='/cmmn/FileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"'/>", "download");
	}	
	
	function fn_address_upload(atchFileId, fileSn){
		window.open("<c:url value='/alert/popupAddressRegist.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"'/>","address","width=550px, height=130px, top=300px, left=300px");
	}	
	
	function menuAuth(auth){
		var iauthC ="";
		var iauthU ="";
		var iauthD ="";
		if(auth == "C"){
			iauthC ="Y";
		}
		if(auth == "U"){
			iauthU ="Y";
		}
		if(auth == "D"){
			iauthD ="Y";
		}
		var menuAuth = ""	;
		$.ajax({	
			type:"post",
			url: "<c:url value='/admin/member/getUserAuthorCnt.do'/>",
			dataType:"json",
			async: false,
			data:{
				userId:$("#userId").val(),
				menuId:$("#naviMenuNo").val(),
				authC:iauthC,
				authU:iauthU,
				authD:iauthD
			},
			success : function(result){
				var tot = 0;
				 tot = result['getUserMenuAuthorCount'];
				 menuAuth = tot;
			}
		});
		return menuAuth;
	}
	if("1" == menuAuth("C")){
		$("#menuAuth1").show();
	}else{
		$("#menuAuth1").hide();
	}
	</script>
</body>
</html>