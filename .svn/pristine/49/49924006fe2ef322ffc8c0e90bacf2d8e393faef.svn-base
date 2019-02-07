<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp"/>

<style>
body, th, td, input, select, textarea, button {
    font-size: 12px;
    letter-spacing: 0px;
    font-family: NanumGothic,'나눔고딕','Nanum Gothic','돋움',dotum,sans-serif;
    line-height: 1.5;
    color: #333;
    -webkit-text-size-adjust: none;
}

.itemTable {
    border: 1px solid #b7b7b7;
	width: 100%;
    border-collapse: collapse;
    border-spacing: 0;
}
.itemTbody {
    display: table-row-group;
    vertical-align: middle;
    border-color: inherit;
}
.itemTh {
    border: 1px solid rgba(212, 232, 243, 1);
    background: rgba(233, 240, 246, 1);
    line-height: 16px;
    text-align: center;
    min-height: 26px;
    padding: 5px 0;
}
.itemTr {
    display: table-row;
    vertical-align: inherit;
    border-color: inherit;
}
.itemTd {
    padding: 0;
    border: 1px solid rgba(212, 232, 243, 1);
    background: #ffffff;
    height: 26px;
    text-align: center;
    min-height: 20px;
    line-height: 14px;
}

.highlight {
    font-weight: bold;
    color: red;
    background: yellow;
}
</style>

<script type="text/javascript">

function resolution() {
	$('#popup').bPopup();
}

var itemCode = "${itemCode}";
var itemCodeNum = "${itemCodeNum}";

function HtmlEncode(s) {
    return $('<div>').text(s).html();
}

function HtmlDecode(s) {
    return $('<div>').html(s).text();
}

function decodeHTMLEntities(text) {
    var entities = [
        ['amp', '&'],
        ['apos', '\''],
        ['#x27', '\''],
        ['#x2F', '/'],
        ['#39', '\''],
        ['#47', '/'],
        ['lt', '<'],
        ['gt', '>'],
        ['nbsp', ' '],
        ['quot', '"']
    ];

    for (var i = 0, max = entities.length; i < max; ++i) 
        text = text.replace(new RegExp('&'+entities[i][0]+';', 'g'), entities[i][1]);

    return text;
}

function clickTrEvent(trObj) {
	var tr = eval("document.getElementById(\"" + trObj.id + "\")");
	$(tr).parent().find("tr td").removeClass("tr_on");
	$(tr).find("td").addClass("tr_on");
}

function clickTdEvent(tdObj) {
	var td = eval("document.getElementById(\"" + tdObj.id + "\")");
	$(td).parent().find("td").removeClass("highlight");
	$(td).addClass("highlight");
}

function f_itemLocationStock(itemCode, itemCodeNum, deptCode){
	showLoading();
	
	$.ajax({
		type: "POST",
		url: "<c:url value='/warehouse/showItemLocationStock.do'/>",
		data: {
			itemCode : itemCode,
			itemCodeNum : itemCodeNum,
			deptCode : deptCode
		},
		dataType:"json",
		success : function(result){
			
			if (result.reqRst == 'SUCCESS') {
				// 배치현황
				var tot = result['itemLocationStockList'].length;
				var item = "";
				if( tot <= 0 ) {
					// 결과 없음 
				}else{
					item += "<table class=\"itemTable\"><tr class=\"itemTr\">";
					for(var i=0; i < tot; i++){
						var obj = result['itemLocationStockList'][i];
						item += "<th class=\"itemTh\" width=\"50px\">"+obj.whName+"</th>";
					}
					item += "</tr>";
					item += "<tr class=\"itemTr\">";
					for(var i=0; i < tot; i++){
						var obj = result['itemLocationStockList'][i];
						item += "<td class=\"itemTd\">"+obj.itemCnt+"</td>";
					}
					item += "</tr>";
					item += "</table>";
					$("#itemLocationStockDept").html(item);
				}
				
			}else{
				alert('<spring:message code="fail.common.select" />');
				var reqErr = result.reqErr;
				if(reqErr != null && jQuery.trim(reqErr) != ''){
					// 서버파트 오류를 화면에 띄워준다.
					alert(reqErr);
				}
			}
			
			closeLoading();
		},
		error:function(result){
			closeLoading();
		}
	});
	
	closeLoading();
}

var numCount = 0;

function f_changeImage(num) {
	if(numCount == 1) {
		
	}else if(numCount == 2) {
		if(num == 1) {
			$("#itemImageLayer1").hide();
			$("#itemImageLayer3").hide();
			$("#itemImageLayer2").fadeIn();
		}else if(num == 2) {
			$("#itemImageLayer2").hide();
			$("#itemImageLayer3").hide();
			$("#itemImageLayer1").fadeIn();
		}
	}else if(numCount == 3) {
		if(num == 1) {
			$("#itemImageLayer1").hide();
			$("#itemImageLayer3").hide();
			$("#itemImageLayer2").fadeIn();
		}else if(num == 2) {
			$("#itemImageLayer1").hide();
			$("#itemImageLayer2").hide();
			$("#itemImageLayer3").fadeIn();
		}else if(num == 3) {
			$("#itemImageLayer2").hide();
			$("#itemImageLayer3").hide();
			$("#itemImageLayer1").fadeIn();
		}
	}
}

