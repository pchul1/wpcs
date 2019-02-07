<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

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
<%-- 	</sec:authorize> --%>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<link href="<c:url value='/css/content.css' />" rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/popup.css' />" rel="stylesheet" type="text/css">
<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<title>교육 신청자</title>
<script>
	var ROOT_PATH = '<c:url value="/"/>';

	var eduSeq = '${eduSeq}';
	
	$(function () {

		$("#eduMemeberListBtn").click(eduMemeberSearch);
		$("#eduMemeberExcelBtn").click(eduMemeberExcel);
					
		dataLoad();
		$("#dataList tr:odd").attr("class","add");
		
	});

	function eduMemeberSearch()
	{
		eduSeq = $("#eduList").val();
		dataLoad(1, eduSeq);
	}

	function eduMemeberExcel()
	{
		if (eduSeq == null) eduSeq = '${eduSeq}';
		location.href="<c:url value='/edu/eduMemberDataExcel.do'/>?eduSeq="+eduSeq;
		
	}
	
	// 데이터 목록 불러오기
	function dataLoad(pageNo, eduSeq)
	{
		if (pageNo == null) pageNo = 1;

		if (eduSeq == null) eduSeq = '${eduSeq}';
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/edu/eduMemberDataList.do'/>",
			data: {eduSeq:eduSeq,
					pageIndex:pageNo
				},	
			dataType:"json",
			beforeSend : function(){
				$("#dataList").html("");
				$("#dataList").html("<tr><td colspan='5'>데이터를 불러오는 중 입니다...</td></tr>");	
				},				
			success : function(result){

				var tot = result['list'].length;

				if( tot <= 0 ){
	            	$("#dataList").html("<tr><td colspan='5'>조회 결과 없음 (조회 기간등 검색 조건을 확인해주세요.)</td></tr>");
	            }else{
	            	$("#dataList").html("");
	                for(var i=0; i < tot; i++){
	                    var obj = result['list'][i];
						var item;
	                   	item = "<tr>"
								+"<td class='num'><span>"+obj.num+"</span></td>"
		                 		+"<td>"+obj.title+"</td>"
		                 		+"<td>"+obj.memberName+"</td>"
		                 		+"<td>"+obj.deptNoName+"</td>"
		                 		+"<td>"+obj.mobileNo+"</td>"
	                 		 	+"</tr>";

	              		$("#dataList").append(item);

	              		$("#dataList tr:odd").attr("class","add");
	                }
	            }

	            // 페이징 정보
	            var pageStr = makePaginationInfo(result['paginationInfo']);
	            $("#pagination").empty();
	            $("#pagination").append(pageStr);

	            // 총건수 표시
	            $("#totcnt").empty();
				$("#totcnt").append("[총 "+result['paginationInfo'].totalRecordCount+"건]");	            	
			}
		});
	}

	// 페이지 번호 클릭	
	function linkPage(pageNo){
		dataLoad(pageNo, eduSeq);				    
	}
		
</script>

</head>

<body class="subPop"><!-- 추가 및 수정 --> 
<div class="headerWrap"> 
	<div class="headerBg_r"> 
		<div class="header"> 
			<h1>상위부서를 선택해주세요</h1>
		</div> 
	</div> 
</div> 
<div class="contentWrap"> 
	<div class="contentBg_r"> 
		<div class="contentBox"> 
			<div class="contentPad">
				<!-- 내용 --> 
				<div id="managePage">
				<form name="eduMemberList" method="post">
				
					<div align="left" style="position:relative; z-index:100;">
						구분 : 
						<select style="width:400px;" id="eduList">
							<c:forEach var="result" items="${eduList}" varStatus="status">
							<option value='<c:out value="${result.eduSeq}"/>' <c:if test="${result.eduSeq == eduSeq}">selected</c:if>><c:out value="${result.title}"/></option>
							</c:forEach>			  		   
						</select>
						<img src="<c:url value='/images/common/btn_search2.gif'/>" alt="조회" id="eduMemeberListBtn" style="cursor:pointer;vertical-align:middle;padding-bottom:7px;"/>
					</div>
					<div align="right" style="position:relative; z-index:100;">
						<img src="<c:url value='/images/content/btn_excel.gif'/>" alt="엑셀 다운로드" id="eduMemeberExcelBtn" style="cursor:pointer;vertical-align:middle;padding-bottom:7px;"/>
					</div>
					<div align="right" id="totcnt">&nbsp;</div>
					<table class="dataTable">
						<colgroup>
							<col width="38px"/>
							<col />
							<col width="100px" />
							<col width="150px" />
							<col width="150px" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">NO</th>
								<th scope="col">교육명</th>
								<th scope="col">성명</th>
								<th scope="col">부서</th>
								<th scope="col">연락처</th>
							</tr>
						</thead>
						<tbody  id="dataList">&nbsp;</tbody>
					</table>
					<ul class="paginate" id="pagination"></ul>
				</form>
			</div>
			</div>
		</div> 
	</div> 
</div> 
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 --> 
</body> 
</html> 


