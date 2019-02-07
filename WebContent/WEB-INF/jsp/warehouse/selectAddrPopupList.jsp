<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : selectAddrPopupList.jsp
	 * Description : 주소찾기 화면 (팝업)
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2012.11.19	윤일권			최초 생성
	 * 2014.05.22	lkh			리뉴얼
	 * 
	 * author 윤일권
	 * since 2012.11.19
	 * 
	 * Copyright (C) 2012 by 윤일권  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript">
//<![CDATA[
	function getSearchList(){
		var dong = $('#scDong').val();
		
		if(dong == null || dong == ""){alert("찾고자하는 동이름을 입력하세요!");$('#scDong').focus();return;}
		
		$.ajax({
			type:"post",
			url:"<c:url value='/warehouse/getWarehouseAddrList.do'/>",
			data:{
				dong:dong
			},
			dataType:"json",
			success:function(result){
				var tot = result['getAddressList'].length;
				$("#addrList").html("");
				
				var height = sGridCmn(0,result['getAddressList'],10);
				$("#overbox").css("height", height + "px");
				
				
				if( tot <= 0 ){
					$("#overbox").css("height", "26px");
					$("#addrList").html("<tr><td colspan='2' style='text-align:center;'>조회 결과가 없습니다</td></td>");
					closeLoading();
				}else{
					
					for(var i=0; i < tot; i++){
						var obj = result['getAddressList'][i];
						var addr = obj.sido+" "+obj.gugun+" "+obj.dong+" "+obj.bunji;
						var item = "<tr style='cursor:hand;' onclick='setAddress(\""+obj.zipcode+"\",\""+addr+"\");layerController();'>"
								+"<td style='text-align:center;' ><span>" + obj.zipcode + "</span></td></a>"
								+"<td style='text-align:left;'>"+addr+"</td>";
							item += "</tr>"; 
						$("#addrList").append(item);
						$("#addrList tr:odd").attr("class","add"); 
					}
				}
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
				$("#overbox").css("height", "26px");
				$("#addrList").html("<tr><td colspan='2' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
			}
		});
		$("#zip-code").attr("style","display:block")
		resizeWindowAutomatically();
	}
	
	/** 레이어 주소리스트에서 선택한 주소 팝업창으로 보내기 */
	function setAddress(zipcode,addr){
		$('#zipcode',opener.document).val(zipcode);
		$('#addr',opener.document).val(addr);
	
		$('#addrDetail',opener.document).focus();
		
		window.close();
	}
	
	function fnClosePopup(){
		window.close();
	}
	function resizeWindowAutomatically() {
		var finallyHeight = $(".address").height();
		resize_popup(550, finallyHeight);
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
// 		window.moveTo((screen.availWidth / 2) - (w / 2), (screen.availHeight / 2) - (h / 2));
	}
	
	function clearForm(obj, defaultvalue) {
		if (obj.value == defaultvalue)
			obj.value = "";
	}
	
	function escapeForm(obj, defaultValue) {
		if (obj.value == "")
			obj.value = defaultValue;
	}
//]]>
</script>
</head>

<body>
	<div class="address">
		<table summary="주소 검색">
			<colgroup>
				<col />
			</colgroup>
			<thead>
			<tr>
				<th scope="col" colspan="2">주소 찾기</th>
			</tr>
			<tr>
				<th>
					동이름 : <input type="text" id="scDong" name="scDong" value="동(읍/면/리)" style="width:200px; ime-mode:active;" onfocus="clearForm(this,'동(읍/면/리)');" onblur="escapeForm(this,'동(읍/면/리)');" onkeydown="javascript:if(event.keyCode==13){getSearchList();return false;}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" id="btnAddSearch" name="btnAddSearch" value="검색" class="btn btn_search" onclick="javascript:getSearchList();" alt="검색" />
				</th>
			</tr>
			<tr>
				<td scope="col" colspan="2">※찾고자하는 주소를(읍/면/리) 입력하세요.<br/>예)'논현동', '삼천동 1가', '구로3동'</td>
			</tr>
			</thead>
		</table>
		<div id="zip-code" style="display:none">
			<div id="overbox" style="border:0px solid #CCC !important; overflow:auto; width:100%; height: 251px; margin-top:10px">
				<table summary="주소정보" style="width:100%;">
					<colgroup>
						<col width="100" />
						<col />
					</colgroup>
					<tbody id="addrList">
					</tbody>
				</table>
			</div>
		</div>
		<div id="btCarea" _style="margin_top:20px;">
			<input type="button" id="btnClose" name="btnClose" value="닫기" class="btn btn_search" onclick="javascript:fnClosePopup();" alt="닫기" />
		</div>
	</div>
</body> 
</html> 