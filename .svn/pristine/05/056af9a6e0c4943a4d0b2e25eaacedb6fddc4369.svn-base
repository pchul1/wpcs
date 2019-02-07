<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title></title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
	
	<script type='text/javascript'>

		var sys;
		var river;
		var item;
		
		$(function(){

			sys = '${param.sys}';
			river = '${param.river}';
			item = "TUR00";

			if(sys == "A" || sys == "T" )
				item = "PHY00";

			$("#river > option[value="+river+"]").attr("selected", "true");
			$("#sys > option[value="+sys+"]").attr("selected", "true");

			if($("#sys").val() == "T")
			{
				$("#R01").text("수도권");	
				$("#R02").text("영남");
				$("#R03").text("충청/강원");
				$("#R04").text("호남");
			}
			else
			{
				$("#R01").text("한강");	
				$("#R02").text("낙동강");
				$("#R03").text("금강");
				$("#R04").text("영산강");
			};

			getItemDropDown();
			
			$('#sys')
			.change(function() { 
				if($("#sys").val() == "T")
				{
					$("#R01").text("수도권");	
					$("#R02").text("영남");
					$("#R03").text("충청/강원");
					$("#R04").text("호남");
				}
				else
				{
					$("#R01").text("한강");	
					$("#R02").text("낙동강");
					$("#R03").text("금강");
					$("#R04").text("영산강");
				};
				getItemDropDown();
			} );

			
			$('#river')
			.change(function(){
				
				chart();
			})
			
			$('#item')
			.change(function(){
				chart();
			})		

			//$("#span_loading").css("display", "none");

			//var test = document.getElementById("chart").contentWindow.document.getElementsByTagName("td");

		});

		function chart_load()
		{
			$("#span_loading").css("display", "none");
		}
		
		function getItemDropDown(){
			var sys = $('#sys').val();
			var itemCode = "";
			
			if(sys == 'U' || sys == 'all'){
				itemCode = "22";
			}else if(sys == 'T'){
				itemCode = "52";
			}else if(sys == 'A'){
				itemCode = "37";
			}
			
			var dropDownSet = $('#item');

			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/cmmn/getCode.do'/>", {code_id:itemCode}, function (data, status){
				 if(status == 'success'){	 
					//item 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelectDepth3(data.codes, sys);

					chart();
				 } else { 
					//alert("ERROR!");
					return;
				 }
			});	
		}

		//동적 SELECTBOX 구현을 위한 사용자 함수
		(function($) {

		//SELECT OPTION 삭제
		$.fn.emptySelect = function() {
			return this.each(function(){
			  if (this.tagName=='SELECT') this.options.length = 0;
			});
		 }

		//SELECT OPTION 등록
		$.fn.loadSelectDepth3 = function(optionsDataArray, sys) {
			return this.emptySelect().each(function(){
			  if (this.tagName=='SELECT') {
				  var selectElement = this;
				  $.each(optionsDataArray,function(idx, optionData){

					  if(sys != "A")
						  optionData.VALUE = optionData.VALUE + "00";

					  var option = new Option(optionData.CAPTION, optionData.VALUE);
					  //var first = new Option(TITLE, 'all');
					  if ($.browser.msie) {
							//if(idx == 0){selectElement.add(first);}
							 
						  selectElement.add(option);
					  }
					  else {
							//if(idx == 0){selectElement.add(first);}
						  selectElement.add(option,null);
					  }
				  });

			  }
			});
		 }
		})(jQuery);

		
		function chart(){
			$("#span_loading").show();

			var width = "580";
			var height = "400";

			sys = $("#sys").val();
			river = $("#river").val();
			item = $("#item").val();
			
			var param = "sys="+sys+"&" + "river="+river+"&item="+item+"&itemName=탁도"+"&width="+width+"&height="+height;
			//alert(param);
			var src = "<c:url value='/waterpolmnt/situationctl/getTotalMntGraph.do?'/>";
			$('#chart').attr("src", src + encodeURI(param));
		}
	</script>
</head>
<body class="subPop"><!-- 추가 및 수정 -->
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1>그래프 상세정보</h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad"><!-- //추가 및 수정 -->
			
<div class="totalmntPop2" style="width:580px">
	<div class="content" style="padding-top:20px">
	<center>
	</center>
			<ul class="selectList">
				<li><span class="buArrow_tit">시스템</span> 
					<select id="sys">
						<option value="all" selected="selected">전체</option>
						<option value="A">국가수질자동측정망</option>
						<option value="T">수질TMS</option>
						<option value="U">이동형측정기기</option>
					</select>
				</li>
				<li><span class="buArrow_tit">수계</span>
					<select id="river">
						<option id="R01" value="R01">한강</option>
						<option id="R02" value="R02">낙동강</option>
						<option id="R03" value="R03">금강</option>
						<option id="R04" value="R04">영산강</option>
					</select>
				</li>
				<li><span class="buArrow_tit">항목</span>
					<select id="item">
						<option value="TUR00" selected="selected">탁도</option>
						<option value="DOW00">DO</option>
						<option value="TMP00">수온</option>
						<option value="PHY00">pH</option>
						<option value="CON00">전기전도도</option>
					</select>
				</li>
			</ul>
		<div class="graph" style="width: 580px;">
			<span id="span_loading" style="position:absolute">데이터를 불러오는 중 입니다...</span>
			<iframe id="chart" name="chartFrame" onload="chart_load()" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="100%"></iframe>
		</div>
	</div>
</div>
			</div><!-- 추가 및 수정 -->
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
</body>
</html>

