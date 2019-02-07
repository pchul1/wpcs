<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%@page import="daewooInfo.warehouse.bean.ItemCalcPreVO"%>
<%@page import="java.util.List"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
<title>청구서 인쇄</title>
<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<script type="text/javascript">
	var initBody;
	var totalItemCost = '0';
	
	function beforePrint(){
		boxes = ducument.body.innerHTML;
		document.body.innerHTML = printarea.innerHTML; 
	}
	
	function afterPrint(){
		document.body.innerHTML = boxes;
	}
	
	function printPage(){
		window.print();
	}
	
	function printDataLoad(){
		$.ajax({
			type:"POST"
			, url: "<c:url value='/warehouse/ItemCalcPrintInfo.do'/>"
			, data : { costSdate:$('#sDate').val(),
						costEdate:$('#eDate').val(),
						pre:"N"
					}
			, dataType:"json"
			, beforeSend : function(){
				$("#CalcResult").html("<tr><td colspan='5'>데이터를 불러오는 중 입니다...</td></tr>");	
				}
			, success : function(result){
				
				var tot = result['PrintInfoList'].length;
				var Ddate ='';
				var totalPrice = 0;
				$("#CalcResult").html("");
				for(var i=0; i < tot; i++){
					var obj = result['PrintInfoList'][i];
					if(i==0){Ddate = obj.sdate+' ~ '+obj.edate;}
					var item = "<tr>" 
								+"<td style=\"text-align:center;\">"+obj.item_name+"</td>"
								+"<td style=\"text-align:center;\">"+obj.item_unit+"</td>"
								+"<td style=\"text-align:center;\">"+comma(obj.price)+"원</td>"
								+"<td style=\"text-align:center;\">"+obj.amt+"</td>"
								+"<td style=\"text-align:center;\">"+comma(obj.item_price)+"원</td>"
							+"</tr>";
					totalPrice = totalPrice+ parseInt(obj.item_price);
					$("#CalcResult").append(item);
					$("#CalcResult tr:odd").attr("class","add");
					}
					document.getElementById("Ddate").innerHTML = Ddate;
					document.getElementById("totalPrice").innerHTML = comma(totalPrice);
				}
			}); 
		}
	
	window.onbeforeprint = beforePrint;
	window.onafterprint = afterPrint;
	window.onload = printDataLoad;
	</script>
</head>
<body>
	<form id="hidForm">
		<input type="hidden" id="sDate" value="${ItemCalcSearchVO.costSdate}"/>
		<input type="hidden" id="eDate" value="${ItemCalcSearchVO.costEdate}"/>
	</form>
	<div id="printarea">
		<h1>방제 물품 청구서</h1>
		<div class="period" >
			정산기간 : <span id="Ddate"></span>
		</div> 
		<table class="dataTable">
			<colgroup>
				<col width="200"/>
				<col width="100" />
				<col />
				<col width="100" />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">물품명</th>
					<th scope="col">단위</th>
					<th scope="col">단가</th>
					<th scope="col">수량</th>
					<th scope="col">금액</th>
				</tr>
			</thead>
			<tbody id="CalcResult">&nbsp;</tbody>
		</table>
		<div class="sum">합계 : <span id="totalPrice"></span>원</div>
	</div>
	<div class="button"><input type="button" title="인쇄" value="인쇄" onclick="javascript:printPage()"></div>
</body>
</html>
