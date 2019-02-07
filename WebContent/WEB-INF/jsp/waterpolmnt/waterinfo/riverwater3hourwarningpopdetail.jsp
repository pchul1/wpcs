<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

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
	//var fact_name;
	var fact_code;
	var as_id;
	var alertTime;
	var branch_no;
	var branch_name;
	var sys_kind;
	var frDate;
	var toDate;
	var frTime;
	var toTime;
	
	var itemCnt;
	var itemArray;
	var itemCode;
	
	
	
	$(function(){
	     as_id = '${param.as_id}';
	     river_div = '${param.river_div}';
		 fact_code = '${param.fact_code}';
		 branch_no = '${param.branch_no}';
		 branch_name = '${param.branch_name}';
		 sys_kind = '${param.sys_kind}';
		 frDate = '${param.frDate}';
		 toDate = '${param.toDate}';
		 frTime = '${param.frTime}';
		 toTime = '${param.toTime}';
		 alertTime = '${param.alertTime}';
	
		 //$("#branch_name").text(branch_name);
		 
		 reloadData();
	});	

	function reloadData(){
		refresh();
		setTimeout(reloadData, 600000);
	}

	
	function refresh(){

		var aTime = "3";
		
		if(alertTime == "1")
			aTime = "3";
		else if(alertTime == "2")
			aTime = "9";
		else if(alertTime == "3")	
			aTime = "21";
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getRiverWater3HourWarningPopDetail.do'/>",
			data:{fact_code:fact_code,
					 as_id:as_id,
					 branch_no:branch_no,
					 branch_name:branch_name,
					 river_div:river_div,
					 sys_kind:sys_kind,
					 frDate:frDate,
					 toDate:toDate,
					 frTime:frTime,
					 toTime:toTime,
					 alertTime:aTime},
			dataType:"json",
			success:dataload_success,
	        error:function(result){
				$("#valueDataList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다!</td></tr>");
			}
		});
	}


	function dataload_success(result)
	{
		var tot = result['refreshData'].length;
		var trClass;

		
		 $("#valueDataList").html("");
		
		
	    if( tot <= "0" ){
			$("#valueDataList").html("<tr><td colspan='3'>조회 결과가 없습니다</td></tr>");
	
			//for(var i=0; i<1000; i++){
			//	$("#dataList").append("<tr code=1234 branchNo='1'><td colspan='"+(2 + itemCnt)+"'>"+i+"조회 결과가 없습니다</td></tr>");
		   //}	
	    }
	    else
	    {
	        
	        var idx = 0;
			for(var i=0; i < tot; i++){
				var obj = result['refreshData'][i];
	            var item;
	
	            branch_name = obj.branch_name;
	
	            $("#branch_name").text(branch_name);
	
				item = "<tr>"
							+"<td>"+obj.min_time+"</td>"
							+"<td>"+obj.item_name+"</td>"
							+"<td>"+obj.min_vl+"</td>"
						  +"</tr>";

				$("#valueDataList").append(item);
	
				$("#valueDataList tr:odd").addClass("add");
			}	
	    }

	    chart();
	}

    function chart(){

		var width = "385";
		var height = "215";

		var aTime = "3";
		
		if(alertTime == "1")
			aTime = "3";
		else if(alertTime == "2")
			aTime = "9";
		else if(alertTime == "3")
			aTime = "21";

	    var param = "fact_code=" 			+ fact_code +
						  "&branch_no=" 		+ branch_no +
						  "&as_id="				+ as_id +
						  "&alertTime="			+ aTime +
						  "&branch_name=" 	+ branch_name +
						  "&river_div=" 			+ river_div + 
						  "&sys_kind="			+sys_kind + 
						  "&frDate="				+frDate + 
						  "&toDate="			+toDate +
						  "&frTime="				+frTime +
						  "&toTime="			+toTime +
						  "&width="				+width+
						  "&height="				+height;

		var src = "<c:url value='/waterpolmnt/waterinfo/getRiverWater3HourWarningPopDetailGraph.do'/>?";
		$('#chart').attr("src", src + encodeURI(param));
	}

</script>
</head>
<body class="subPop"><!-- 추가 및 수정 -->
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1>경보지속지점조회</h1>
            
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad"><!-- //추가 및 수정 -->
<div class="riverwater3minwaringpopdetai">
	<div class="content">
		<div class="listBox">
			<div class="roundBox roundBox1">
				<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
				<div class="con">
					<div class="wrap">
						<h2 class="buRect_tit"><span id="branch_name"></span></h2>
						<div class="data">
								<p class="form_select">
									
								</p>
								<div class="overBox" id="overBox">
									<table class="dataTable" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
										<colgroup>
											<col />
											<col width="125px" />
											<col width="125px" />
										</colgroup>
										<thead id="valueDataHeader">
											<tr>
												<th>시간</th>
												<th>항목</th>
												<th>측정값</th>
											</tr>
										</thead>
										<tbody id="valueDataList">
											<tr>
												<td colspan="3">데이터를 불러오는 중 입니다.</td>
											</tr>
										</tbody>
									</table>
								</div>
							 <script type="text/javascript">
							         if(navigator.userAgent.indexOf('MSIE 7') != -1 || navigator.userAgent.indexOf('MSIE 6') != -1)
								         {
							         		var overBox = document.getElementById('overBox');
							          		var overBoxW = overBox.clientWidth;
							          		var overBoxH = overBox.clientHeight;
							          		var Table = overBox.childNodes[0]
							          		var TableH = overBox.childNodes[0].clientHeight;
							
									        if(overBoxH < TableH)
										        {
							        		   		overBoxW = (overBoxW - 20) + "px";
							           				Table.style.width = overBoxW;
							          			}
								         }
							</script>								
						</div>
						<div class="graph">
						<iframe id="chart"  src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="100%"></iframe>
						</div>
					</div>
				</div>
				<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
			</div>
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

