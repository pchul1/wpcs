<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<%
	/**
	 * Class Name  : riverMainDetail.jsp
	 * Description : 4대강 주요 수계일지 상세 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.10.10	kyr		최초 생성
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
	
	$(document).ready(function() {
		//alert($('#workstate').val());
	});
	
	function fnList(){
		var menuGubun = $('#menuGubun').val();
		
		if(menuGubun=='app'){
			document.registform.action = "<c:url value='/dailywork/receiveApprovalList.do'/>";
		}else{
			document.registform.action = "<c:url value='/dailywork/dailyWorkList.do?gubun=R'/>";			
		}
		document.registform.submit();
	}
	
	function fnDelete(){
		if(confirm("삭제 하시겠습니까?")){
			document.registform.action = "<c:url value='/dailywork/dailyWorkInfoDelete.do?gubun=R'/>";
			document.registform.submit();
		}
	}
	
	function fnModify(modifyGubun){
		if(confirm("수정 하시겠습니까?")){
			$('#modifyGubun').val(modifyGubun);	
			document.registform.action = "<c:url value='/dailywork/riverMainModify.do'/>";
			document.registform.submit();
		}
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
		
		var param = "dailyWorkId=${dailyWorkVO.dailyWorkId}&printGubun="+printGubun;
	
		window.open("<c:url value='/dailywork/dailyWorkPrintView_popup.do'/>?"+encodeURI(param),
		'dailyWorkPrintView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function fnApp(appGubun){
		var dailyWorkId = $('#dailyWorkId').val();
		var workDay = $('#workDay').val();
		var seq = $('#approvalSeq').val();
		var msg = "";
		
		if(appGubun=='return'){
			msg = "반려"; 
		}else{
			msg = "결재"; 
		}
		if(confirm(msg+" 하시겠습니까?")){
			$('#checkDailyWorkId').val(dailyWorkId+";"+seq+";"+workDay);
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
			document.registform.action = "<c:url value='/dailywork/insertDailyWorkApproval.do?gubun=R'/>";
			document.registform.submit();
		}
	}
	
	function fnHisList(){
		layerPopCloseAll();
		
		var dailyWorkId = $('#dailyWorkId').val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/dailywork/getDailyWorkHisInfoList.do'/>",
			data:{dailyWorkId:dailyWorkId
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
						<span style="text-align:center;"><u><b><h1>'4대강 주요수계' 상시감시 결과 일일보고</h1></b></u></span>
					</div>
					<div style="float:right; ">
						<table style="width:430px;">
							<!-- 
							<colgroup>
							<col width="30px" />
							<col width="120px" />
							<col width="120px" />
							</colgroup>
							<tr>
								<th rowspan="3"  style="height:120px;">결<br/><br/>재</th>
								<td style="height:20px;"><b><c:out value="${approvalList[0].approvalName}"/></b></td>
								<td><b><c:out value="${approvalList[1].approvalName}"/></b></td>
							</tr>
							<tr>
								<td style="height:80px;">
								<c:if test="${not empty approvalList[0].signature_file}">
									<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${approvalList[0].signature_file}" />
									</c:import>
								</c:if>
								</td>
								<td>
								<c:if test="${not empty approvalList[1].signature_file}">
									<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${approvalList[1].signature_file}" />
									</c:import>
								</c:if>
								</td>
							</tr>
							<tr>
								<td style="height:20px;"><c:out value="${approvalList[0].approvalDate}"/></td>
								<td><c:out value="${approvalList[1].approvalDate}"/></td>
							</tr>
							  -->
							 
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
							<tr>
								<td style="height:20px;"><c:out value="${dailyWorkVO.regDate}"></c:out></td>
								<td><c:out value="${approvalList[0].approvalDate}"></c:out></td>
								<td><c:out value="${approvalList[1].approvalDate}"></c:out></td>
							</tr>
							 
						</table>
					</div>	
					<!--tab Contnet Start-->
					<div class="tab_container2">
						<div class="table_wrapper">
							<form name="registform" method="post" onsubmit="return false;">
								<input type="hidden" id="rId" name="rId" value="<c:out value="${riverMainVO.rId}"/>"/>
								<input type="hidden" id="dailyWorkId" name="dailyWorkId" value="<c:out value="${dailyWorkVO.dailyWorkId}"/>"/>
								<input type="hidden" id="workstate" name="workstate" value="<c:out value="${dailyWorkVO.state}"/>"/>
								<input type="hidden" id="menuGubun" name="menuGubun" value="<c:out value="${menuGubun}"/>"/>
								<input type="hidden" id="checkDailyWorkId" name="checkDailyWorkId" />
								<input type="hidden" id="workDay" name="workDay"  value="<c:out value="${dailyWorkVO.workDay}"/>}"/> 
								<input type="hidden" id="approvalSeq" name="approvalSeq"  value="<c:out value="${seq}"/>"/>
								<input type="hidden" id="appGubun" name="appGubun"/>
								<input type="hidden" id="modifyGubun" name="modifyGubun" />
								
								<span style="float:left"><b>1. 일자</b> : <c:out value="${dailyWorkVO.workDay}"/></span>
								<br />
								<div style="text-align:left;">
									<span><b></b></span> 
								</div>
								<br />
								<div style="text-align:left;">
									<span><b>2. 상시감시 주요결과(방제센터 및 지역본부 방제팀 세부내용)</b></span> 
								</div>
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
											<td style="text-align:left;padding-left:10px;">
												<!-- <c:out value="${riverMainVO.situationteamContent1}"/> -->
												${fn:replace(riverMainVO.situationteamContent1,newLineChar,'<br/>')}
											</td>
											<td style="text-align:left;padding-left:10px;">
												<!-- <c:out value="${riverMainVO.situationteamContent2}"/> -->
												${fn:replace(riverMainVO.situationteamContent2,newLineChar,'<br/>')}
											</td>
										</tr>
										<tr>
											<td>수도권<p>동부</p></td>
											<td>한강<p>(북한강, 남한강)</p></td>
											<td>10:00~17:00<p>(일 1회)</p></td>
											<td style="text-align:left;padding-left:10px;">
												<!-- <c:out value="${riverMainVO.capitalAreaContent1}"/> -->
												${fn:replace(riverMainVO.capitalAreaContent1,newLineChar,'<br/>')}
											</td>
											<td style="text-align:left;padding-left:10px;">
												<!-- <c:out value="${riverMainVO.capitalAreaContent2}"/> -->
												${fn:replace(riverMainVO.capitalAreaContent2,newLineChar,'<br/>')}
											</td>
										</tr>
										<tr>
											<td rowspan="2">경북권</td>
											<td>낙동강(대구청)<p>구미, 상주, 예천</p></td>
											<td>09:30~16:20</td>
											<td style="text-align:left;padding-left:10px;">
												<!-- <c:out value="${riverMainVO.gyeongbuk1Content1}"/> -->
												${fn:replace(riverMainVO.gyeongbuk1Content1,newLineChar,'<br/>')}
											</td>
											<td style="text-align:left;padding-left:10px;">
												<!-- <c:out value="${riverMainVO.gyeongbuk1Content2}"/> -->
												${fn:replace(riverMainVO.gyeongbuk1Content2,newLineChar,'<br/>')}
											</td>
										</tr>
										<tr>
											<td>낙동강(낙동강청)<p>창녕, 함안</p></td>
											<td>13:20~18:15</td>
											<td style="text-align:left;padding-left:10px;">
												<!-- <c:out value="${riverMainVO.gyeongbuk2Content1}"/> -->
												${fn:replace(riverMainVO.gyeongbuk2Content1,newLineChar,'<br/>')}
											</td>
											<td style="text-align:left;padding-left:10px;">
												<!-- <c:out value="${riverMainVO.gyeongbuk2Content2}"/> -->
												${fn:replace(riverMainVO.gyeongbuk2Content2,newLineChar,'<br/>')}
											</td>
										</tr>
										<tr>
											<td>충청권</td>
											<td>금강<p>서천, 익산, 논산,</p><p>공주, 세종, 옥천</p></td>
											<td>10:00~17:00</td>
											<td style="text-align:left;padding-left:10px;">
												<!-- <c:out value="${riverMainVO.chungcheongContent1}"/> --> 
												${fn:replace(riverMainVO.chungcheongContent1,newLineChar,'<br/>')}
											</td>
											<td style="text-align:left;padding-left:10px;">
												<!-- <c:out value="${riverMainVO.chungcheongContent2}"/> -->
												${fn:replace(riverMainVO.chungcheongContent2,newLineChar,'<br/>')}
											</td>
										</tr>
										<tr>
											<td>호남권</td>
											<td>영산강<p>극락교, 송촌보,</p><p>죽산보</p></td>
											<td>09:00~17:00<p>(일 1회)</p></td>
											<td style="text-align:left;padding-left:10px;">	
												<!-- <c:out value="${riverMainVO.honamContent1}"/> -->
												${fn:replace(riverMainVO.honamContent1,newLineChar,'<br/>')}
											</td>
											<td style="text-align:left;padding-left:10px;">
												<!-- <c:out value="${riverMainVO.honamContent2}"/> -->
												${fn:replace(riverMainVO.honamContent2,newLineChar,'<br/>')}
											</td>
										</tr>
									</table>
								</div>
								<br />
								<div>
									<table>
										<colgroup>
											<col width="16%" />
											<col />
										</colgroup>
										<c:forEach var="result" items="${approvalList}" varStatus="status">
							    			<c:if test="${result.approvalComment != null}">
												<tr>
													<th><c:out value="${result.approvalName}"></c:out> 의견</th>
													<td style="text-align:left;padding-left:10px;">
														${fn:replace(result.approvalComment,newLineChar,'<br/>')}
													</td>
												</tr>
											</c:if>
										</c:forEach>
										<c:if test="${menuGubun == 'app'}">
											<c:if test="${appCheck=='Y'}">
											<tr>
												<th>의견</th>
												<td><textarea name="approvalComment" id="approvalComment" rows="2" style="width:98%;"></textarea></td>
											</tr>	
											</c:if>
										</c:if>
									</table>
								</div>
							</form>
							<div style="padding-top:10px;">
								<c:if test="${dailyWorkVO.state == 'F'}">
									<input type="button" id="btnApp" value="인쇄" class="btn btn_basic" style="float:right" alt="인쇄" onclick="javascript:fnPrint('R');"/>
								</c:if>
								<c:if test="${menuGubun == 'dailyWork'}">
									<c:if test="${dailyWorkVO.state == 'S' or dailyWorkVO.state == 'R'}">
									<input type="button" id="btnDelete" value="삭제" class="btn btn_basic" style="float:right" alt="삭제" onclick="javascript:fnDelete();"/>
									<input type="button" id="btnApp" value="결재상신" class="btn btn_basic" style="float:right" alt="결재상신" onclick="javascript:fnSave('app');"/>
									<input type="button" id="btnMod" value="수정" class="btn btn_basic" style="float:right" alt="수정" onclick="javascript:fnModify('m');"/>
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