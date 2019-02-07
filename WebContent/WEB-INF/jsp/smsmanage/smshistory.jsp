<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/com.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/smcube/tab.css' />" />

	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<sec:authorize ifAnyGranted="ROLE_USER">
		<script type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
		</script> 
	</sec:authorize>
	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script type='text/javascript'> -->
<!-- 			alert('로그인이 필요한 페이지 입니다'); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script> -->
<%-- 	</sec:authorize> --%>

	<script type="text/javascript">
	$(function (){
		reloadData();
	});
	
	function showLoading()
	{
		$("#loadingDiv").dialog({
			modal:true,
			open:function() 
			{
				$("#loadingDiv").css("visibility","visible");
				$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar-close").hide();
				$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar").hide();
				$(this).parents(".ui-dialog:first").find(".ui-dialog-resizing").hide();
				$(this).parents(".ui-dialog:first").find(".ui-dialog-buttonpane").hide();
				$(this).parents(".ui-dialog:first").find(".ui-dialog-dragging").hide();
				$(this).parents(".ui-dialog:first").css("width", "85px");
				$(this).parents(".ui-dialog:first").css("height", "75px");
				$(this).parents(".ui-dialog:first").css("overflow", "hidden");
				$("#loadingDiv").css("float", "left");
			},
			width:0,
			height:0,
		    showCaption:false,
		    resizable:false
		});
		$("#loadingDiv").dialog("open");
	}
	
	function closeLoading()
	{
		$("#loadingDiv").dialog("close");
	}
	
	function reloadData(){
		showLoading(); 
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/getSmsList.do'/>",
			data:{},
			dataType:"json",
			success:function(result){
                var tot = result['detailViewList'].length;
               
                 $("#dataList").html("");

                 if( tot <= "0" ){
            		$("#dataList").html("<tr><td colspan='7' style='text-align:center;'>조회 결과가 없습니다</td></td>");
            		 closeLoading();
                }else{
	                for(var i=0; i < tot; i++){
		                
	                    var obj = result['detailViewList'][i];
	                    var pageInfo = result['paginationInfo'];
      
	                     var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1; 
	            	
	                    	var item = "<tr>";
	                    		item +="<td><span>" + no + "</span></td></a>";
	                    		item +="<td><a href=javascript:getSMSBranchList('"+obj.detCode+"') >"+obj.detCode+"</a></td>";
		    	                item +="<td><a href=javascript:getSMSBranchList('"+obj.detCode+"') >"+obj.detContent+"</a></td>";
		    	                item +="<td><a href=javascript:getSMSBranchList('"+obj.detCode+"') >"+obj.detDetailContent+"</a></td>";
		    	                item +="<td>"+obj.detCycle+"</td>";
	    	                 if(obj.dpYn == 'Y'){
	    	                	item+="<td>"+"<input type='checkbox' id='smsDetCheck' name='smsDetCheck' value="+obj.detCode+" checked='checked' /></td>";
	    	                 }else{
	    	                	item+="<td>"+"<input type='checkbox' id='smsDetCheck' name='smsDetCheck' value="+obj.detCode+" /></td>";
	    	                 }
		               	item += "</tr>"; 
	                 		 
	           			$("#dataList").append(item);

	           			$("#dataList tr:odd").attr("class","add"); 
	           			
	    	              
	                }
                }
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
				
				$("#dataList").html("");
	            $("#dataList").html("<tr><td colspan='7' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
	            closeLoading();
	        }
		});
	} 
	function smsDetInsert(){
		showLoading(); 
		var DetCycleInsert = $("#DetCycleInsert").val();
		var DetDetailContentInsert = $("#DetDetailContentInsert").val();
		var DetContentInsert = $("#DetContentInsert").val();
		var dpYnInsert = $("#dpYnInsert").val();
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/smsDetInsert.do'/>",
			data:{
				detCycle:DetCycleInsert,
				detDetailContent:DetDetailContentInsert,
				detContent:DetContentInsert,
				dpYn:dpYnInsert
			},
			dataType:"json",
			success:function(result){
				reloadData();
				LayerPopClose('layerSMSInsertForm');
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
				
				$("#dataList").html("");
	            $("#dataList").html("<tr><td colspan='7' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
	            closeLoading();
	        }
		});
	}
	function smsDetDelete(detCode){
		showLoading(); 
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/smsDetDelete.do'/>",
			data:{
				detCode:detCode
			},
			dataType:"json",
			success:function(result){
				reloadData();
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
				
				$("#dataList").html("");
	            $("#dataList").html("<tr><td colspan='7' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
	            closeLoading();
	        }
		});
	}
	function smsMultiple(){
	   	if($("input[name=smsDetCheck]:checked").length>0){
			$("input[name=smsDetCheck]").each(function(){
				if(this.checked){
					smsDetDelete(this.value);
				}
			});
		}else{
			alert("체크된 항목이 없습니다.");
			return;
		}
	}
	function smsMultipleSave(){
	   	if($("input[name=smsDetCheck]:checked").length>0){
	   		showLoading(); 
			$("input[name=smsDetCheck]").each(function(){
				var dpYn;
				if(this.checked){
					dpYn = "Y";
				}else{
					dpYn = "N";
				}
				
				$.ajax({
					type:"post",
					url:"<c:url value='/smsmanage/smsDetMultipleSave.do'/>",
					data:{
						detCode:this.value,
						dpYn:dpYn
					},
					dataType:"json",
					success:function(result){
						reloadData();
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
						
						$("#dataList").html("");
			            $("#dataList").html("<tr><td colspan='7' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
			            closeLoading();
			        }
				});
			});
		}else{
			alert("체크된 항목이 없습니다.");
			return;
		}
	}
	/* 측정소 리스트 사용 */
	function getBranchList(){
		showLoading(); 
		var detCode;
		if($("#detCode").val() != ""){
			detCode = $("#detCode").val(); 
		}else{
			alert("검출지점을 선택하세요.");
			closeLoading();
			return;
		}
		var riverDiv = $("select[name=c_river_div]").val();	
		var sysKind = $("select[name=c_sys_kind]").val();
		var pageNo;
		if (pageNo == null) pageNo = 1;
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/getBranchList.do'/>",
			data:{
				  pageIndex:pageNo,
				  sysKind:sysKind,
				  riverDiv:riverDiv,
				  detCode:detCode
				 },
			dataType:"json",
			success:function(result){
                var tot = result['detailViewList'].length;
                $("#branchDateList").html("");

                 if( tot <= "0" ){
            		$("#branchDateList").html("<tr><td colspan='4' style='text-align:center;'>조회 결과가 없습니다</td></td>");
            		 closeLoading();
                }else{
	                for(var i=0; i < tot; i++){
		                
	                    var obj = result['detailViewList'][i];
      
	                    	var item = "<tr>";
	    	                 item +="<td>"+obj.branchName+"</td>"
	    	                 +"<td id='st"+i+"'>"+obj.sysKind+"</td>"
	    	                 +"<td id='rd"+i+"'>"+obj.riverDiv+"</td>"
							 +"<td><input type='checkbox' id='branchCheck' name='branchCheck' value='"+obj.factCode+"/"+obj.branchNo+"' /></td>";										    	           
		               	item += "</tr>"; 
	                 		 
	           			$("#branchDateList").append(item);

	           			$("#branchDateList tr:odd").attr("class","add"); 
	           			

	                }
                } 
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
				
				$("#branchDateList").html("");
	            $("#branchDateList").html("<tr><td colspan='4' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
	            closeLoading();
	        }
		});
	}
	/* 체크 측정소 추가 */
	function branchMultipleAdd(){
		if($("input[name=branchCheck]:checked").length>0){
			$("input[name=branchCheck]").each(function(){
				if(this.checked){
					var check = this.value.split('/');
					goSmsBranchSave(check[0],check[1]);
				}
			});
			getBranchList();
		}else{
			alert("체크된 항목이 없습니다.");
			return;
		}
	}
	function goSmsBranchSave(factCode,branchNo){
		var detCode = $("#detCode").val();
		showLoading(); 
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/goSmsBranchSave.do'/>",
			data:{
				detCode:detCode,
				factCode:factCode,
				branchNo:branchNo
			},
			dataType:"json",
			success:function(result){
				getSMSBranchList($("#detCode").val());
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
				
				$("#dataList").html("");
	            $("#dataList").html("<tr><td colspan='7' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
	            closeLoading();
	        }
		});
	}
	/* SMS검출 지점 리스트 */
	function getSMSBranchList(detCode){
		$("#detCode").val(detCode);
		$("#factCode").val('');
		$("#branchNo").val('');
		getBranchList();
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/getSMSBranchList.do'/>",
			data:{
				detCode:detCode
				 },
			dataType:"json",
			success:function(result){
                var tot = result['detailViewList'].length;
                $("#SMSBranchDateList").html("");

                 if( tot <= "0" ){
            		$("#SMSBranchDateList").html("<tr><td colspan='5' style='text-align:center;'>조회 결과가 없습니다</td></td>");
            		 closeLoading();
                }else{
	                for(var i=0; i < tot; i++){
		                
	                    var obj = result['detailViewList'][i];
      						var no = i+1;
	                    	var item = "<tr>";
	    	                 item +="<td>"+ no +"</td>"
	    	               	 +"<td>"+obj.branchName+"</td>"
	    	                 +"<td id='rd"+i+"'><a href=\"javascript:getSMSList('"+obj.factCode+"', '"+obj.branchNo+"')\">"+obj.factCode+"</a></td>"
	    	                 +"<td id='st"+i+"'>"+obj.branchNo+"</td>";
	    	                 if(obj.dpYn == 'Y'){
							 	item += "<td><input type='checkbox' id='smsbranchCheck' name='smsbranchCheck' value='"+obj.factCode+"/"+obj.branchNo+"' checked='checked' /></td>";										    	           
		   	                 }else{
							 	item += "<td><input type='checkbox' id='smsbranchCheck' name='smsbranchCheck' value='"+obj.factCode+"/"+obj.branchNo+"' /></td>";										    	           
		   	                 }
		               	item += "</tr>"; 
	                 		 
	           			$("#SMSBranchDateList").append(item);

	           			$("#SMSBranchDateList tr:odd").attr("class","add"); 
	           			

	                }
                } 
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
				
				$("#SMSBranchDateList").html("");
	            $("#SMSBranchDateList").html("<tr><td colspan='7' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
	            closeLoading();
	        }
		});
		
		//getAllUserList();
		getSMSTargetList($("#factCode").val(''), $("#branchNo").val(''));
	}
	function MultipleSMSBranchCheck(){
		if($("input[name=smsbranchCheck]:checked").length>0){
			showLoading();
			$("input[name=smsbranchCheck]").each(function(){
				var dpYn;
				var check = this.value.split('/');
				if(this.checked){
					dpYn="Y";
				}else{
					dpYn="N";
				}
				$.ajax({
					type:"post",
					url:"<c:url value='/smsmanage/goSmsBranchDpYn.do'/>",
					data:{
						detCode:$("#detCode").val(),
						factCode:check[0],
						branchNo:check[1],
						dpYn:dpYn
						 },
					dataType:"json",
					success:function(result){
		                
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
						
						$("#SMSBranchDateList").html("");
			            $("#SMSBranchDateList").html("<tr><td colspan='7' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
			            closeLoading();
			        }
				});
			});
		}else{
			alert("체크된 항목이 없습니다.");
			return;
		}
	}
	function MultiBranchDel(){
		if($("input[name=smsbranchCheck]:checked").length>0){
			$("input[name=smsbranchCheck]").each(function(){
				if(this.checked){
					var check = this.value.split('/');
					SMSBranchDelete(check[0],check[1]);
				}
			});
		}else{
			alert("체크된 항목이 없습니다.");
			return;
		}
	}
	function SMSBranchDelete(factCode,branchNo){
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/SMSBranchDelete.do'/>",
			data:{
				detCode:$("#detCode").val(),
				factCode:factCode,
				branchNo:branchNo
				 },
			dataType:"json",
			success:function(result){
				getBranchList();
				getSMSBranchList($("#detCode").val());
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
				
				$("#SMSBranchDateList").html("");
	            $("#SMSBranchDateList").html("<tr><td colspan='5' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
	            closeLoading();
	        }
		});
	}
	
	/* 해당측정소별 지점별 SMS수신대상자 가져오기 */
	function getSMSList(factCode, branchNo) {
		$("#factCode").val(factCode);
		$("#branchNo").val(branchNo);
		
		// 전체 사용자조회
		getAllUserList();
		
		getSMSTargetList($("#factCode").val(), $("#branchNo").val());
	}
	
	/* 사용자 소속 리스트 사용 */
	function getAllUserList(){
		showLoading(); 
		if($("#factCode").val() == "" || $("#branchNo").val() == "") {
			alert("추가하실 검출대상지점을 선택하세요.");
			$("select[name=c_dept_code]").val('1000');	
			closeLoading();
			return;
		} 
		
		var deptCode = $("select[name=c_dept_code]").val();	
		var factCode = $("#factCode").val();	
		var branchNo = $("#branchNo").val();	
		var pageNo;
		if (pageNo == null) pageNo = 1;
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/getAllUserList.do'/>",
			data:{
				  pageIndex:pageNo,
				  deptCode:deptCode,
				  factCode:factCode,
				  branchNo:branchNo
				 },
			dataType:"json",
			success:function(result){
                var tot = result['detailViewList'].length;
                $("#userList").html("");

                 if( tot <= "0" ){
            		$("#userList").html("<tr><td colspan='3' style='text-align:center;'>조회 결과가 없습니다</td></td>");
            		 closeLoading();
                }else{
	                for(var i=0; i < tot; i++){
	                    var obj = result['detailViewList'][i];
	                    var item = "<tr>";
	    	                 item += "<td id='mem"+i+"'>"+obj.MEMBER_NAME+"</td>"
	    	                 +"<td id='off"+i+"'>"+obj.OFFICE_NAME+"</td>"
							 +"<td><input type='checkbox' id='userCheck' name='userCheck' value='"+obj.MEMBER_ID+"' /></td>";										    	           
		               	item += "</tr>"; 
	                 		 
	           			$("#userList").append(item);

	           			$("#userList tr:odd").attr("class","add"); 
	           			

	                }
                } 
                
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
				
				$("#userList").html("");
	            $("#userList").html("<tr><td colspan='3' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
	            closeLoading();
	        }
		});
	}
	
	/* 체크 소속 사용자 추가 */
	function userMultipleAdd(){
		if($("input[name=userCheck]:checked").length>0){
			$("input[name=userCheck]").each(function(){
				if(this.checked){
					var check = this.value;
					goSmsTargetSave(check);
				}
			});
			//getBranchList();
		}else{
			alert("체크된 항목이 없습니다.");
			return;
		}
	}
	
	function getSMSTargetList(factCode, branchNo) {
		// SMS 지점별 수신 대상자조회
		if(factCode == "" || branchNo == "") {
			alert("지점코드 또는 측정소번호가 존재하지 않습니다.");
			return;
		}
		//showLoading();
		var pageNo;
		if (pageNo == null) pageNo = 1;
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/getSMSTargetList.do'/>",
			data:{
				  pageIndex:pageNo,
				  factCode:factCode,
				  branchNo:branchNo
				 },
			dataType:"json",
			success:function(result){
                var tot = result['detailViewList'].length;
                $("#smsTargetList").html("");

                 if( tot <= "0" ){
            		$("#smsTargetList").html("<tr><td colspan='5' style='text-align:center;'>조회 결과가 없습니다</td></td>");
            		 closeLoading();
                }else{
	                for(var i=0; i < tot; i++){
	                    var obj = result['detailViewList'][i];
	                    var no = i+1;
                    	var item = "<tr>";
    	                 item +="<td>"+ no +"</td>"
	    	                 item += "<td id='mem"+i+"'>"+obj.MEMBER_NAME+"</td>"
	    	                 +"<td id='off"+i+"'>"+obj.OFFICE_NAME+"</td>"
	    	                 +"<td id='mob"+i+"'>"+obj.MOBILE_NO+"</td>";
	    	                 if(obj.USE_FLAG == 'Y'){
							 	item += "<td><input type='checkbox' id='targetCheck' name='targetCheck' value='"+obj.SMS_TARGET_NO+"' checked='checked' /></td>";										    	           
		   	                 }else{
							 	item += "<td><input type='checkbox' id='targetCheck' name='targetCheck' value='"+obj.SMS_TARGET_NO+"' /></td>";										    	           
		   	                 }
		               	item += "</tr>"; 
	                 		 
	           			$("#smsTargetList").append(item);

	           			$("#smsTargetList tr:odd").attr("class","add"); 
	                }
                } 
	            //closeLoading();
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
				
				$("#smsTargetList").html("");
	            $("#smsTargetList").html("<tr><td colspan='5' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
	            closeLoading();
	        }
		});
	}
	
	// SMS 수신 대상자 추가
	function goSmsTargetSave(memberId){
		var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
		showLoading(); 
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/goSmsTargetSave.do'/>",
			data:{
				factCode:factCode,
				branchNo:branchNo,
				memberId:memberId
			},
			dataType:"json",
			success:function(result){
				getAllUserList();
				getSMSTargetList(factCode, branchNo);
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
				
				$("#smsTargetList").html("");
	            $("#smsTargetList").html("<tr><td colspan='5' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
	            closeLoading();
	        }
		});
	}
	
	// SMS 대상 수신자 저장
	function goSmsTargetMultipleSave(){
	   	if($("input[name=targetCheck]:checked").length>0){
	   		showLoading(); 
			$("input[name=targetCheck]").each(function(){
				if(this.checked){
					useFlag = "Y";
				}else{
					useFlag = "N";
				}
				
				$.ajax({
					type:"post",
					url:"<c:url value='/smsmanage/goSmsTargetMultipleSave.do'/>",
					data:{
						smsTargetNo:this.value,
						useFlag:useFlag
					},
					dataType:"json",
					success:function(result){
						getAllUserList();
						getSMSTargetList($("#factCode").val(), $("#branchNo").val());
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
						
						$("#smsTargetList").html("");
			            $("#smsTargetList").html("<tr><td colspan='5' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
			            closeLoading();
			        }
				});
			});
		}else{
			alert("체크된 항목이 없습니다.");
			return;
		}
	}
	
	// SMS 대상 수신자 삭제
	function goSmsTargetMultipleDelete(){
	   	if($("input[name=targetCheck]:checked").length>0){
	   		showLoading(); 
			$("input[name=targetCheck]").each(function(){
				if(this.checked){
					smsTargetNo = this.value;
				}else{
					smsTargetNo = 0;
				}
				$.ajax({
					type:"post",
					url:"<c:url value='/smsmanage/goSmsTargetMultipleDelete.do'/>",
					data:{
						smsTargetNo:smsTargetNo
					},
					dataType:"json",
					success:function(result){
						getAllUserList();
						getSMSTargetList($("#factCode").val(), $("#branchNo").val());
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
						
						$("#smsTargetList").html("");
			            $("#smsTargetList").html("<tr><td colspan='5' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
			            closeLoading();
			        }
				});
			});
		}else{
			alert("체크된 항목이 없습니다.");
			return;
		}
	}
	</script>
</head>
<body>
<div id='loadingDiv' style="visibility:hidden;position:absolute;">
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="" />
</div>
<div id="wrap">
<div id="header"><c:import url="/common/menu/header.do" /></div><!-- //header -->
<div id="container">
<div id="snb" class="snb"><c:import url="/common/menu/left.do" /></div><!-- //snb -->
		<!-- navi 리스트 -->
		<div>
			<c:import url="/common/menu/navi.do" />
		</div>
		<!-- //navi 리스트 -->
		
		
<!-- Contents Begin Here -->
<input type="hidden" id="detCode" name="detCode" />
<input type="hidden" id="factCode" name="factCode" />
<input type="hidden" id="branchNo" name="branchNo" />
<div id="content" class="sub_waterpolmnt">
	<div class="content_wrap page_alarmmng">
	</div>
	
	<div class="listView_write">
		<div class="popup_situReceive" style="padding:15px 0; border:2px solid #2f8bc0; border-width:2px 0;">
			<fieldset class="first">
				<legend class="hidden_phrase">지점관리 검색조건 폼 및 엑셀, 신규등록(수계, 시스템, 명칭 및 )</legend>
				<table class="dataTable" style="width:800x">
				<colgroup>
					<col width="*" />
				</colgroup>
				<tr>
					<td rowspan="2" style="border: 0px solid red;width:100%">
						<div align="right">
						<a href="javascript:LayerPopOpen('layerCommRecvForm');;" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>공통 수신자 추가</em></span></a>&nbsp;&nbsp;&nbsp;
						<a href="#" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>설정</em></span></a>&nbsp;&nbsp;&nbsp;
						<a href="javascript:LayerPopOpen('layerSMSInsertForm');" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>등록</em></span></a>&nbsp;&nbsp;&nbsp;
						<a href="javascript:smsMultiple();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>삭제</em></span></a>&nbsp;&nbsp;&nbsp;
						<a href="javascript:smsMultipleSave();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>저장</em></span></a>&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
				</table>
				<div style="border:1px solid #CCC !important;overflow:auto; width:100%; height: 300px; margin-top:20px; ">
				<table class="dataTable">
					<colgroup>
						<col width="8%" />
						<col width="10%" />
						<col width="15%" />
						<col width="20%" />
						<col width="*" />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">연번</th>
							<th scope="col">검출코드</th>
							<th scope="col">검출내용</th>
							<th scope="col">검출 세부내용</th>
							<th scope="col">검출 주기</th>
							<th scope="col">사용여부</th>
						</tr>
					</thead>
					<tbody id="dataList">
						<tr>
							<td>&nbsp;</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr class="add">
							<td>&nbsp;</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				</div>
			</fieldset><!-- //fieldset -->


			<fieldset class="second">
				<legend class="hidden_phrase">SMS 지점 관리</legend>
				<div class="tabDisplayArea">
				</div>
				<div id="table_smcube"> 
				<table style="width:100%; float:left;">
					<tr valign="top">
					<td width="55%">
					<div>
					<table class="dataTable">
					<tr>
					<th>수계</th>
					<td>
						<select name="c_river_div" style="width:90%;" class="select" onchange="javascript:getBranchList();">
							<option value="ALL">전체</option>												
							<option value="R01">한강</option>													
							<option value="R02">낙동강</option>
							<option value="R03">금강</option>		
							<option value="R04">영산강</option>														
						</select>
					</td>
					<th>시스템</th>
					<td width="30%">
						<select name="c_sys_kind" style="width:90%;" class="select" onchange="javascript:getBranchList();">													
							<option value="U">이동형측정기기</option>
<!-- 							<option value="T">탁수모니터링</option>		 -->
							<option value="A">국가수질자동측정망</option>
							<option value="W">방류수질정보</option>														
						</select>
					</td>
					<td>
						<div align="right"><a href="javascript:branchMultipleAdd();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>추가</em></span></a>&nbsp;</div>
					</td>
					</tr>
					</table>
					</div>
						<div style="border:1px solid #CCC !important;  overflow:auto; width:100%; height: 100px; margin-top:10px;">
							<table id="tab_1_1" class="dataTable" style="width:100%; float:left;">
								<colgroup>
									<col width="30%"></col>
									<col width="25%"></col>
									<col width="25%"></col>
									<col width="*"></col>
								</colgroup>
									<tr>
										<th>지점명</th>
										<th>시스템</th>
										<th>수계</th>
										<th>선택</th>
									</tr>
								<tbody id="branchDateList">
									<tr> 
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr class="add">
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
						<table>
							<tr>
								<td width="78%"><div align="left"><font color="#2f8bc0">검출 대상 지점</font></div></td>
								<td><a href="javascript:MultiBranchDel();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>삭제</em></span></a>&nbsp;</td>
								<td><a href="javascript:MultipleSMSBranchCheck();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>저장</em></span></a>&nbsp;</td>
							</tr>
						</table>
						<div style="border:1px solid #CCC !important; overflow:auto; width:100%; height:250px;" id="groupMemo">
						<table id="tab_1_1" class="dataTable" style="width:100%; float:left;">
								<colgroup>
									<col width="10%"></col>
									<col width="20%"></col>
									<col width="20%"></col>
									<col width="*"></col>
									<col width="10%"></col>
								</colgroup>
									<tr>
										<th>연번</th>
										<th>지점명</th>
										<th>지점코드</th>
										<th>측정소번호</th>
										<th>사용</th>
									</tr>
								<tbody id="SMSBranchDateList">
									<tr> 
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr class="add">
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
						</td>
						<td width="45%">
						<div>
							<table class="dataTable">
								<tr>
									<th>소속</th>
									<td>
										<select name="c_dept_code" style="width:95%;" class="select" onchange="javascript:getAllUserList();">
											<!-- <option value="">전체</option> -->												
											<c:forEach var="list" items="${positionList }">
											<option value="${list.DEPT_CODE }">${list.DEPT_NAME }</option>												
											</c:forEach>													
										</select>
									</td>
									<td><a href="javascript:userMultipleAdd();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>추가</em></span></a>&nbsp;</td>
								</tr>
							</table>
						</div>
						<div style="border:1px solid #CCC !important;  overflow:auto; width:100%; height: 100px; margin-top:10px;">
							<table id="tab_1_1" class="dataTable" style="width:100%; float:left;">
								<colgroup>
									<col width="30%"></col>
									<col width="*"></col>
									<col width="25%"></col>
								</colgroup>
									<tr>
										<th>이름</th>
										<th>소속</th>
										<th>선택</th>
									</tr>
								<tbody id="userList">
									<tr> 
										<td>&nbsp;</td>
										<td></td>
										<td></td>
									</tr>
									<tr class="add">
										<td>&nbsp;</td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
						<table>
							<tr>
								<td width="73%"><div align="left"><font color="#2f8bc0">SMS수신 대상자</font></div></td>
								<td><a href="javascript:goSmsTargetMultipleDelete();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>삭제</em></span></a>&nbsp;</td>
								<td><a href="javascript:goSmsTargetMultipleSave();"   style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>저장</em></span></a>&nbsp;</td>
							</tr>
						</table>
						<div style="border:1px solid #CCC !important; overflow:auto; width:100%; height:250px;" id="groupMemo">
						<table id="tab_1_1" class="dataTable" style="width:100%; float:left;">
								<colgroup>
									<col width="10%"></col>
									<col width="20%"></col>
									<col width="*"></col>
									<col width="25%"></col>
									<col width="10%"></col>
								</colgroup>
									<tr>
										<th>연번</th>
										<th>이름</th>
										<th>소속</th>
										<th>전화번호</th>
										<th>사용</th>
									</tr>
								<tbody id="smsTargetList">
									<tr> 
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr class="add">
										<td>&nbsp;</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
						</td>
					</tr>
				</table>
				</div>
				</div>
				<!-- //UI Object -->
			
			</fieldset>
		</div>
	</div>
	<!-- 레이어 팝업 -->
<div id="layerSMSInsertForm">
		<table class="dataTable" style="width:300px !important;">
			<colgroup>
				<col width="30%" />
				<col width="*" />
			</colgroup>
			<tr>
				<th scope="col">사용여부</th>
				<td><select name="dpYnInsert" id="dpYnInsert" style="width:85%">
				<option value="Y">사용</option>			
				<option value="N">미사용</option>			
				</select></td>
			</tr>
			<tr>
				<th scope="col">검출내용</th>
				<td><input type="text" id="DetContentInsert" name="DetContentInsert" style="width:85%;"/></td>
			</tr>
			<tr>
				<th scope="col">검출 세부내용</th>
				<td><textarea id="DetDetailContentInsert" name="DetDetailContentInsert" rows="7" cols="20" ></textarea></td>
			</tr>
			<tr>
				<th scope="col">검출 주기</th>
				<td><input type="text" id="DetCycleInsert" name="DetCycleInsert" style="width:85%;"/></td>
			</tr>
		</table>
		<br/>
	<a href="javascript:smsDetInsert();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>등록</em></span></a>
	<a href="javascript:LayerPopClose('layerSMSInsertForm');" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>닫기</em></span></a>
</div>
<div id="layerGroupDeleteListForm">
		<table class="dataTable" style="width:230px !important;">
			<colgroup>
				<col width="*" />
				<col width="30%" />
			</colgroup>
			<tr>
				<th scope="col">그룹코드</th>
				<td><a href="javascript:LayerPopClose('layerGroupDeleteListForm');" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>닫기</em></span></a></td>
			</tr>
			<tr>
				<td><select id="delGroupCode">
				<option value="">그룹코드를선택해주세요.</option>
				</select></td>
				<td><a href="javascript:goGroupDel();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>삭제</em></span></a></td>
			</tr>
		</table>
</div>
	<div id="layerCommRecvForm">
		<div>
			<table class="dataTable">
				<tr>
					<th>소속</th>
					<td>
						<select name="c_dept_code" style="width:95%;" class="select" onchange="javascript:getAllUserList();">
							<!-- <option value="">전체</option> -->												
							<c:forEach var="list" items="${positionList }">
							<option value="${list.DEPT_CODE }">${list.DEPT_NAME }</option>												
							</c:forEach>													
						</select>
					</td>
					<td><a href="javascript:userMultipleAdd();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>추가</em></span></a>&nbsp;</td>
				</tr>
			</table>
		</div>
		<div style="border:1px solid #CCC !important;  overflow:auto; width:100%; height: 100px; margin-top:10px;">
			<table id="tab_1_1" class="dataTable" style="width:100%; float:left;">
				<colgroup>
					<col width="30%"></col>
					<col width="*"></col>
					<col width="25%"></col>
				</colgroup>
					<tr>
						<th>이름</th>
						<th>소속</th>
						<th>선택</th>
					</tr>
				<tbody id="userList">
					<tr> 
						<td>&nbsp;</td>
						<td></td>
						<td></td>
					</tr>
					<tr class="add">
						<td>&nbsp;</td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
		<table>
			<tr>
				<td width="73%"><div align="left"><font color="#2f8bc0">SMS공통수신대상자</font></div></td>
				<td><a href="javascript:goSmsTargetMultipleDelete();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>삭제</em></span></a>&nbsp;</td>
				<td><a href="javascript:goSmsTargetMultipleSave();"   style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>저장</em></span></a>&nbsp;</td>
			</tr>
		</table>
		<div style="border:1px solid #CCC !important; overflow:auto; width:100%; height:250px;" id="groupMemo">
		<table id="tab_1_1" class="dataTable" style="width:100%; float:left;">
				<colgroup>
					<col width="10%"></col>
					<col width="20%"></col>
					<col width="*"></col>
					<col width="25%"></col>
					<col width="10%"></col>
				</colgroup>
					<tr>
						<th>연번</th>
						<th>이름</th>
						<th>소속</th>
						<th>전화번호</th>
						<th>사용</th>
					</tr>
				<tbody id="smsTargetList">
					<tr> 
						<td>&nbsp;</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr class="add">
						<td>&nbsp;</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
		<br/>
		<a href="javascript:smsDetInsert();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>등록</em></span></a>
		<a href="javascript:LayerPopClose('layerCommRecvForm');" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>닫기</em></span></a>
	</div>
</div><!-- //content -->
<!-- //Contents End Here -->
</div>
<div id="footer" style="clear:both;"><c:import url="/WEB-INF/jsp/include/footer.jsp" /></div><!-- //footer -->
</div><!-- //wrap -->


</body>
</html>