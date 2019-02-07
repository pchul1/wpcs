<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /**
  * @Class Name  : ipusn.jsp
  * @Description : IP-USN 모니터링  화면
  * @Modification Information
  * @
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2010.05.17             최초 생성
  *  2013.10.20             리뉴얼
  *
  *  @author kisspa
  *  @since 2010.07.02
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript" src="<c:url value="/js/admin/menu/MyMenuList.js" />"></script>
<script type="text/javascript">
function goSubmit(){
	if($("input[name='menu_id']:checked").length < 1)
	{
		alert("하나라도 체크하셔야 합니다.");
		return false;
	}
	
	if(confirm("저장하시겠습니까?")){
		document.frm.submit();
	}
}
</script>
</head>
<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="/images/common/ajax-loader2.gif" alt="로딩중.." />
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
						<div class="divisionBx" style="margin-top:0px;clear:both;">
						
							<form name="treeForm">
								<input type="hidden" name="req_RetrunPath" value="<c:url value='/common/member/MyMenu'/>">
								<c:forEach var="result" items="${List}" varStatus="status" > 
									<input type="hidden" name="tmp_deptNmVal" value="${result.menuNo}|${result.menuUpperNo}|${result.menuName}|${result.menu_open}">
								</c:forEach>
							</form>
							<form name="frm" action="/common/member/InsertMyMenu.do" method="post">
							<div id="btSmallArea" style="text-align:right;">
								<input type="button" id="btnAddNotice" name="btnAddNotice" value="저장" class="btn btn_basic" onclick="goSubmit();" alt="저장" />
							</div>
							<div class="div100">
								<div class="table_wrapper">
									<table summary="메뉴박스">
										<tr>
											<td class="txtL boxp">
												<script type="text/javascript">
													var chk_Object = true;
													var chk_browse = "";
													if (eval(document.treeForm.req_RetrunPath)=="[object]") chk_browse = "IE";
													if (eval(document.treeForm.req_RetrunPath)=="[object NodeList]") chk_browse = "Fox";
													if (eval(document.treeForm.req_RetrunPath)=="[object Collection]") chk_browse = "safai";
											
													var Tree = new Array;
													if(chk_browse=="IE"&&eval(document.treeForm.tmp_deptNmVal)!="[object]"){
														chk_Object = false;
													}
													if(chk_browse=="Fox"&&eval(document.treeForm.tmp_deptNmVal)!="[object NodeList]"){
														chk_Object = false;
													}
													if(chk_browse=="safai"&&eval(document.treeForm.tmp_deptNmVal)!="[object Collection]"){
														chk_Object = false;
													}
													if( chk_Object ){
														for (var j = 0; j < document.treeForm.tmp_deptNmVal.length; j++) {
															Tree[j] = document.treeForm.tmp_deptNmVal[j].value;
														}
														createTree(Tree);
													}else{
														alert("error");
													}
												</script>
											</td>
										</tr>
									</table>
								</div>
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
</body>
</html>