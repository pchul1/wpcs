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

		var sys = '${param.sys}';
		var factCodeX = '${param.factCodeX}'; 
		var branchNoX = '${param.branchNoX}';
		var factCodeY = '${param.factCodeY}';
		var branchNoY = '${param.branchNoY}';
		var bItemX = '${param.bItemX}';
		var bItemY = '${param.bItemY}';
		var startDate = '${param.startDate}';
		var endDate = '${param.endDate}';
		


		$(function(){
					
			$("#compareDate").datepicker({
			    buttonText: '비교일'

			});
			
			$('#itemX')
			.change(function(){
				chart();
			})		
			$('#itemY')
			.change(function(){
				chart();
			})		

			getItemDropDown();

			getFactNameX();
			getFactNameY();
		});

	
		function chart_load()
		{
			$("#span_loading").hide();
		}


		function getFactNameX(){

			var xFactName = $('#factNameX');
			

			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getBranchName.do'/>", {factCode:factCodeX, branchNo:branchNoX}, function (data, status){
			     if(status == 'success'){     
			        //item 객체에 SELECT 옵션내용 추가.

					xFactName.text(data.data.chukjeongso);
	        
			     } else { 

			        return;
			     }
			});	
		}


		function getFactNameY(){

			var yFactName = $('#factNameY');
			

			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getFlowOBSName.do'/>", {factCode:factCodeY}, function (data, status){
			     if(status == 'success'){     
			        //item 객체에 SELECT 옵션내용 추가.

					yFactName.text(data.data.gongku);
	        
			     } else { 

			        return;
			     }
			});	
		}
		
		function getItemDropDown(){

			if(sys == "A")
			{
				var dropDownSet = $('#itemX');


				dropDownSet.attr("disabled", false);
				$.getJSON("<c:url value='/waterpolmnt/waterinfo/getItemList2.do'/>", {itemKind:bItemX}, function (data, status){
				     if(status == 'success'){     
				        //item 객체에 SELECT 옵션내용 추가.
				        dropDownSet.loadSelectDepth3(data.item, sys);

				        chart();
				     } else { 
				        //alert("ERROR!");
				        return;
				     }
				});
			}
			else
			{
			
				var itemCode = "";
				
				if(sys == 'U' || sys == 'all'){
					itemCode = "22";
				}else if(sys == 'T'){
					itemCode = "23";
				}else if(sys == 'A'){
					itemCode = "37";
				}
				
				var dropDownSetX = $('#itemX');
				
				dropDownSetX.attr("disabled", false);
				
				$.getJSON("<c:url value='/cmmn/getCode.do'/>", {code_id:itemCode}, function (data, status){
				     if(status == 'success'){     
				        //item 객체에 SELECT 옵션내용 추가.
				        dropDownSetX.loadSelectDepth3(data.codes, sys);
	
				        chart();
				        
				     } else { 
				        //alert("ERROR!");
				        return;
				     }
				});	
			}
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

		        	  
		        	  if(optionData.VALUE.length <= 3)
		        	  {
		            	  optionData.VALUE = optionData.VALUE + "00";
		        	  }

		        	  
		              var option = new Option(optionData.CAPTION, optionData.VALUE);
		              
		              if ($.browser.msie) {
		                  selectElement.add(option);
		              }
		              else {
		                  selectElement.add(option,null);
		              }
		          });

		      }
		   });
		 }
		})(jQuery);

		
		function chart(){

			$("#span_loading").show();
			
			var width = "938";
			var height = "654";

			document.chartForm.target = "chartFrame";
			document.chartForm.factCodeX.value = factCodeX;
			document.chartForm.factCodeY.value = factCodeY;
			document.chartForm.branchNoX.value = branchNoX;
			document.chartForm.branchNoY.value = branchNoY;
			document.chartForm.branchNameX.value = "";
			document.chartForm.branchNameY.value = "";
			document.chartForm.system.value = sys;
			document.chartForm.width.value = width;
			document.chartForm.height.value = height;
			document.chartForm.itemCodeX.value = $("#itemX").val();
			document.chartForm.itemCodeY.value = $("#itemY").val();
			
			document.chartForm.startDate.value = startDate;
			document.chartForm.endDate.value = endDate;


			document.chartForm.action = "<c:url value='/stats/getRelateFlowGraph.do'/>";
			
			document.chartForm.submit();
		}
	</script>
</head>
<body class="subPop"><!-- 추가 및 수정 -->
<form id="chartForm" name="chartForm" method="post">
		<input type="hidden" name="factCodeX" />
		<input type="hidden" name="factCodeY" />
		<input type="hidden" name="branchNoX" />
		<input type="hidden" name="branchNoY" />
		<input type="hidden" name="branchNameX" />
		<input type="hidden" name="branchNameY" />
		<input type="hidden" name="system" />
		<input type="hidden" name="width"/>
		<input type="hidden" name="height"/>
		<input type="hidden" name="itemCodeX"/>
		<input type="hidden" name="itemCodeY"/>
		<input type="hidden" name="startDate"/>
		<input type="hidden" name="endDate"/>
</form>
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1 style='font-size:large;font-weight:bold;color:white'><span id="branchName"></span> 수질변화 추이</h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad"><!-- //추가 및 수정 -->
			
<div class="totalmntPop2" style="width:938px;height:714px">
	<div class="content" style="padding-top:20px">
	<center>
	</center>
			<ul class="selectList">
				<li><span class="buArrow_tit">항목(<span id="factNameX"></span>)</span>
					<select id="itemX">
						<option value="TUR00" selected="selected">탁도</option>
						<option value="DOW00">DO</option>
						<option value="TMP00">수온</option>
						<option value="PHY00">pH</option>
						<option value="CON00">전기전도도</option>
					</select>
				</li>
				<li><span class="buArrow_tit">항목(<span id="factNameY"></span>)</span>
					<select id="itemY">
						<option value="WLV00" selected="selected">수위</option>
						<option value="FLW00">유량</option>
					</select>
				</li>
			</ul>
		<div class="graph" style="height:660px">
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

