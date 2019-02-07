<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
  /**
  * @Class Name : alertSmsSend.jsp
  * @Description : Alert Sms Send 화면
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
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/plugin/jquery.treeview.js'/>"></script>
<%-- 	<sec:authorize  ifNotGranted="ROLE_USER"> --%>
<!-- 		<script  type='text/javascript'> -->
<!-- 			alert('로그인이 필요한 페이지 입니다'); -->
<!-- 			self.close(); -->
<!-- 		</script> -->
<%-- 	</sec:authorize>		 --%>
	<script>
	var paramSugye = '<c:out value="${sugye}"/>';
	var paramFactCode = '<c:out value="${factCode}"/>';
		$(function(){
	
			//==========================================
			// 초기값 설정
			var bytes = ChkByte(smsForm.smsMsg,80);
			$('#byteSpan').html(bytes);
			$('#sugye').val(paramSugye);
			//==========================================
			
			$('input[name=system]').click(function(){							
				adjustGongkuDropDown();
			});				

			$('#sugye').change(function(){
				adjustGongkuDropDown();
			});		

			$('#factCode').change(function(){
				adjustBranchDropDown();
			});	  		

			$('#branchNo').change(function(){
				getGroupList();
			});		

			$('#sendSmsBtn').click(function(){
				sendSms();
			});					
 			
			$('#smsMsg').keyup(function(){
				var bytes = ChkByte(smsForm.smsMsg,80);
				$('#byteSpan').html(bytes);
			});	 		
			
			adjustGongkuDropDown();
		});

		function ChkByte(objname,maxlength) {  
			 var objstr = objname.value; // 입력된 문자열을 담을 변수 
			 var objstrlen = objstr.length; // 전체길이 
			
			 // 변수초기화 
			 var maxlen = maxlength; // 제한할 글자수 최대크기 
			 var i = 0; // for문에 사용 
			 var bytesize = 0; // 바이트크기 
			 var strlen = 0; // 입력된 문자열의 크기
			 var onechar = ""; // char단위로 추출시 필요한 변수 
			 var objstr2 = ""; // 허용된 글자수까지만 포함한 최종문자열
			
			 // 입력된 문자열의 총바이트수 구하기
			 for(i=0; i< objstrlen; i++) { 
				  // 한글자추출 
				  onechar = objstr.charAt(i); 
				  
				  if (escape(onechar).length > 4) { 
				   	bytesize += 2;     // 한글이면 2를 더한다. 
				  } else {  
				   	bytesize++;      // 그밗의 경우는 1을 더한다.
				  } 
				  
				  if(bytesize <= maxlen)  {   // 전체 크기가 maxlen를 넘지않으면 
				   	strlen = i + 1;     // 1씩 증가
				  }
			 }

			 // 총바이트수가 허용된 문자열의 최대값을 초과하면 
			 if(bytesize > maxlen) { 
			  	objstr2 = objstr.substr(0, strlen); 
			  	objname.value = objstr2; 

			  	bytesize = bytesize - 1;
			 } 
			 
			 return bytesize;
		}				
 		
		function sendSms(){
			var system = $('input[name=system]:checked').val();
			var sugye = $('#sugye').val();
			var factCode = $('#factCode').val();
			var branchNo = $('#branchNo').val();
			var member = new Array;

			var cnt = 0;
			$('input[name=memberId]:checked').each(function() {
				member.push(this.value);
				cnt++
			});				

			var smsMsg = $('#smsMsg').val();

			if(smsMsg == "") {
				alert("SMS 메시지를 입력하여 주십시요.");
				return;
			}

			if(cnt == 0) {
				alert("대상자를 선택하여 주십시요.");
				return;				
			}
			
			$.ajax({
				type:"post",
				url:"<c:url value='/alert/sendSms.do'/>",
				data:{system:system, sugye:sugye, factCode:factCode, branchNo:branchNo, memberId:member,
						smsMsg:smsMsg},
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

		function openDeptPop() {
			var sw=screen.width;
			var sh=screen.height;
			var winHeight = 450;
			var winWidth = 700;
			var winLeftPost = (sw - winWidth) / 2;var winTopPost = (sh - winHeight) / 2;
			var width = winWidth-40;
			var height = winHeight-40;
			
			window.open("<c:url value='/cmmn/deptTree.do' />", 
					'deptForm','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);									
		}		
		
		// 공구 목록 가져오기
		function adjustGongkuDropDown()
		{		
			var system = $('input[name=system]:checked').val();
			
			var sugyeCd = $('#sugye').val();
			var dropDownSet = $('#factCode');
			var dropDownSetBranch = $('#branchNo');			
			if( sugyeCd == 'all' ){
				dropDownSet.attr("disabled", true);
				dropDownSet.emptySelect2();			
				dropDownSetBranch.attr("disabled", true);
				dropDownSetBranch.emptySelect2();		

				getGroupList();											
			}else{
				dropDownSet.attr("disabled", false);
				$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getGongkuList.do", {system:system, sugye:sugyeCd}, function (data, status){
				     if(status == 'success'){     
				        //locId 객체에 SELECT 옵션내용 추가.
				        dropDownSet.loadSelect2(data.gongku);

				        if(paramFactCode != "") {
							$('#factCode').val(paramFactCode);
						}
				        
				        adjustBranchDropDown();
				     } else { 
				    	 alert("공구 목록 가져오기 실패");
				        return;
				     }
				});
			}
					
		}						

		//측정소 목록 가져오기
		function adjustBranchDropDown()
		{	
			var factCode = $('#factCode').val();
			var dropDownSet = $('#branchNo');
			if( factCode == 'all' ){
				dropDownSet.attr("disabled", true);
				dropDownSet.emptySelect2();

				getGroupList();
			}else{
				dropDownSet.attr("disabled", false);
				$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getBranchList.do", {factCode:factCode}, function (data, status){
				     if(status == 'success'){     
				        //locId 객체에 SELECT 옵션내용 추가.
				        dropDownSet.loadSelect2(data.branch);
				        
				        getGroupList();
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
			alert('checkAll');
			var c = $('#checkA').attr('checked');
			$('input[name=groupId]').attr('checked',c);
			$('input[name=memberId]').attr('checked',c);
		}		
		
		// 조직 목록 가져오기
		function getGroupList()
		{	
			var system = $('input[name=system]:checked').val();
			var sugye = $('#sugye').val();
			var factCode = $('#factCode').val();
			var branchNo = $('#branchNo').val();
		
			var dropDownSet = $('#group');

			var html = "";
			$('#groupDiv').html("");						

			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/alert/getGroupList.do' />", {system:system, sugye:sugye, factCode:factCode, branchNo:branchNo}, function (data, status){
			     if(status == 'success'){

			    	html += "<div id='sidetreecontrol'><a href='?#'>전체닫기</a> | <a href='?#'>전체열기</a></div>";			    				    
					html += "<ul id='test' class='filetree'><li><p class='folder'><input type='checkbox' id='checkA' checked onclick='checkAll()' value='전체' /><label for=''>전체</label></p><ul>";
			    	
					var groupList = data.groupList;
					
					var preType = "";
					var brChk = 0;					
					var checkId = "";

					for(var i=0; i<groupList.length; i++) { 							
						if(i == 0 ) {							
							html += "<li>";
						}
						if(groupList[i].ORDER_TYPE == "1") {							
							if(preType == "2") {
								html += "</ul></li><li>";								
							}
							
							html += "<p class='folder'><input checked type='checkbox' name='groupId' class='inputCheck' value='A"+groupList[i].KEY+"' onclick='chkMember(this, \"A"+groupList[i].KEY+"\")' /> <label for=''>"+groupList[i].CAPTION+"</label></p>";
							checkId = "A"+groupList[i].KEY;
							brChk++;
						} else {
							if(preType == "1") {
								html += "<ul id='"+checkId+"' class='person'>";
							}

							html += "<li><input type='checkbox' checked name='memberId' class='inputCheck' value='"+groupList[i].KEY+"' /> <label for=''>"+groupList[i].CAPTION+"</label></li>";
						}			

						preType = groupList[i].ORDER_TYPE;						 					
/*
						<li>
						<div class="list">
							<p><input type="checkbox" id="" class="inputCheck" /> <label for="">한국환경공단 &gt; 상황팀</label></p>
							<ul class="person">
							<li><input type="checkbox" id="" class="inputCheck" /> <label for="">제갈공명</label></li>
							<li><input type="checkbox" id="" class="inputCheck" /> <label for="">제갈공</label></li>
							<li><input type="checkbox" id="" class="inputCheck" /> <label for="">제갈명</label></li>
							</ul>
						</div>
						<div class="list">
							<p><input type="checkbox" id="" class="inputCheck" /> <label for="">한국환경공단 &gt; 상황팀</label></p>
						</div>
					</li>	 
 
 */									     	
						//$('#groupDiv').append("<li><input type='checkbox' name='group' value='"+groupList[i].VALUE+"' /><label for=''>"+groupList[i].CAPTION+"</label></li>")
					}	

					html += "</ul></li></ul></li></ul>";		
					$('#groupDiv').append(html);

					$("#groupDiv").treeview({
						collapsed: false,
						animated: "medium",
						control:"#sidetreecontrol",
						persist: "location"
					});	

			     } else { 
			    	 alert("공구 목록 가져오기 실패");
			        return;
			     }
			});
					
		}			

		//동적 SELECTBOX 구현을 위한 사용자 함수
		(function($) {
		
		 //SELECT OPTION 삭제
		 $.fn.emptySelect2 = function() {
		     return this.each(function(){
		       if (this.tagName=='SELECT') this.options.length = 0;
		     });
		  }		  
			
		  //SELECT OPTION 등록
		  $.fn.loadSelect2 = function(optionsDataArray) {
		     return this.emptySelect2().each(function(){
		       if (this.tagName=='SELECT') {
		           var selectElement = this;
		           if(optionsDataArray.length == 0 || optionsDataArray.length == undefined) {
		               var first = new Option('전체', 'all');
						
						if ($.browser.msie) {
							selectElement.add(first);
						}
						else {
							selectElement.add(first);
						}			           
		           } else {
			           $.each(optionsDataArray,function(idx, optionData){
			               var option = new Option(optionData.CAPTION, optionData.VALUE);
	
			               var first = new Option('전체', 'all');
							
							if ($.browser.msie) {
								if(idx == 0) { selectElement.add(first);}
								selectElement.add(option);
							}
							else {
								if(idx == 0) { selectElement.add(first);}
								selectElement.add(option,null);
							}
			           });
		           }
		       }
		    });
		  }
		})(jQuery);						
	</script>		
