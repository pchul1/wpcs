<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />			
	<script type="text/javaScript" language="javascript" defer="defer">
		function view(mockId){
			document.location.href = "<c:url value='/mock/mockTestView.do'/>?mockId="+mockId+"&pageIndex="+document.listFrm.pageIndex.value;		    
		}	

		function del(mockId){
			$.ajax({
				type:"post",
				url:"<c:url value='/mock/delMock.do'/>",
				data:{mockId:mockId},
				dataType:"json",
				success:function(result){					 
					alert("삭제했습니다.");
					linkPage(1);	
				},
	            error:function(result){alert("error");}
			});			
		}				
		
		function linkPage(pageNo){
		    document.listFrm.pageIndex.value = pageNo;
		    document.listFrm.action = "<c:url value='/mock/mockTestList.do'/>";
		    document.listFrm.submit();		    
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
		<form:form commandName="mockVO" name="listFrm" method="post">		
		<input type="hidden" name="pageIndex" value="${mockVO.pageIndex}"/>		
		<div id="content" class="sub_situationmng">
			<div class="content_wrap page_correlation">
				<div class="inner_careerMng">
                    
					<!-- 이력관리 검색 -->
					<div class="formBox">
						<fieldset>
							<legend class="hidden_phrase">이력관리 검색</legend>
							<div class="roundBox roundBox1">
								<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
								<div class="con">
									<div class="con_r formSearch">
										<!-- 검색 1단 -->
										<div class="lastList">
											<dl>
												<dt class="hidden_phrase">수계</dt>
												<dd>
													<select name="riverId" id="riverId">
														<option value="">전체</option>
													   	<option value="01">한강</option>
													   	<option value="02">낙동강</option>
													   	<option value="03">금강</option>
													   	<option value="04">영산강</option>
													</select>													
												</dd>
												<dt class="hidden_phrase">모의 제목</dt>
												<dd><input type="text" class="inputText" name="mockTitle" id="mockTitle" value="${mockVO.mockTitle}"/></dd>
											</dl>
											<p class="btn"><a href="javascript:linkPage(1)"><img src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" /></a></p>
										</div>
									</div>
								</div>
								<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
							</div>
						</fieldset>
					</div>
					<!-- //이력관리 검색 -->
					<!-- 이력관리 현황 -->
					<div  action="">
						<div class="overBox">
							<table class="dataTable">
								<colgroup>
									<col width="120px" />
									<col width="*" />
									<col width="120px" />
									<col width="90px" />
									<col width="90px" />
									<col width="90px" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">모의일</th>
										<th scope="col">모의 제목</th>
										<th scope="col">수계</th>
										<th scope="col">등록자</th>
										<th scope="col">분석 결과</th>
										<th scope="col">삭제</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${mockTestList}"  var="mockTest"  varStatus="status">
									<tr>
										<td>${mockTest.regDate}</td>
										<td>${mockTest.mockTitle}</td>
										<td>${mockTest.riverName}</td>
										<td>${mockTest.memberId}</td>
										<td><a href="javascript:view('${mockTest.mockId}')"><img src="<c:url value='/images/common/btn_result.gif'/>" alt="결과보기" /></a></td>										
										<td><a href="javascript:del('${mockTest.mockId}')"><img src="<c:url value='/images/common/btn_del.gif'/>" alt="삭제" /></a></td>										
									</tr>								
									</c:forEach>								
								</tbody>
							</table>
							<c:if test="${!empty mockVO.pageIndex }">
							<ul class="paginate">
							        <ui:pagination paginationInfo = "${paginationInfo}"
							            type="default"
							            jsFunction="linkPage"
							            />
							</ul>
							</c:if>							
						</div>
					</div>
					<!-- //이력관리 현황 -->
				</div>
			</div>
		</div><!-- //content -->
		</form:form>

	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>
