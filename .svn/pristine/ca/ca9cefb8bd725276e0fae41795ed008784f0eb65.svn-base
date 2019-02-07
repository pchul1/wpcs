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
<%-- 	</sec:authorize>  --%>
	<script type='text/javascript'>	 
		$(function () { 
			//초기화  
			page_init();
 
			var today 		= new Date();
			var curr_hour 	= today.getHours();
			var curr_min 	= today.getMinutes();  
			today = today.getFullYear()+ addzero(today.getMonth()+1) + addzero(today.getDate());  

			$('#receiptDate1').val(today);
			$('#receiptDate2').val(curr_hour);
			$('#receiptDate3').val(curr_min); 
			
			function addzero(n) {
				 return n < 10 ? "0" + n : n + "";
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
			
			$("#receiptDate1").datepicker({
			    buttonText: '접수일시'			    
			});

			//$("#spreadDate1").datepicker({
			//    buttonText: '상황전파일시'			    
			//});			

			if("${alertMngVO.sugye}" != "") {
				$('#sugye').attr("value","${alertMngVO.sugye}");
			} else {
				$('#sugye').attr("value","R01");
			}			
 
		  	$('#sugye').change(function(){
		   		adjustGongku();
		   	})	
			   	
			$('#factCode').change(function(){
				adjustBranchDropDown();
			});	
		  	$('#regKind').change(function(){ 
				var type= $("#regKind").val();
				if(type =="TYPE1"){ 
					$('#viewType1').show();
					$('#viewType2').hide();
				}else{
					applyClear();
					adjustGongku();
					set_User_deptNo(user_dept_no, "sugye");
					$('#viewType1').hide();
					$('#viewType2').show();
				}
		  	});
		  	$('#system').change(function(){
				adjustGongku();
			});

			$('#factCode').change(function(){
				adjustBranchDropDown();
			});

			$('#save').click(function(){
				save();
			});

			$('#spreadContent').keydown(function() {
				ChkByte(document.getElementById("spreadContent"), 80);
			}); 
			$('#receiptType').change(function(){
				//getTime();
			}); 


			$("#dept").change(function(){
				setPerson();
			});

			adjustGongku();
			setDept();
		});
		
		function page_init(){
			setDept();  
			//groupList();  
		}
		
		// 좌표 지정 팝업
		function lon_lat(){ 
			window.open("<c:url value='/addrMap.jsp'/>",'popupMap','resizable=yes,scrollbars=yes,width=960,height=800');
		}
		function applyClear(){
			$("#mapx").val("");   
			$("#mapy").val("");
			$("#address").val("");
		}
		// 좌표 및 주소 반영
		function applyLonLat(lon, lat, addr) {
			$("#mapx").val(lon);   
			$("#mapy").val(lat);
			$("#address").val(addr.replace('한국 ',''));
			$("#address").val(addr.replace('대한민국 ',''));
		}  
		function adjustGongku()
		{	
			var sugyeCd = $('#sugye').val();
			var system = $('#system').val();
			var dropDownSet = $('#factCode');
			if( sugyeCd == 'all' ){
				dropDownSet.attr("disabled", true);
				dropDownSet.emptySelect();
			}else{
				dropDownSet.attr("disabled", false);
				$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getGongkuList.do", {sugye:sugyeCd, system:system}, function (data, status){
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
			$("#receiptDate1").attr("value", $("#receiptDate1").val2());
			//$("#spreadDate").attr("value",$("#spreadDate1").val2() + addzero(Number($("#spreadDate2").val())) + addzero(Number($("#spreadDate3").val())));
			
			$("#receiptDate2").attr("value", addzero($("#receiptDate2").val()));
			$("#receiptDate3").attr("value", addzero($("#receiptDate3").val()));

			
			$("#regId").attr("value","admin");
			document.dataFrm.action = "<c:url value='/alert/alertRegProc.do'/>";
			document.dataFrm.submit();
		}	

		function validation(){

			var type= $("#regKind").val(); 
			if($("#receiptName").val() == "") {
				 alert("이름을 입력하여 주십시요."); 
				 $("#receiptName").focus();
				 return false; 
		 	}
			if($("#receiptTelNo1").val() == "") { alert("연락처를 입력하여 주십시요."); return false; }
			if($("#receiptTelNo2").val() == "") { alert("연락처를 입력하여 주십시요."); return false; }
			if($("#receiptTelNo3").val() == "") { alert("연락처를 입력하여 주십시요."); return false; }

			if($("#userKind").val() == "") { 
				alert("구분을 선택해 주십시요."); 
				$("#userKind").focus();
				return false; 
			} 
			
			if($("#receiptType").val() == "") { 
				alert("사고유형을 선택해 주십시요."); 
				$("#receiptType").focus();
				return false; 
			}]
			
			if($("#receiptDate1").val() == ""){
				 alert("접수일시를 입력하여 주십시요.");
				 $("#receiptDate1").focus(); 
				 return false; 
			}
			
			if($("#receiptDate2").val() == ""){
				 alert("접수일시 시간을 입력하여 주십시요."); 
				 $("#receiptDate2").focus(); 
				 return false; 
			}
			if($("#receiptDate3").val() == ""){ 
				alert("접수일시 분을 입력하여 주십시요."); 
				$("#receiptDate3").focus(); 
				return false; 
			}	
			if(type =="TYPE1"){
				if($("#address").val() == "") {
					 alert("좌표를 선택해  주십시요."); 
					 lon_lat();
					 return false; 
				}	
			}  
			if($("#smsMsg").val() == "") { alert("SMS을 생성해  주십시요."); return false; }
			var member = new Array;
			
			var cnt = 0;
			$("#sPerson option").each(function() {
				member.push($(this).val());
				cnt++
			});	 
			$("#memberId").val(member);

			if(cnt == 0) {
				alert("대상자를 선택하여 주십시요.");
				return;
			}
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
		
		function groupList()
		{
			/*
			var dropDownSet = $('#group'); 
			var html = "";
			$('#groupDiv').html(""); 
			dropDownSet.attr("disabled", false);
			$.getJSON(ROOT_PATH+"alert/getGroupList.do", {system:'T', sugye:'all', factCode:'null', branchNo:'null'}, function (data, status){
			     if(status == 'success'){
			    	html += "<div id='sidetreecontrol'><a href='?#'>전체닫기</a> | <a href='?#'>전체열기</a></div>";			    				    
					html += "<ul class='filetree'><li><p class='folder'><input type='checkbox' id='checkA' onclick='checkAll()' value='전체' /><label for=''>전체</label></p><ul>";
			    	
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
							
							html += "<p class='folder'><input type='checkbox' name='groupId' class='inputCheck' value='A"+groupList[i].KEY+"' onclick='chkMember(this, \"A"+groupList[i].KEY+"\")' /> <label for=''>"+groupList[i].CAPTION+"</label></p>";
							checkId = "A"+groupList[i].KEY;
							brChk++;
						} else {
							if(preType == "1") {
								html += "<ul id='"+checkId+"' class='person'>";
							}

							html += "<li><input type='checkbox' name='memberId' class='inputCheck' value='"+groupList[i].KEY+"' /> <label for=''>"+groupList[i].CAPTION+"</label></li>";
						}	 
						preType = groupList[i].ORDER_TYPE; 
					}	

					html += "</ul></li></ul></li></ul>";		
					$('#groupDiv').append(html);

					$("#groupDiv").treeview({
						collapsed: true,
						animated: "medium",
						control:"#sidetreecontrol",
						persist: "location"
					});										
					
					//alert($('#groupDiv').html());        
			     } else { 
			    	 alert("공구 목록 가져오기 실패");
			        return;
			     }
			});		
			*/
		}
		function checkAll(){			
			var c = $('#checkA').attr('checked');
			$('input[name=groupId]').attr('checked',c);
			$('input[name=memberId]').attr('checked',c);
		} 
		function getSmsMsg(){ 
			
			var type= $("#regKind").val(); 
			var receiptType  = $(":select[name=receiptType]>option:selected").text(); 
			var spreadDept   = $(":select[name=spreadDept]>option:selected").text(); 
			var receiptDate1 = $("#receiptDate1").val2() ;
			var itemCode	 = $(":select[name=itemCode]>option:selected").text(); 	
			var receiptDate2 = addzero(Number($("#receiptDate2").val()));
			var receiptDate3 = addzero(Number($("#receiptDate3").val()));
			//기타 사항 추가 내용
 			var selAdd = $('#selAdd').val();
			
			if($("#receiptType").val() == "") { 
				alert("유형을 선택해 주십시요."); 
				$("#receiptType").focus();
				return false; 
			}
			if($("#mngTitle").val() == ""){ 
				alert("제목을 입력하여 주십시요."); 
				$("#mngTitle").focus();
				return false; 
			}
			if($("#receiptDate1").val() == ""){
				 alert("접수일시를 입력하여 주십시요.");
				 $("#receiptDate1").focus(); 
				 return false; 
			}
			if($("#receiptDate2").val() == ""){
				 alert("접수일시 시간을 입력하여 주십시요."); 
				 $("#receiptDate2").focus(); 
				 return false; 
			}
			if($("#receiptDate3").val() == ""){ 
				alert("접수일시 분을 입력하여 주십시요."); 
				$("#receiptDate3").focus(); 
				return false; 
			}
			if(type =="TYPE1"){
				if($("#address").val() == "") { alert("좌표를 선택해  주십시요."); return false; } 
			}  
			var smsMsg 		 = ""; 
			var regdate 	 ="";
			var address		 ="";
			var addr_det = "";
			
			//(테스트)선박사고(사고)   12.888/12.88 10 08 07 03:22  ==>테스트 포맷 
			regdate = regdate + receiptDate1.substring(2, 4);//2010
			regdate = regdate + "/" + receiptDate1.substring(4, 6);
			regdate = regdate + "/" + receiptDate1.substring(6, 8)+" "+receiptDate2+":"+receiptDate3; 
 
			if(type =="TYPE1"){
				address=$("#address").val();
				addr_det = $("#addr_det").val();
				smsMsg += "["+receiptType+"]"; 
				smsMsg += "["+regdate + "]";
				smsMsg += "["+address.replace('대한민국','')+ " " + addr_det + "]"; 
			}else{ 
				if(!selAdd){
					smsMsg += "["+receiptType+"]"; 
				}else{
					smsMsg += "["+receiptType+"-"+selAdd+"]"; 
				}
				smsMsg += "["+regdate + "]";
				smsMsg += "["+$(":select[name=branchNo]>option:selected").text()+"]"; 
			} 
			$('#smsMsg').attr('value', smsMsg);
			 
		}	
		function chkMember(obj, target) {
			var c = $(obj).attr('checked');
			$("#"+target+" :input[name=memberId]").attr('checked',c);
		}
		function fileUploadPreview(thisObj, preViewer) {
            if(!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(thisObj.value)) {
                alert("이미지 형식의 파일을 선택하십시오");
                return;
            }

            preViewer = (typeof(preViewer) == "object") ? preViewer : document.getElementById(preViewer);
            var ua = window.navigator.userAgent;

            if (ua.indexOf("MSIE") > -1) {
                var img_path = "";
                if (thisObj.value.indexOf("\\fakepath\\") < 0) {
                    img_path = thisObj.value;
                } else {
                    thisObj.select();
                    var selectionRange = document.selection.createRange();
                    img_path = selectionRange.text.toString();
                    thisObj.blur();
                }
                preViewer.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='fi" + "le://" + img_path + "', sizingMethod='scale')";
            } else {
                preViewer.innerHTML = "";
                var W = preViewer.offsetWidth;
                var H = preViewer.offsetHeight;
                var tmpImage = document.createElement("img");
                preViewer.appendChild(tmpImage);

                tmpImage.onerror = function () {
                    return preViewer.innerHTML = "";
                }

                tmpImage.onload = function () {
                    if (this.width > W) {
                        this.height = this.height / (this.width / W);
                        this.width = W;
                    }
                    if (this.height > H) {
                        this.width = this.width / (this.height / H);
                        this.height = H;
                    }
                }
                if (ua.indexOf("Firefox/3") > -1) {
                    var picData = thisObj.files.item(0).getAsDataURL();
                    tmpImage.src = picData;
                } else {
                    tmpImage.src = "file://" + thisObj.value;
                }
            }
        } 			

		function setDept()
		{

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

		function setPerson()
		{
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


		function add()
		{
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

				if(!flag)
				{
					$("#sPerson").append(addOpt);
				}
				
			});
		}

		function del()
		{
			$("#sPerson option:selected").each(function(i){
				//$(this).appendTo('#person');
				$(this).remove();
			});	
		}
		function SelCheck(sel){
			var add = "<input type='text' id='selAdd' style='width:300px;'/>";
			if(sel==35){
				$('#SelAdd').html(add);
				$('#selAdd').focus();
			}else{
				$('#SelAdd').html("");
			}
		}
		function checkDate(date) {
			var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
			var survey_time = document.getElementById("survey_time");
			if(date !=''){
				if(dateCheck.test(date)!=true){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					return false;
				}
			}else{
				alert("날짜를 입력하여 주십시오.");			
			}
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
		<form:form commandName="alertMngVO" id="dataFrm"  action="/alert/alertRegProc.do" name="dataFrm" method="post" onsubmit="return false;" enctype="multipart/form-data" >
		<form:hidden path="mngId" />		
		<form:hidden path="receiptTelNo" />
		<form:hidden path="receiptDate" />
		<form:hidden path="spreadDate" />
		<form:hidden path="regId" /> 
		<input type="hidden" id="memberId" name="memberId"/>
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
											<th scope="row" rowspan="3">신고자 인적사항</th>
											<td class="tit">성명</td>  
											<td colspan="3">
												<form:input path="receiptName" cssClass="inputText style1" />
											</td>
										</tr>
										<tr>
											<td class="tit">연락처</td> 
											<td colspan="3">
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
												<form:input path="receiptTelNo2" onkeydown="onlyNumberInput()" cssClass="inputText style2" maxlength="4" />
												-
												<form:input path="receiptTelNo3" onkeydown="onlyNumberInput()" cssClass="inputText style2" maxlength="4" />
											</td>
										</tr> 
										<tr>
											<td class="tit">구분</td> 
											<td colspan="3">
												<form:select path="userKind" cssStyle="width:120px">
												<c:forEach items="${userKind}" var="userKind">
												<form:option value="${userKind.VALUE}" label="${userKind.CAPTION}" />
												</c:forEach>
												</form:select> 
											</td>
										</tr> 
									</tbody>
								</table>
							</fieldset>
							<fieldset class="first"> 
								<table class="dataTable">
									<colgroup>
										<col width="130px" />
										<col />
									</colgroup> 
									<tr>
										<th scope="row">접수일시</th>
										<td>
											<form:input path="receiptDate1" cssClass="inputText style1"  cssStyle="width:80px" onchange="checkDate(this.value)"/>
											<form:input path="receiptDate2" cssClass="inputText style2"  cssStyle="width:40px" onkeydown="onlyNumberInput()" maxlength="2" />
											시
											<form:input path="receiptDate3" cssClass="inputText style2"  cssStyle="width:40px" onkeydown="onlyNumberInput()" maxlength="2" />
											분
										</td>
									</tr>
									<tr>
										<th scope="row">신고형태</th>
										<td class="textArea1">
										<select style="width:120px"  id="itemType" name="itemType">
										<option value="TYPE1">육안관찰</option> 
										<option value="TYPE2">현장측정</option> 
										</select> 					
										</td>										
									</tr>	
									<tr>
										<th scope="row">사고 유형</th>
										<td>
											 <form:select path="receiptType" cssStyle="width:120px" onchange="javascript:SelCheck(this.value);">											
												<form:option value="">선택</form:option>
												<c:forEach items="${codes}" var="codes">
													<form:option value="${codes.VALUE}" label="${codes.CAPTION}" />
												</c:forEach>												
											</form:select>
											<div id="SelAdd"></div>	
										</td>
									</tr> 
									<tr>
										<th scope="row">사고 지점 유형</th>
										<td>
											<select style="width:120px"  id="regKind" name="regKind">
												<option value="TYPE2">측정지정</option> 
												<option value="TYPE1">임의지정</option>
											</select> 	
										</td>
									</tr> 
									<tr>
										<th scope="row">사고 위치</th>
										<td>
										
										<div id="viewType1" style="width:700px;display:none;"">
											 <form:hidden path="mapx"/> 
											 <form:hidden path="mapy"/> 
											<ul class="place">
		                                        <li>
		                                       			 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								                                          수계  : 
								                         <select style="width:120px;"  id="sugye2" name="sugye2">
																<option value="R01">한강</option>
															   <option value="R02">낙동강</option>
															   <option value="R03">금강</option>
															   <option value="R04">영산강</option>
														</select>
		                                                <img src="<c:url value='/images/common/ico4.gif'/>" alt="지도" onclick="lon_lat();" style="cursor:pointer" />
		                                        </li>
												<li>
			                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			 				                                       주소 : <form:input path="address" cssClass="inputText" cssStyle="width:425px" readonly="true" />
		                                        </li>
		                                        <li>
													나머지 주소 : <form:input path="addr_det" cssClass="inputText" cssStyle="width:425px"/>
		                                        </li>
	                                        </ul>
										</div>
										
										<div id="viewType2" style="width:800px;">
											<div class="search_all_wrap3">
											   <div class="btnInBox" style="width:800px;">
												<dl>
													<dt>시스템</dt>
													<dd>
														<select style="width:120px;"   id="system" name="system">
																<option value="U" selected="selected">이동형측정기기</option>
																<!-- <option value="T">탁수모니터링</option> -->
																<option value="A">국가수질자동측정망</option>
														</select>
													</dd>
													<dt>측정소</dt>
													<dd>
														<select style="width:80px;"   id="sugye" name="sugye">
														   <option value="R01">한강</option>
														   <option value="R02">낙동강</option>
														   <option value="R03">금강</option>
														   <option value="R04">영산강</option>
														</select>
														<span>&gt;</span>
															<select style="width:100px;"  id="factCode" name="factCode">
																<option value="all">전체</option>
															</select>
														<span>&gt;</span>
														<select style="width:120px;"  id="branchNo" name="branchNo">
															<option value="all">전체</option>
														</select>
													</dd>
												</dl>
	                                             </div>
											</div>
										</div>
										</td> 									
									</tr>  
									<tr>
										<th scope="row">SMS</th>
										<td>
											<input type="text" class="inputText" id="smsMsg" name="smsMsg" style="width:450px" readonly="true"/> <img src="<c:url value='/images/common/ico2.gif'/>" alt="SMS생성" style="cursor:pointer"  onclick="getSmsMsg();"/>
										</td>									
									</tr>
										<tr>
										<th scope="row">상황접수내용</th> 
										<td class="textArea5">
										<div class="group_left">
										 	<div id="preView" class="preView3" title="이미지미리보기"></div>
											<ul class="place">
		                                        <li>
		                                       			 &nbsp;&nbsp;&nbsp; 
								                                          사고내용  : 
								                          <form:textarea path="alertContents"/>
		                                        </li>
												<li>
			                                        &nbsp;&nbsp;&nbsp; 
			 				                                       사고사진 : 
			 				                        <input align="top" id="fileData" name="fileData" type="file"   style="width:507px" onchange="fileUploadPreview(this, 'preView')" /></p>
		                                        </li>
	                                        </ul>
										</div>
										</td> 
									</tr>
									<tr style="display:none">
										<th scope="row">기타</th>
										<td class="textArea2">
										<form:input path="alertEtc" cssClass="inputText style1" cssStyle="width:500px"/>
										</td>
									</tr>
									<tr>
										<th scope="row">전파대상</th>   
								        <!--width:스크롤박스의 너비, height:스크롤박스의높이//-->
								        <td valign="top" style="padding-top;0px">
								       <div class="inner_alertSmsSend2" style="padding-top:0px;width:700px;">
										   <div class="smsForm">											
											<div class="sms_target" >
												<dl class="sms_target_form">	
													<dd class="second_form">
														<div class="groupSelector">
									                        <!-- 그룹선택-->
									                        <div class="groupBg2">
									                        <div class="groupTit2">대상기관</div>
									                        
									                        <select class="selectMultiple2" multiple="multiple" id="dept">
									                         </select>
									                         
									                        </div>
									                        <div class="groupBtn">
									                        <img src="<c:url value='/images/common/arrow_yellow.gif'/>" alt="다음단계" />
									                        </div>
									                        <div class="groupBg">
									                        <div class="groupTit">담당자</div>
									                        
									                        <select class="selectMultiple" multiple="multiple" id="person">
									                        </select>
									                        
									                        
									                        </div>
									                        <div class="groupBtn2">
									                        <a href="javascript:add()"><img src="<c:url value='/images/common/btn_getIns.gif'/>" alt="추가" /></a>
									                        <br />&nbsp;<br />
									                        <a href="javascript:del()"><img src="<c:url value='/images/common/btn_getDel.gif'/>" alt="삭제" /></a>
									                        </div>
									                        <div class="groupBg">
									                        <div class="groupTit">전파대상자</div>
									                        <select class="selectMultiple" multiple="multiple" id="sPerson">
									                        </select>
									                        </div>
									                        <!--// 그룹선택-->
									            		</div>									
													</dd>										
												</dl>
											</div>
										</div>
									</div>
								         </td>					
									</tr>  
								</table>
							</fieldset>
							<ul class="btnMenu">
								<li><input id="save" type="image" src="<c:url value='/images/common/btn_regist.gif'/>" alt="등록" /></li>								
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