</head>
<body class="pop_basic">
<div class="header">
	<h1>SMS전송</h1>
</div>
<div>
	<div id="container">
		<!-- content -->
		<div class="sub_waterpolmnt">
			<div class="content_wrap page_alarmmng">
				<div class="inner_alertSmsSend">
					<div class="roundBox roundBox2">
						<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
						<div class="con">
							<div class="con_r smsForm">
								<form name="smsForm" action="" onsubmit="return false;">
									<div class="sms_write">
										<h4 class="buSqu_tit">문자 입력</h4>
										<div class="sms_write_form">
											<p class="txt">
												<textarea id="smsMsg" name="smsMsg" rows="" cols="" class="textArea">${factName}-'날씨:${weatherName}' 조치바랍니다.</textarea>
											</p>
											<p class="byte"><span id="byteSpan">0</span> / 80 Byte</p>
										</div>
									</div>																	
									<div class="sms_target">
										<h4 class="buSqu_tit">대상자 선택</h4>
										<dl class="sms_target_form">
											<dt>유형 : </dt>
											<dd class="first_form">
												<input type="radio" class="inputRadio" id="system" name="system" value="T" checked="checked" /> <label for="" class="first_label">탁수 모니터링</label>
												<input type="radio" class="inputRadio" id="system" name="system" value="U" /> <label for="">이동형측정기기</label>
											</dd>
											<dt><label for="">장소 : </label></dt>
											<dd class="third_form">
												<select id="sugye" name="sugye">
												   <option value="all">전체</option>
												   <option value="R01">한강</option>
												   <option value="R02">낙동강</option>
												   <option value="R03">금강</option>
												   <option value="R04">영산강</option>
												</select>
												<span class="space">&gt;</span>
												<select id="factCode" name="factCode">
												</select>
												<span class="space">&gt;</span>
												<select id="branchNo" name="branchNo">
												</select>	
											</dd>											
											<dt><label for="">그룹 : </label></dt>												
											<dd class="second_form">
												<ul id="groupDiv">		
													<li>
														<div class="list">
															<p><input type="checkbox" id="" class="inputCheck" /> <label for="">한국환경공단 &gt; 상황팀</label></p>
															<ul class="person">
															<li><input type="checkbox" id="" class="inputCheck" /> <label for="">제갈공명</label></li>
															<li><input type="checkbox" id="" class="inputCheck" /> <label for="">제갈공</label></li>
															<li><input type="checkbox" id="" class="inputCheck" /> <label for="">제갈명</label></li>
															</ul>
														</div>
														<div class="list">
															<p><input type="checkbox" id="" class="inputCheck" /> <label for="">한국환경공단 &gt; 상황팀</label></p>
														</div>
													</li>																							
												</ul>												
											</dd>											
										</dl>
										<ul class="smsForm_btn">
											<li><input type="image" id="sendSmsBtn" src="<c:url value='/images/waterpolmnt/btn_send.gif'/>" alt="전송" /></li>
										</ul>
									</div>
								</form>
							</div>
						</div>
						<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
					</div>
				</div>
			</div>
		</div><!-- //content -->
	</div><!-- //container -->
</div>
</body>
</html>