//문서 로딩 시 
$(document).ready(function() {

	showLoading();
	
	$.ajax({
		type: "POST",
		url: "<c:url value='/warehouse/showItemDetailView.do'/>",
		data: {
			itemCode : itemCode,
			itemCodeNum : itemCodeNum
		},
		dataType:"json",
		success : function(result){
			
			if (result.reqRst == 'SUCCESS') {
				var itemVO = result["itemVO"];
				
				if(itemVO.itemPurpose == null || jQuery.trim(itemVO.itemPurpose) == ''){
					$("#itemPurposeDesc").html("<table class=\"itemTable\"><tr class=\"itemTr\"><td class=\"itemTd\">물품(장비) 용도 정보가 등록되지 않았습니다.</td></tr></table>");
				}else{
					$("#itemPurposeDesc").html("<table class=\"itemTable\"><tr class=\"itemTr\"><td class=\"itemTd\">"+ itemVO.itemPurpose +"</td></tr></table>");
				}
				
				if(itemVO.itemDetail == null || jQuery.trim(itemVO.itemDetail) == ''){
					$("#itemDataList").html("<table><tr><td>물품(장비) 제원 정보가 등록되지 않았습니다.</td></tr></table>");
				}else{
					$("#itemDataList").html(decodeHTMLEntities(HtmlDecode(itemVO.itemDetail)));
				}
				
				// 배치현황
				var tot = result['itemLocationStockList'].length;
				var item = "";
				if( tot <= 0 ) {
					$("#itemLocationStock").html("<table class=\"itemTable\"><tr class=\"itemTr\"><td class=\"itemTd\">해당 물품(장비)은 배치되지 않았습니다.</td></tr></table>");
				}else{
					item += "<table class=\"itemTable\"><tr class=\"itemTr\">";
					for(var i=0; i < tot; i++){
						var obj = result['itemLocationStockList'][i];
						item += "<th class=\"itemTh\">"+obj.deptName+"</th>";
					}
					item += "</tr>";
					item += "<tr class=\"itemTr\">";
					for(var i=0; i < tot; i++){
						var obj = result['itemLocationStockList'][i];
						
						item += "<td id=\'wtd"+i+"\' class=\'itemTd td"+i+"\' style=\'cursor:pointer;\' onclick=\'clickTdEvent(this);f_itemLocationStock(\""
								+itemCode+"\",\""+itemCodeNum+"\",\""+obj.deptCode+"\");\'>"+obj.itemCnt+"</td>";
					}
					item += "</tr>";
					item += "</table>";
					$("#itemLocationStock").html(item);
				}
				$("#itemLocationStockDept").html("");
			}else{
				alert('<spring:message code="fail.common.select" />');
				var reqErr = result.reqErr;
				if(reqErr != null && jQuery.trim(reqErr) != ''){
					// 서버파트 오류를 화면에 띄워준다.
					alert(reqErr);
				}
			}
			
			$.ajax({
				type : "POST",
				url : "<c:url value='/cmmn/getImageFileInfs.do'/>",
				data : {
					atchFileId : itemVO.atchFileId
				},
				dataType : "json",
				beforeSend : function() {},
				success : function(result) {
					//$("#itemImageLayer").html("");
					var count = result['fileList'].length;
					if( count <= 0 ) {
						// 첨부파일 없음
						$("#itemImageLayer1").html("<img src=\"\" alt=\"등록된 이미지가 없습니다.\" style=\"background-color:#E0E0F8;width:100%;height:300px;padding:5px 5px;\" />");
					}else{
						numCount = count;
						for(var i=0; i<count; i++){
							var obj = result['fileList'][i];
							if(i == 0) {
								$("#itemImageLayer1").append("<img src=\"/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn="+obj.fileSn
										+"\""+" id=\"smallItemImage\" style=\"padding:5px 5px;width:100%;height:300px\" "
										+" onclick=\"f_changeImage(\'1\');\" />사진을 터치하시면 다음사진을 볼 수 있습니다.");	
							}
							if(i == 1) {
								$("#itemImageLayer2").append("<img src=\"/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn="+obj.fileSn
										+"\""+" id=\"smallItemImage\" style=\"padding:5px 5px;width:100%;height:300px\" "
										+" onclick=\"f_changeImage(\'2\');\" />사진을 터치하시면 다음사진을 볼 수 있습니다.");	
							}
							if(i == 2) {
								$("#itemImageLayer3").append("<img src=\"/cmmn/getImage.do?atchFileId="+obj.atchFileId+"&fileSn="+obj.fileSn
										+"\""+" id=\"smallItemImage\" style=\"padding:5px 5px;width:100%;height:300px\" "
										+" onclick=\"f_changeImage(\'3\');\" />사진을 터치하시면 다음사진을 볼 수 있습니다.");	
							}
						}
					}
				}
			});
			
			closeLoading();
		},
		error:function(result){
			closeLoading();
		}
	});
	
	closeLoading();
});

</script>

</head>

<body>

<div class="main">
    <jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="Y" name="notlogin"/>
	</jsp:include>

	<div class="mainbox100" style="margin-bottom:25px;">
		<div id="itemImageLayer1" style="width:100%;height:300px;">
		</div>
		<div id="itemImageLayer2" style="width:100%;height:300px;display:none">
		</div>
		<div id="itemImageLayer3" style="width:100%;height:300px;display:none">
		</div>
	</div>
	
	<div class="mainbox100" style="margin-bottom:25px;">
		※ 배치현황
		<div id="itemLocationStock" style="padding:7px 7px 0 7px;" >
		</div>
		<div id="itemLocationStockDept" style="padding:7px 7px 0 7px;" >
		</div>
	</div>
	
	<div class="mainbox100" style="margin-bottom:25px;">
		※ 용도
		<div id="itemPurposeDesc" style="padding:7px 7px 0 7px;" >	
		</div>
	</div>
	
	<div class="mainbox100" style="margin-bottom:25px;">
		※ 제원
		<div id="itemDataList" style="padding:7px 7px 0 7px;" >	
		</div>
	</div>	

</div>
<jsp:include page="/WEB-INF/jsp/mobile/common/bottom.jsp"/>
</body>
</html>