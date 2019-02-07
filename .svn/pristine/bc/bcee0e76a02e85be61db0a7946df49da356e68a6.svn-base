<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : statsAdActDetail.jsp
	 * Description : 사전조치통계상세 화면 (팝업)
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2014.06.18	lkh			리뉴얼
	 * 2014.11.20  mypark    그리드 걷어내고 테이블 처리
	 * 
	 * author lkh
	 * since 2014.06.18
	 * 
	 * Copyright (C) 2014 by lkh  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>	
	<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />	
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
<script type='text/javascript'>
	$(function(){
		//var statsDiv  = "${param.statsDiv}";
		//var statsDate = "${param.statsDate}";
		//var kind		= "${param.kind}";
		
		reloadData();
		
		//resizeWindowAutomatically();	// 사이즈 변경
	});
	
	//중분류 목록 불러오기
	function reloadData(pageNo){
		showLoading();
		if (pageNo == null) pageNo = 1;
		var statsDiv  = "${param.statsDiv}";
		var statsDate = "${param.statsDate}";
		var kind	  = "${param.kind}";
		
		if(kind == 'weather'){//기상
			kind = 'W';
		}else if(kind == 'traning'){//훈련
			kind = 'T';
		}else if(kind == 'emc'){//긴급
			kind = 'E';
		}else if(kind == 'chk'){//점검
			kind = 'C';
		}else if(kind == 'other'){//기타
			kind = 'A';
		}
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/stats/getStatsAdActDetail.do'/>",
			data: {
					statsDiv:statsDiv,
					statsDate:statsDate,
					kind:kind,
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
// 				console.log("getStatsAdActDetail : ",result);
				var tot = result['list'].length;
				var pageInfo = result['paginationInfo'];
				var dataHtml="";
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='9'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['list'][i];
						obj.no = obj.num;
						
						dataHtml += "<tr>";
						dataHtml += "<td>" + obj.no +"</td>";
						dataHtml += "<td>" + obj.sysKind +"</td>";
						dataHtml += "<td>" + obj.riverDiv +"</td>";
						dataHtml += "<td>" + obj.branchName +"</td>";
						dataHtml += "<td>" + obj.adActKind +"</td>";
						dataHtml += "<td>" + obj.adActDate +"</td>";
						dataHtml += "<td>" + obj.smsContent +"</td>";
						dataHtml += "<td>" + obj.regName +"</td>";
						dataHtml += "<td>" + obj.regDate +"</td>";
						dataHtml += "</tr>";
					}
				}
				
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				$("#dataList tr:odd").attr("class","even");
				
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
				$("#p_total_cnt").html("[총 "+result['paginationInfo'].totalRecordCount+"건]");
				closeLoading();
			},
			error:function(result){
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) { 
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				
				var dataHtml="<tr colspan='9'><td>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				closeLoading();
			}
		});
	}
	
	//페이지 번호 클릭	
	function linkPage(pageNo){
		reloadData(pageNo);
	}
	
/* 	function resizeWindowAutomatically() {
		var finallyHeight = $(".subPop").height();
		resize_popup(1002, finallyHeight);
	}
	
	function resize_popup(w, h, scroll) {
		var docEl = document.documentElement, width, height;
		// 창 내부 너비와 높이
		width = docEl.clientWidth;
		height = docEl.clientHeight;
		// 창 내부 너비와 높이가 입력 받은 너비/높이와 다를 경우 그 차이만큼 리사이즈
		if (width !== w || height !== h) {
			window.resizeBy(w - width, h - height + 16);
		}
		
		// 창을 화면 중앙으로 이동(크롬 영역(창 테두리, 주소표시줄 등)까지 고려해야하지만 큰 효과 없으므로 무시)
		window.moveTo((screen.availWidth / 2) - (w / 2), (screen.availHeight / 2) - (h / 2));
	} */
</script>
<style type="text/css">
table td { text-align: center; }
table th { font-weight: bold; }
table {border-collapse : collapse;}
</style>
</head>
<body class="subPop" style="overflow:hidden;">
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div class="headerWrap">
		<div class="headerBg_r">
			<div class="header">
				<h1 style='font-size:large;font-weight:bold;color:white'>사전 조치 통계 상세</h1>
			</div>
		</div>
	</div>
	<div class="contentWrap">
		<div class="contentBg_r">
			<div class="contentBox">
				<div class="contentPad">
					<div class="table_wrapper">
						<table summary="게시판 목록. 번호, 시스템,수계, 측정소, 구분, 조치일, 내용, 등록자, 등록일이 담김">
							<colgroup>
								<col width="45" />
								<col width="60" />
								<col width="60" />
								<col width="50" />
								<col width="50" />
								<col width="120" />
								<col width="450" />
								<col width="60" />
								<col width="120" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">No</th>
									<th scope="col">시스템</th>
									<th scope="col">수계</th>
									<th scope="col">측정소</th>
									<th scope="col">구분</th>
									<th scope="col">조치일</th>
									<th scope="col">내용</th>
									<th scope="col">등록자</th>
									<th scope="col">등록일</th>
								</tr>
							</thead>
							<tbody id="dataList">
							</tbody>
						</table>
						<div class="paging">
							<div id="page_number">
								<ul class="paginate" id="pagination"></ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div>
</body>
</html>