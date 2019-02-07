<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<% pageContext.setAttribute("newLineChar", "\n"); %>
<%pageContext.setAttribute("crlf", "\r\n");%> 
<%
	/**
	 * Class Name  : checkUseDetail.jsp
	 * Description : 점검및사용일지 상세화면
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
		//fnBringUpApprovalYn();		//결재상신 가능 여부 체크 하기(오전, 오후, 야간 다 입력 됐을 경우에만 결재 상신 가능)
	});
	
	function fnDelete(){
		if(confirm("삭제 하시겠습니까?")){
			document.registform.action = "<c:url value='/dailywork/checkUseInfoDelete.do'/>";
			document.registform.submit();
		}
	}
	
	function fnModify(modifyGubun){
		
		if(confirm("수정 하시겠습니까?")){
			$('#modifyGubun').val(modifyGubun);	
			document.registform.action = "<c:url value='/dailywork/checkUseModify.do'/>";
			document.registform.submit();
		}
	}
	function fnCancel(){
		
		if(confirm("점검일지를 회수하시겠습니까?")){
			document.registform.action = "<c:url value='/dailywork/checkUseInfoCancel.do'/>";
			document.registform.submit();
		}
	}
	function fnList(){
		var menuGubun = $('#menuGubun').val();
		
		if(menuGubun=='app'){
			document.registform.action = "<c:url value='/dailywork/receiveApprovalList.do'/>";
		}else{
			document.registform.action = "<c:url value='/dailywork/checkUseList.do'/>";			
		}
		document.registform.submit();
	}
	
	function fnPrint(printGubun) {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 700;
		var winWidth = 800;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		var param = "checkUseId=${checkUseVO.checkUseId}&printGubun="+printGubun;
	
		window.open("<c:url value='/dailywork/dailyWorkPrintView_popup.do'/>?"+encodeURI(param),
		'dailyWorkPrintView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function fnApp(appGubun){
		var checkUseId = $('#checkUseId').val();
		var workDay = $('#workDay').val();
		var seq = $('#approvalSeq').val();
		var msg = "";
		
		if(appGubun=='return'){
			msg = "반려"; 
		}else{
			msg = "결재"; 
		}
		if(confirm(msg+" 하시겠습니까?")){
			$('#checkDailyWorkId').val(checkUseId+";"+seq+";"+workDay);
			$('#appGubun').val(appGubun);
			
			if(appGubun=='return'){
				document.registform.action = "<c:url value='/dailywork/approvalReturnProc.do'/>"; 
			}else{
				document.registform.action = "<c:url value='/dailywork/approvalProc.do'/>"; 
			}
			document.registform.submit();
		}
	}
	
	function fnSave(){
		if(confirm("결재상신하시겠습니까?")){
			document.registform.action = "<c:url value='/dailywork/insertDailyWorkApproval.do'/>";
			document.registform.submit();
		}
	}
	
	/* function fnBringUpApprovalYn(){
		var mId = "${situationRoomVO.mId}";
		var mContent = "${fn:replace(situationRoomVO.mContent,crlf,'<BR/>')}";
		var aId = "${situationRoomVO.aId}";
		var aContent = "${fn:replace(situationRoomVO.aContent,crlf,'<BR/>')}";
		var nId = "${situationRoomVO.nId}";
		var nContent = "${fn:replace(situationRoomVO.nContent,crlf,'<BR/>')}";
		
		// 수정 20161122 mContent mId 한개만 작성되도 결재상신 가능하도록 변경
		// if(mId !="" && mContent !="" && aId !=""&& aContent !=""&& nId !=""&& nContent !=""){
		if(mId !="" && mContent !=""){
			$("#btnApp").show();
		}else{
			$("#btnApp").hide();
		}
	} */
	
	function fnHisList(){
		layerPopCloseAll();
		
		var checkUseId = $('#checkUseId').val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/dailywork/getDailyWorkHisInfoList.do'/>",
			data:{dailyWorkId:checkUseId
				},
			dataType:"json",
			success:function(result){
				var tot = result['hisInfoList'].length;
				var item = "";
				if(tot>0){
					for(var i=0; i< tot; i++){
						var obj = result['hisInfoList'][i];
						
						item += "<tr>"
							+"<td style='text-align:center;width:120px;'>"+obj.regName+"</td>"
							+"<td style='text-align:center;width:150px;'>"+obj.regDate+"</td>"
							+"</tr>";
					}
					$("#hisInfo").html(item);
				}else{
					$("#hisInfo").html("<tr><td  colspan='2' style='text-align:center;width:150px;'>수정이력이 없습니다.</td></tr>");
				}
			},
	        error:function(result){
					$("#hisInfo").html("<tr><td colspan='2' style='text-align:center'>서버접속 실패</td></tr>");
		        }
		});
		
		layerPopOpen('layerDailyWorkHis');
	}
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerDailyWorkHis");
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
						<span style="text-align:center;"><u><b><h1>궤도형운반차량/4륜오토바이/전동지게차 (점검·사용) 일지</h1></b></u></span>
					</div>
					<div style="float:right; ">
						<table style="width:420px;">
							<colgroup>
							<col width="30px" />
							<col width="120px" />
							<col width="30px" />
							<col width="120px" />
							<col width="120px" />
							</colgroup>
							<tr>
								<th rowspan="3"  style="height:120px;">기<br/>안<br/>자</th>
								<td style="height:20px;"><b><c:out value="${approvalList[0].approvalName}"></c:out></b></td>
								<th rowspan="3"  style="height:120px;">결<br/><br/>재</th>
								<td style="height:20px;"><b><c:out value="${approvalList[1].approvalName}"></c:out></b></td>
								<td><b><c:out value="${approvalList[2].approvalName}"></c:out></b></td>
							</tr>
							<tr>
								<td style="height:80px;">
								<c:if test="${not empty approvalList[0].signature_file}">
									<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${approvalList[0].signature_file}" />
									</c:import>
								</c:if>
								</td>
								<td style="height:80px;">
								<c:if test="${not empty approvalList[1].signature_file}">
									<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${approvalList[1].signature_file}" />
									</c:import>
								</c:if>
								</td>
								<td>
								<c:if test="${not empty approvalList[2].signature_file}">
									<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${approvalList[2].signature_file}" />
									</c:import>
								</c:if>
								</td>
							</tr>
							<%-- <tr>
								<td style="height:20px;"><c:out value="${checkUseVO.regDate}"></c:out></td>
								<td><c:out value="${approvalList[1].approvalDate}"></c:out></td>
								<td><c:out value="${approvalList[2].approvalDate}"></c:out></td>
							</tr> --%>
						</table>
					</div>	
					<!--tab Contnet Start-->
					<div class="tab_container2">
						<div class="table_wrapper">
							<form name="registform" method="post" onsubmit="return false;">
								<input type="hidden" id="checkUseId" name="checkUseId" value="<c:out value="${checkUseVO.checkUseId}"/>"/>
								<input type="hidden" id="dailyWorkId" name="dailyWorkId" value="<c:out value="${checkUseVO.checkUseId}"/>"/>
								<input type="hidden" id="menuGubun" name="menuGubun" value="<c:out value="${menuGubun}"/>"/>
								<input type="hidden" id="checkDailyWorkId" name="checkDailyWorkId" />
								<input type="hidden" id="workDay" name="workDay"  value="<c:out value="${checkUseVO.workDay}"/>"/>
								<input type="hidden" id="approvalSeq" name="approvalSeq"  value="<c:out value="${seq}"/>"/>
								<input type="hidden" id="appGubun" name="appGubun"/>
								<input type="hidden" id="modifyGubun" name="modifyGubun" />
 								<input type="hidden" id="gubun" name="gubun" value="${param.gubun }"/> 
 								<input type="hidden" id="pageIndex" name="pageIndex" value="${pageNo}"/>  
								
								<span style="float:left"><b>일자</b> : <c:out value="${checkUseVO.workDay}"></c:out></span>
								<span style="padding-left:30px;float:left"><b>날씨</b> : <c:out value="${checkUseVO.weather}"></c:out></span>
								<br />
								<div style="text-align:left;">
									<span><b></b></span> 
								</div>
								<br />
							<c:if test="${not empty checkUseVO.equipCode1 }">
							<span style="float:left;">
								<b>차량명</b> : 
								${checkUseVO.equipCode1 }
							</span>
							</c:if>
							<div style="text-align:left;">
								<span><b></b></span>
							</div>
							<br />
							<span id="spanPurpose" style="float:left">
								<b>목 적</b> : 
								${checkUseVO.purposeName }
							</span>
							<c:if test="${checkUseVO.purpose ne 'P1' }">
							<div style="text-align:left;">
								<span><b></b></span> 
							</div>
							<br />
							<span id="spanUsePurpose" style="float:left;padding-left:50px;">
								<b>사용목적</b> : 
								${checkUseVO.usePurposeName }
							</span>
							<span id="spanUsePlace" style="padding-left:30px;float:left"><b>사용처</b> : ${checkUseVO.usePlace }</span>
							<br/>
							<span id="spanUseFuelInject" style="float:left;">
								<b>연료주입</b> : ${checkUseVO.fuelInject }
							</span>
							</c:if>
							<br/>
							<br/>
							<div style="text-align:left;">
								<span><b>점검 현황</b></span> 
							</div>
							<div>
								<table id="accidentTable">
									<colgroup>
										<col width="100px" />
										<col width="200px" />
										<col width="100px" />
										<col />
										<!-- <col width="100px"/> -->
									</colgroup>
									<tr>
										<th>구분</th>
										<th>점검분야</th>
										<th>결과</th>
										<th>비고</th>
										<!-- <th>사진</th> -->
									</tr>
									<c:set var="gubunCode" value=""/>
									<c:forEach items="${checkList }" var="list">
									<tr>
										<c:if test="${gubunCode ne list.gubunCode }">
										<td rowspan="${list.rowspan }">${list.gubunName }<br/>(${list.equipName })</td>
										</c:if>
										<c:set var="gubunCode" value="${list.gubunCode }"/>
										<td style="text-align:left;padding-left:5px;">${list.checkCode }</td>
										<td style="text-align:left;padding-left:10px;">${list.checkResult }</td>
										<td style="text-align:left;padding-left:10px;">${list.note }</td>
										<!-- <td>${list.photoId }</td> -->
									</tr>
									</c:forEach>
								</table>
							</div>
							<br />
							<div style="text-align:left;">
								<span><b>특이사항</b></span>
								<br/>
								<textarea name="issueComment" id="issueComment" rows="3" style="width:98%;" readonly="readonly">${checkUseVO.issueComment }</textarea> 
							</div>
							<br />
							<span style="float:left"><b>인 원</b> : ${checkUseVO.persons } 명</span>
							<span style="padding-left:30px;float:left"><b>참여자</b> : ${checkUseVO.participant }</span>
							<br/>
							<div style="text-align:left;">
								<span><b></b></span> 
							</div>
							<br />
							<div style="text-align:left;">
								<span><b>사진대지</b></span>
								<br/>
								<c:if test="${not empty checkUseVO.photo1Id}">
									<c:import url="/cmmn/selectCheckUseImageFile.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${checkUseVO.photo1Id}" />
									</c:import>
								</c:if>
								<c:if test="${not empty checkUseVO.photo2Id}">
									<c:import url="/cmmn/selectCheckUseImageFile.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${checkUseVO.photo2Id}" />
									</c:import>
								</c:if>
								<c:if test="${not empty checkUseVO.photo3Id}">
									<c:import url="/cmmn/selectCheckUseImageFile.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${checkUseVO.photo3Id}" />
									</c:import>
								</c:if>
							</div>
							<br/>
							<div style="text-align:left;">
								<span><b>설 명</b></span>
								<br/>
								<textarea name="exprComment" id="exprComment" rows="3" style="width:98%;" readonly="readonly">${checkUseVO.exprComment }</textarea> 
							</div>
							</form>
							<br />
							<div>
								<%-- <c:if test="${checkUseVO.state == 'F'}"> --%>
									<input type="button" id="btnPrint" value="인쇄" class="btn btn_basic" style="float:right" alt="인쇄" onclick="javascript:fnPrint('D');"/>
								<%-- </c:if> --%>
								<c:if test="${menuGubun == 'dailyWork'}">
									<c:if test="${checkUseVO.state == 'S' or checkUseVO.state == 'R'}">
									<input type="button" id="btnDelete" value="삭제" class="btn btn_basic" style="float:right" alt="삭제" onclick="javascript:fnDelete();"/>
									<input type="button" id="btnApp" value="결재상신" class="btn btn_basic" style="float:right" alt="결재상신" onclick="javascript:fnSave('app');"/>
									<input type="button" id="btnMod" value="수정" class="btn btn_basic" style="float:right" alt="수정" onclick="javascript:fnModify('m');"/>
									</c:if>
									<c:if test="${checkUseVO.state == 'B' or checkUseVO.state == 'A' or checkUseVO.state == 'R' or checkUseVO.state == 'F'}">
									<input type="button" id="btnCncl" value="회수" class="btn btn_basic" style="float:right" alt="회수" onclick="javascript:fnCancel();"/>
									</c:if>
									<input type="button" id="btnList" value="수정이력" class="btn btn_basic" style="float:right" alt="수정이력" onclick="javascript:fnHisList();"/>
									<input type="button" id="btnList" value="목록" class="btn btn_basic" style="float:right" alt="목록" onclick="javascript:fnList();"/>
								</c:if>
								<c:if test="${menuGubun == 'app'}">
									<c:if test="${appCheck=='Y'}">
									<input type="button" id="btnReturn" value="반려" class="btn btn_basic" style="float:right" alt="반려" onclick="javascript:fnApp('return');"/>
									<input type="button" id="btnApp" value="결재" class="btn btn_basic" style="float:right" alt="결재" onclick="javascript:fnApp('app');"/>
									<input type="button" id="btnMod" value="수정" class="btn btn_basic" style="float:right" alt="수정" onclick="javascript:fnModify('a');"/>
									</c:if>
							    	<input type="button" id="btnList" value="목록" class="btn btn_basic" style="float:right" alt="목록" onclick="javascript:fnList();"/>
								</c:if>
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
	<div id="layerDailyWorkHis" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnBranRegXbox" name="btnBranRegXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerDailyWorkHis');" alt="닫기"/>
		</div>
		<table summary="수정이력정보">
			<caption>수정이력정보</caption>
			<colgroup>
				<col width="120px" />
				<col width="150px" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th>수정자</th>
					<th>수정일</th>
				</tr>
				<tbody id="hisInfo"></tbody>
			</tbody>
		</table>
	</div>
</body>
</html>