<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : wareHouseManageRegistPopup.jsp
	 * Description : 재고현황정보 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2013.11.16	jsj			최초 생성
	 *
	 * author jsj
	 * since 2013.11.16 
	 * version 1.0
	 * see
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/com.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/smcube/tab.css' />" />

<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<c:import url="/WEB-INF/jsp/include/common/include_authUserPopup.jsp" />	<!-- 로그인 여부 -->
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>

<script type="text/javascript">

	$(function(){
		var whCode	 = $('#whCodePopupH', opener.document).val();
		var itemCode = $('#itemCodePopupH', opener.document).val();
		
		dataLoadInOutList(itemCode, whCode);
		
	});
	
	function dataLoadInOutList(_itemCode , _whCode){
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/getItemInOutList.do'/>",
			data: { 
					itemCode:_itemCode,
					whCode:_whCode
				},
			dataType:"json",
			beforeSend : function(){
							$("#dataList").html("");
							$("#dataList").html("<tr><td colspan='6'>데이터를 불러오는 중 입니다...</td></tr>");	
						},
			success : function(result){
					
				// 아이템 데이터 세팅	
				var tot = result['list'].length;
				
				if( tot <= 0 ){
					$("#dataList").html("<tr><td colspan='6'>조회 결과 없음</td></tr>");
				}else{
					$("#dataList").html("");
					
					for(var i=0; i < tot; i++){
						var obj = result['list'][i];
						var item;
						var inOutStatus = '입고';
						
						if(obj.status == 'O')
							inOutStatus = '출고';
					
						item = "<tr>"
								+ "<td style='text-align:center;'><span>" + obj.num + "</span></td>" 
								+ "<td style='text-align:center;padding:5px;'>" + obj.itemName + "</td>"
								+ "<td style='text-align:center;padding:5px;'>" + inOutStatus + "</td>"
								+ "<td style='text-align:center;padding:5px;'>" + obj.itemDate + "</td>"
								+ "<td style='text-align:center;'>" + obj.itemCnt + "</td>" 
								+ "<td >" + obj.storDesc + "</td>" 
								+ "</tr>";
								
						$("#dataList").append(item);
						$("#dataList tr:odd").attr("class","add");
					}
				}
			}
		});
	}
</script>
</head>

<body style="overflow-x:hidden;overflow-y:hidden;background-image: none;">
	<div id='loadingDiv' style="visibility:hidden;position:absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="wrap" style="padding:10px;width:95%">
		<div id="container">
		
			<!-- Contents Begin Here -->
			<div id="content" class="sub_waterpolmnt" style="padding:0px;width:100%;">
				<div class="content_wrap page_alarmmng">
					<div class="con_tit_wrap">
						<h3>재고현황</h3>
					</div>
				</div>
				
				<div class="listView_write" style="padding:0px;width:100%;">
					<div class="popup_situReceive" style="padding:15px 0; border:2px solid #2f8bc0; border-width:2px 0;">
						<fieldset class="first">
							<div class="tabDisplayArea"></div>
							
							<table class="dataTable" style="text-align:center;" summary="재고정보">
								<colgroup>
									<col width="40px" />
									<col width="100px" />
									<col width="60px" />
									<col width="120px" />
									<col width="60px" />
									<col width="120px"/>
								</colgroup>
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col">물품명</th>
										<th scope="col">구분</th>
										<th scope="col">입출고 일자</th>
										<th scope="col">수량</th>
										<th scope="col">내용</th>
									</tr>
								</thead>
								<tbody id="dataList"></tbody>
							</table>
						</fieldset>
					</div>
				</div>
			</div><!-- //content -->
		</div><!-- //Contents End Here -->
	</div><!-- //wrap -->
</body>
</html>