<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
  /**
  * @Class Name : sectionSpeed.jsp
  * @Description : Section Speed 화면
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
<%-- 	</sec:authorize>				 --%>
	<script>
		var isProcess = false;
		
		$(function () {
			$('#search').click(function () {
				if(isProcess) {
					alert("처리중입니다.");
					return; 
				}			
				isProcess = true;					
				search_section_data();
			});		

			$('#save').click(function () {
				if(isProcess) {
					alert("처리중입니다.");
					return; 
				}			
				if(!validation()) { return; }
				isProcess = true;					
				setSave();
			});

			$('#checkAll').click(function () {
				checkAll();
			});					

			$('#addRow').click(function () {
				if($('input[name=s_sectionId]:checked').val() != undefined && $('input[name=s_sectionId]:checked').val() != null &&  $('input[name=s_sectionId]:checked').val() != "") {				
					setRow(null, $('input[name=s_sectionId]:checked').val(), null, null);
				} else {
					alert("등속 구간을 선택하세요");
				}
			});

			$('#delRow').click(function () {
				setDel();
			});			
		
			$('#eLatitude').keydown(function () {
				onlyNumberInput();
			});		
			
			$('#sLongtitude').keydown(function () {
				onlyNumberInput();
			});		
		});

		function setSave() {
			var i = 0;
            var flowId = new Array();
            var sectionId = new Array();
            var flow = new Array();
            var endTime = new Array();    
							
			$('input[name=chk]').each(function() {
				flowId.push($('input[name=flowId]').eq(i).val());
				sectionId.push($('input[name=sectionId]').eq(i).val());
				flow.push($('input[name=flow]').eq(i).val());
				endTime.push($('input[name=endTime]').eq(i).val());
				i++;
			});			

			save_data(flowId, sectionId, flow, endTime);	
		}	

		function setDel() {
			var i=0;
			var cnt = 0;
			var flowArr = new Array;
			var delRowIdx = new Array;

			$('input[name=chk]').each(function() {
				if($(this).attr('checked')) {
					delRowIdx.push(i);
					cnt++;
				}
				i++;
			});

			if(cnt == 0) {
				alert("삭제할 항목을 체크해주세요");
				isProcess = false;
				return false;					
			}			

			for(var i=delRowIdx.length; i>0; i--) {
				flowArr.push($('input[name=flowId]').eq(delRowIdx[i-1]).val());			
			}			

			del_sectionSpeed_data(flowArr, delRowIdx);							
		}	

		function save_data(flowId, sectionId, flow, endTime){			
			$.ajax({
				type:"post",
				url:"<c:url value='/operate/updateSectionSpeed.do'/>",
				data:{flowId:flowId, sectionId:sectionId, flow:flow, endTime:endTime},
				dataType:"json",
				success:function(result){
					alert("저장했습니다.");
					search_sectionSpeed_data($('input[name=s_sectionId]:checked').val());
					isProcess = false;
				},
	            error:function(result){alert("error");isProcess = false;}
			});			
		}	

		function search_section_data(){
			
			var riverId = $("#riverId").val();	

			$.ajax({
				type:"post",
				url:"<c:url value='/operate/getSectionList.do'/>",
				data:{riverId:riverId},
				dataType:"json",
				success:function(result){
	                var tot = result['sectionList'].length;

	                var item;
	                var sectionId;
	                var orderNum;
	                var riverName = $(":select[name=riverId] > option:selected").text();
	                var startSectionName;
	                var endSectionName;                

	                item = "";

	                $("#sectionBody").html("");

	                if( tot <= "0" ){
						alert("조회 결과가 없습니다.");
	                } else {	                
		                for(var j=0; j < tot; j++){
		                    var obj = result['sectionList'][j];
							
		                    sectionId = obj.sectionId;
		                    orderNum = obj.orderNum;
		                    startSectionName = obj.startSectionName;
		                    endSectionName = obj.endSectionName;  
		                
		    				item = "<tr>"
		    					 + "<td>"
		    					 + "<input type=\"radio\" class=\"inputRadio\" name=\"s_sectionId\" value=\""+sectionId+"\" onclick=\"selectSection()\" />"
		    					 + "<input type=\"hidden\" name=\"s_sectionName\" value=\""+startSectionName+"-"+endSectionName+"\" />"
		    					 + "</td>"	    					 
		    					 + "<td>"+orderNum+"</td>"
		    					 + "<td>"+riverName+"</td>"
		    					 + "<td>"+startSectionName+"-"+endSectionName+"</td>"
		    					 + "</tr>"; 
	
		       				$("#sectionBody").append(item);
		                    item = "";
		                }
	                }
	                isProcess = false;
				},
	            error:function(result){alert("error");isProcess = false;}
			});
		}    	

		function search_sectionSpeed_data(sectionId){

			$.ajax({
				type:"post",
				url:"<c:url value='/operate/getSectionSpeedList.do'/>",
				data:{sectionId:sectionId},
				dataType:"json",
				success:function(result){
	                var tot = result['sectionSpeedList'].length;

	                var flowId;
	                var sectionId;
	                var flow;
	                var endTime;

	                $("#sectionSpeedBody").html("");

	                if( tot <= "0" ){
						alert("조회 결과가 없습니다.");
	                } else {	                
		                for(var j=0; j < tot; j++){
		                    var obj = result['sectionSpeedList'][j];
							
		                    flowId = obj.flowId;
		                    sectionId = obj.sectionId;
		                    flow = obj.flow;
		                    endTime = obj.endTime;  
		                
		                    setRow(flowId, sectionId, flow, endTime);
		                }
	                }
	                isProcess = false;
				},
	            error:function(result){alert("error");isProcess = false;}
			});
		}    	

		function del_sectionSpeed_data(flowArr, delRowIdx){
			$.ajax({
				type:"post",
				url:"<c:url value='/operate/deleteSectionSpeed.do'/>",
				data:{flowArr:flowArr},
				dataType:"json",
				success:function(result){				
					for(var i=delRowIdx.length; i>0; i--) {
						$('input[name=flowId]').eq(delRowIdx[i-1]).parent().parent().remove();		
					}							
					alert("삭제했습니다.");
					isProcess = false;
				},
	            error:function(result){alert("error");isProcess = false;}
			});			
		}				

		function selectSection() {
			var i=0;
			var sectionId = $('input[name=s_sectionId]:checked').val();
			search_sectionSpeed_data(sectionId);			
		}		

		function setRow(flowId, sectionId, flow, endTime) {
			flowId 			= nullToString(flowId);			
			sectionId 		= nullToString(sectionId);			
			flow 			= nullToString(flow);			
			endTime 		= nullToString(endTime);			

			$('<tr></tr>')
				.append($('<td></td>')
							.append($('<input />').attr('name', 'chk').attr('type', 'checkbox').addClass('inputCheck').attr('style','width:30px'))
							.append($('<input />').attr('name', 'flowId').attr('type', 'hidden').attr('value', flowId))
							.append($('<input />').attr('name', 'sectionId').attr('type', 'hidden').attr('value', sectionId)))										
				.append($('<td></td>')
							.append($('<input />').attr('name', 'flow').attr('type', 'text').attr('value', flow).addClass('inputText')))							
				.append($('<td></td>')
							.append($('<input />').attr('name', 'endTime').attr('type', 'text').attr('value', endTime).addClass('inputText')))
				.appendTo("#sectionSpeedBody");
		}		

		function checkAll(){
			var c = $('#checkAll').attr('checked');
			$('input[name=chk]').attr('checked',c);
		}			

		function validation() {
			var i = 0;
			var cnt1 = 0;
			var cnt2 = 0;

			$('input[name=chk]').each(function() {
				if($('input[name=flow]').eq(i).val() == "") { cnt1++; }
				if($('input[name=endTime]').eq(i).val() == "") { cnt2++; }				
				i++;
			});			

			if(cnt1 > 0) {
				alert("유량을 입력하여 주십시요.");
				return false;
			}
			if(cnt2 > 0) {
				alert("도달시간을 입력하여 주십시요.");
				return false;
			}			
			return true;							
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
		<div id="content" class="sub_situationmng">
			<div class="content_wrap page_opermng">
				<div class="inner_fluxmng">
					<div class="forms_gis">
						<!-- 유량 등록 -->
						<form action="" class="formBox1" onsubmit="return false;">						
							<fieldset>
								<legend class="hidden_phrase">유량 등록(수정) 폼</legend>
								<h4>유량 등록(수정)</h4>
								<div class="overBox">
									<table class="dataTable">
										<colgroup>
											<col width="30px" />
											<col />
											<col />
										</colgroup>									
										<thead>
											<tr>
												<th scope="col"><input type="checkbox" class="inputCheck" id="checkAll" /></th>
												<th scope="col">유량</th>
												<th scope="col">도달시간</th>
											</tr>
										</thead>
										<tbody id="sectionSpeedBody"></tbody>
									</table>
								</div>
								<ul class="btn">
									<li><input id="addRow" type="image"  src="<c:url value='/images/common/btn_new.gif'/>" alt="신규" /></li>
									<li><input id="delRow" type="image" src="<c:url value='/images/common/btn_del.gif'/>" alt="삭제" /></li>
									<li><input id="save" type="image" src="<c:url value='/images/common/btn_save.gif'/>" alt="저장" /></li>
								</ul>
							</fieldset>
						</form>
						<!-- //유량 등록 -->
						<!-- 유량 검색, 현황 -->
						<div class="form_overBox">
							<form action="" class="formBox2" onsubmit="return false;">
								<fieldset>
									<legend class="hidden_phrase">유량 검색 폼</legend>
									<p>
										<select id="riverId" name="riverId">
											<option value="01">한강</option>
											<option value="02">낙동강</option>
											<option value="03">금강</option>
											<option value="04">영산강</option>
										</select>
										<input id="search" type="image" src="<c:url value='/images/common/btn_search3.gif'/>" alt="검색" />
									</p>
								</fieldset>
							</form>
							<form action="" onsubmit="return false;">						
								<fieldset>
									<legend class="hidden_phrase">유량 도달 시간 현황</legend>
										<div class="overBox">
											<table class="dataTable">
												<colgroup>
													<col width="110px" />
													<col width="110px" />
													<col width="130px" />
													<col />
												</colgroup>
												<thead>
													<tr>
														<th scope="col">선택</th>
														<th scope="col">순서</th>
														<th scope="col">수계</th>
														<th scope="col">등속 구간</th>
													</tr>
												</thead>
												<tbody id="sectionBody"></tbody>
											</table>
										</div>
								</fieldset>
							</form>
						</div>
						<!-- //유량 검색, 현황 -->
					</div>
				</div>
			</div>
		</div><!-- //content -->

	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>
