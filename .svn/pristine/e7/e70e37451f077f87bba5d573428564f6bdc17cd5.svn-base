<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	
	<script type="text/javascript">

		var searchStart;
		var searchEnd;
		var sugye;
		var mode;
		var obv_num;
		var pageIndex;
		
		var isModify = "${isModify}";

		function replaceALL(ostr, str1, str2)
		{
			if(ostr != null && ostr != undefined)
			return ostr.split(str1).join(str2);
		}
		
		$(function () {

			searchStart = '${param.searchStart}';
			searchEnd = '${param.searchEnd}';
			pageIndex = '${param.pageIndex}';

			
			if(isModify == 'Y')
			{
				setPerson();

				var wrkTime1 = "${data.wrkTime1}";
				var wrkTime2 = "${data.wrkTime2}";
	
				var wt1 = wrkTime1.split(":");
				var wt2 = wrkTime2.split(":");
				
				$("#hTime1 > option").each(function() {
					if($(this).val() == wt1[0])
						$(this).attr("selected", "selected");
				});
				$("#mTime1 > option").each(function() {
					if($(this).val() == wt1[1])
						$(this).attr("selected", "selected");
				});
				$("#hTime2 > option").each(function() {
					if($(this).val() == wt2[0])
						$(this).attr("selected", "selected");
				});
				$("#mTime2 > option").each(function() {
					if($(this).val() == wt2[1])
						$(this).attr("selected", "selected");
				});
			}
		});
		

		function setPerson()
		{
			var dropDownSet1 = $("#pWorker1");
			var dropDownSet2 = $("#pWorker2");
			var dropDownSet3 = $("#pWorker3");
			var dropDownSet4 = $("#pWorker4");

			$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>", 
					{
						orderType:"2",
						value:"1001"
					},
					//, system:sys_kind}, 
					function (data, status){
				     if(status == 'success'){     
				        //locId 객체에 SELECT 옵션내용 추가.
				       
				        dropDownSet1.loadSelect(data.groupList);
				        dropDownSet2.loadSelect(data.groupList);
				        dropDownSet3.loadSelect(data.groupList);
				        dropDownSet4.loadSelect(data.groupList);
						//adjustBranchList();

					   $("#pWorker1 > option").each(function(){
						    if($(this).html() == "${data.worker1}")
						    {
							  	$(this).attr("selected", "selected");
						    }
					   });
					   $("#pWorker2 > option").each(function(){
						    if($(this).html() == "${data.worker2}")
						    {
							  	$(this).attr("selected", "selected");
						    }
					   });
					   $("#pWorker3 > option").each(function(){
						    if($(this).html() == "${data.worker3}")
						    {
							  	$(this).attr("selected", "selected");
						    }
					   });
					   $("#pWorker4 > option").each(function(){
						    if($(this).html() == "${data.worker4}")
						    {
							  	$(this).attr("selected", "selected");
						    }
					   });
						 
						
				     } else { 
				        return;
				     }
			});
		}


		var saveList = new Array();
		var tmp = new Array();
		
		var cnt = 0;
		
		function errorTextChange(obj, factcode, branchNo, statIdx)
		{
			var selectedVal = $("#usnEcode_" + statIdx + " > option:selected").val();
			var id = "usnEcode_" + statIdx;
			var ocTxt = "";
			
			if(statIdx != null)
			{
				ocTxt = $("#ipusn_oc_" + statIdx).val();
				if(ocTxt == "")
					ocTxt = "-";
			}
			else
			{
				ocTxt = "-";
			}

			var idx = 0;
			
			if(tmp[id] != null && tmp[id] != undefined)
				idx = tmp[id];
			else
			{
				idx = cnt;
				tmp[id] = cnt;
			}
			
			saveList[idx] =  factcode + "|" + branchNo + "|" + selectedVal + "|" + ocTxt;
			
			cnt++
		}

		function errorCodeChange(obj, factcode, branchNo, statIdx)
		{
			var selectedVal = $("#" + obj.id + " > option:selected").val();

			var ocTxt = "";
			
			if(statIdx != null)
			{
				ocTxt = $("#ipusn_oc_" + statIdx).val();
				if(ocTxt == "")
					ocTxt = "-";
			}
			else
			{
				ocTxt = "-";
			}

			ocTxt = replaceALL(ocTxt, "<", "[lt]");
			ocTxt = replaceALL(ocTxt, ">", "[gt]");
			ocTxt = replaceALL(ocTxt, "&", "[amp]");

			var idx = 0;
			
			if(tmp[obj.id] != null && tmp[obj.id] != undefined)
				idx = tmp[obj.id];
			else
			{
				idx = cnt;
				tmp[obj.id] = cnt;
			}
			
			//saveList.push(factcode + "|" + branchNo + "|" + selectedVal + "|" + ocTxt);
			saveList[idx] =  factcode + "|" + branchNo + "|" + selectedVal + "|" + ocTxt;
			
			cnt++
			
		}



		

		var saveList2 = new Array();
		var tmp2 = new Array();
		var cnt2 = 0;
		
		function clickDept(obj, idx, type, time)
		{
			var deptStr = "";
			
			for(var i = 0 ; i < 6 ; i++)
			{
				if($("#s"+type+"_dept" + (i+1) + "" + idx).is(":checked"))
				{	
					deptStr += "1";
				}
				else
				{
					deptStr += "0";
				}
			}

			var content = "";
			
			if(idx != null)
			{
				content = $("#s" + type + "_content" + idx).val();
				if(content == "")
					content = "-";
			}
			else
			{
				content = "-";
			}

			content = replaceALL(content, ">", "[gt]");
			content = replaceALL(content, "<", "[lt]");
			content = replaceALL(content, "&", "[amp]");

			//alert(content);
			
			var sIdx = 0;
			
			if(tmp2[type + "-" +  idx + time] != null && tmp2[type + "-" +  idx + time] != undefined)
				sIdx = tmp2[type + "-" +  idx + time];
			else
			{
				sIdx = cnt2;
				tmp2[type + "-" +  idx + time] = cnt2;
			}

			if(type == "1")
				type = "S";
			else
				type = "W";
			
			//saveList.push(factcode + "|" + branchNo + "|" + selectedVal + "|" + ocTxt);
			saveList2[sIdx] =  time + "|" + deptStr + "|" + content + "|" + type;
			
			cnt2++;
		}

		

		
		function modify()
		{
			location.href = "<c:url value='/mock/goDayLogDet.do'/>?daylogNo=${data.daylogNo}&isModify=Y";
		}

		function save()
		{
			if(confirm("입력된 사항으로 수정하시겠습니까?"))
			{
				document.frm.action = "<c:url value='/mock/updateDayLog.do'/>";
				
				document.frm.worker1.value = $("#pWorker1 option:selected").text();
				document.frm.worker2.value = $("#pWorker2 option:selected").text();
				document.frm.worker3.value = $("#pWorker3 option:selected").text();
				document.frm.worker4.value = $("#pWorker4 option:selected").text();


				var content1 = document.frm.content1.value;
				var content2 = document.frm.content2.value;
				var content3 = document.frm.content3.value;
				var wrkNote = document.frm.wrkNote.value;
				var wrkContent = document.frm.wrkContent.value;

				content1 = replaceALL(content1, "<", "[lt]");
				content1 = replaceALL(content1, ">", "[gt]");
				content1 = replaceALL(content1, "&", "[amp]");

				document.frm.content1.value = content1;
				
				content2 = replaceALL(content2, "<", "[lt]");
				content2 = replaceALL(content2, ">", "[gt]");
				content2 = replaceALL(content2, "&", "[amp]");
				
				document.frm.content2.value = content2;

				content3 = replaceALL(content3, "<", "[lt]");
				content3 = replaceALL(content3, ">", "[gt]");
				content3 = replaceALL(content3, "&", "[amp]");

				document.frm.content3.value = content3;
				
				wrkNote = replaceALL(wrkNote, "<", "[lt]");
				wrkNote = replaceALL(wrkNote, ">", "[gt]");
				wrkNote = replaceALL(wrkNote, "&", "[amp]");

				document.frm.wrkNote.value = wrkNote;

				wrkContent = replaceALL(wrkContent, "<", "[lt]");
				wrkContent = replaceALL(wrkContent, ">", "[gt]");
				wrkContent = replaceALL(wrkContent, "&", "[amp]");

				document.frm.wrkContent.value = wrkContent;
				
				document.frm.saveData.value = saveList;
				document.frm.saveSpreadData.value = saveList2;				
				document.frm.submit();
			}
		}


	 	function cancel()
	 	{
	 		location.href = "<c:url value='/mock/goDayLogDet.do'/>?daylogNo=${data.daylogNo}";
	 	}

		function list()
		{
			var param = "searchStart=" + searchStart + "&searchEnd=" + searchEnd + "&pageIndex=" + pageIndex;
			window.location = "<c:url value='/mock/goDayLogList.do'/>?" + param;
		}

		function complete()
		{	
			if(confirm("일지작성을 완료하시겠습니까? \n완료된 일지는 수정할 수 없습니다."))
			{
				$.ajax({
					type: "POST",
					url: "<c:url value='/mock/completeDaylog.do'/>",
					data: {
							daylogNo:"${data.daylogNo}"
						},	
					dataType:"json",
					success : function(result)
					{
						alert("처리되었습니다");
						cancel();
					},
					error : function(result)
					{
						alert("실패하였습니다.");	
					}
				});
			}
		}

		function report() {
			var sw=screen.width;
			var sh=screen.height;
			var winHeight = 600;
			var winWidth = 900;
			var winLeftPost = (sw - winWidth) / 2;var winTopPost = (sh - winHeight) / 2;
			var width = winWidth-40;
			var height = winHeight-40;

			var mrdFile = "";
			
			mrdFile = "daylog";

			var param = "/rp [${data.daylogNo}] [${data.daylogMakeTime2}]";

			document.report.mrdpath.value = mrdFile;
			document.report.param.value = param;
					
			window.open("", 
					'reportView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);

			document.report.target = "reportView";
			document.report.submit();			
		}	
	</script>
</head>
<body> 
<div id='loadingDiv' style="visibility:hidden;position:absolute;">
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />	
</div>
<div id="wrap">
	<div id="header">
		<c:import url="/common/menu/header.do" />
	</div><!-- //header -->
	<div id="container">
		<!-- 사이드 리스트 -->
		<div id="snb" class="snb">
			<c:import url="/common/menu/left.do" />
		</div>
		<!-- //사이드 리스트 -->
		<!-- navi 리스트 -->
		<div>
			<c:import url="/common/menu/navi.do" />
		</div>
		<!-- //navi 리스트 -->
		
		<!-- content -->
		<form name="frm" method="post">
			<input type="hidden" name="daylogNo" value="${data.daylogNo}"/>
			
			<input type="hidden" name="saveData"/>
			<input type="hidden" name="saveSpreadData"/>
						
		<div id="content" class="sub_waterpolmnt">
			<div class="content_wrap page_alarmmng">
				<div class="inner_alarmhis">
					
					
					 <!-- 1.일자 --> 
					<div class="data_wrap">                    
					     <h5> 
                         <dl class="tit_h4">
                         	<dt>1. 일자 :</dt>
                         	<dd class="time">
                         		<input type="text" class="inputText" value="${data.daylogMakeTime}" disabled="disabled"/>
                         	<!--
										<input type="text" class="inputText"  id="daylogDate" name="daylogDate" size="15" readonly="readonly"/>
											<select id="daylogTime" name="daylogTime" style="width:50px">
												<option value="00">00</option>
												<option value="01">01</option>
												<option value="02">02</option>
												<option value="03">03</option>
												<option value="04">04</option>
												<option value="05">05</option>
												<option value="06">06</option>
												<option value="07">07</option>
												<option value="08">08</option>
												<option value="09">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23">23</option>
											</select> 시
							-->
							</dd>
                            <dt class="right">날씨 :</dt>
                         	<dd>
                         		<input type="text" class="inputText" value="${data.weather}" disabled="disabled"/>
                         	<!--
										<select id="weather" name="weather" style="width:100px">
											<option value="S">맑음</option>
											<option value="C">흐림</option>
											<option value="R">비</option>
											<option value="N">눈</option>
											<option value="M">안개</option>
										</select>
							-->
							</dd>
                         </dl>
                         </h5>
						<!-- 1.일자 --> 	
                    
                    <!-- 2.근무상황 --> 
					     <h5 style="padding:7px 0 10px 0;clear:both;width:200px">2. 근무 상황</h5> 
							<table class="dataTable">
									<colgroup>
										<col width="220" />
                                        <col />
									</colgroup>
									<thead>
										<tr>
											<th class="bgStyle" scope="col">구분</th>
											<th class="bgStyle" scope="col">내용</th>
										</tr>
								   </thead>
								   <tbody>
                                    <tr>
										<th class="txtP" scope="row">
                                         <ul class="checkList4">
                                         <li>오전 (07:00 ~ 15:00)</li>
                                         <li>
                                         근무자 : 
                                         <c:if test="${isModify != 'Y'}">
 	                                        <input type="text" class="inputText" value="${data.worker1}" disabled="disabled"/>
										</c:if>
                                         <c:if test="${isModify == 'Y'}">
		                                         <select id="pWorker1" name="paramWorker1" style="width:120px">
													<option value=""></option>
												 </select>
												 <input type="hidden" name="worker1"/>
										  </c:if>
                                         </li>
                                         </ul>
                                        </th>
                                        <td>
	                                        <c:if test="${isModify != 'Y'}">
		                                         <textArea class="checkList4" id="content1" name="content1" readonly="readonly" style="color:gray">${data.content1}</textarea>
											</c:if>
											<c:if test="${isModify == 'Y'}">
		                                         <textArea class="checkList4" id="content1" name="content1">${data.content1}</textarea>
											</c:if>
                                        </td>
									</tr>
                                    <tr>
										<th class="txtP" scope="row">
                                         <ul class="checkList4">
                                         <li>오후 (15:00 ~ 23:00)</li>
                                         <li>
                                         근무자 : 
                                         <c:if test="${isModify != 'Y'}">
												<input type="text" class="inputText" value="${data.worker2}" disabled="disabled" style="color:gray"/>
										 </c:if>
										 <c:if test="${isModify == 'Y'}">
	                                         <select id="pWorker2" name="paramWorker2" style="width:120px">
											 </select>
											 <input type="hidden" name="worker2"/>
										 </c:if>
										 
                                         </li>
                                         </ul>
                                        </th>
                                        <td>
                                        	<c:if test="${isModify != 'Y'}">
		                                         <textArea class="checkList4" id="content_2" name="content2" readonly="readonly" style="color:gray">${data.content2}</textarea>
											</c:if>
											<c:if test="${isModify == 'Y'}">
		                                         <textArea class="checkList4" id="content_2" name="content2">${data.content2}</textarea>
											</c:if>
                                        </td>
									</tr>
                                    <tr>
										<th class="txtP" scope="row">
                                         <ul class="checkList4">
                                         <li>야간 (23:00 ~ 07:00)</li>
                                         <li>
                                         근무자 : 
                                         <c:if test="${isModify != 'Y'}">
	                                         <input type="text" class="inputText" value="${data.worker3}" disabled="disabled" style="color:gray"/>
										 </c:if>
										 <c:if test="${isModify == 'Y'}">
	                                         <select id="pWorker3" name="paramWorker3" style="width:120px">
											 </select>
											 <input type="hidden" name="worker3"/>
										 </c:if>
                                         
                                         </li>
                                         </ul>
                                        </th>
                                        <td>
                                        	<c:if test="${isModify != 'Y'}">
	                                         	<textArea class="checkList4" id="content3" name="content3" readonly="readonly" style="color:gray">${data.content3}</textarea>
											 </c:if>
											 <c:if test="${isModify == 'Y'}">
	                                         	<textArea class="checkList4" id="content3" name="content3">${data.content3}</textarea>
											 </c:if>
                                        </td>
									</tr>
                                    <tr>
										<td colspan="2" class="txtP">
                                        <dl class="tit_h5">
                         				<dt class="sp1">특이사항</dt>
                         				<dd class="sp2">
                         				<c:if test="${isModify != 'Y'}">
											<textArea class="checkList5" id="wrkNote" name="wrkNote" readonly="readonly" style="color:gray">${data.wrkNote}</textarea>
										</c:if>
										<c:if test="${isModify == 'Y'}">
											<textArea class="checkList5" id="wrkNote" name="wrkNote">${data.wrkNote}</textarea>
										</c:if>
										</dd>
                         				</dl>
                                       </td>
									</tr>
                                    <tr>
										<th class="txtP" scope="row">당일근무</th>
                                        <td class="txtP">
                                         <div class="sp2">
                                         시간 ( 
                                         <c:if test="${isModify != 'Y'}">
	                                         <input type="text" class="inputText" value="${data.wrkTime1}" disabled="disabled"/> ~ 
	                                         <input type="text" class="inputText" value="${data.wrkTime2}" disabled="disabled"/>
										 </c:if>
										 
										 <c:if test="${isModify == 'Y'}">
                                         	<select id="hTime1" name="HTime1" style="width:50px">
											<%for(int i = 0 ; i < 24 ; i ++){%>
												<option value="<%=i%>"><%=i%></option>
											<%}%>
											</select> : 
                                            <select id="mTime1" name="MTime1" style="width:50px">
											<%for(int i = 0 ; i < 60 ; i += 10){%>
												<option value="<%=i%>"><%=i%></option>
											<%}%>
											</select>
											</select> ~  
                                            <select id="hTime2" name="HTime2" style="width:50px">
											<%for(int i = 0 ; i < 24 ; i ++){%>
												<option value="<%=i%>"><%=i%></option>
											<%}%>
											</select> : 
                                            <select id="mTime2" name="MTime2" style="width:50px">
											<%for(int i = 0 ; i < 60 ; i += 10){%>
												<option value="<%=i%>"><%=i%></option>
											<%}%>
											</select>
										 </c:if>
                                             )
                                            </div>
                                        </td>
									</tr>
                                    <tr>
										<td colspan="2" class="txtP">
                                        <dl class="tit_h5">
                         				<dt class="sp3">-<br /><br />-</dt>
                         				<dd class="sp4">
	                         				<c:if test="${isModify != 'Y'}">
												<textArea class="checkList6" id="wrkContent" name="wrkContent" readonly="readonly" style="color:gray">${data.wrkContent}</textarea>
											</c:if>
											<c:if test="${isModify == 'Y'}">
												<textArea class="checkList6" id="wrkContent" name="wrkContent">${data.wrkContent}</textarea>
											</c:if>
										</dd>
                         				</dl>
                                       </td>
									</tr>
                                    <tr>
										<td colspan="2" class="num">
                                        <div class="sp5">
                                        근무자 : 
                                        <c:if test="${isModify != 'Y'}">
	                                        <input type="text" class="inputText" value="${data.worker4}" disabled="disabled"/>
										</c:if>
										<c:if test="${isModify == 'Y'}">
	                                         <select id="pWorker4" name="paramWorker4" style="width:120px">
											 </select>
											 <input type="hidden" name="worker4"/>
										</c:if>
                                        <!--
										 -->
                                        </div>
                                       </td>
									</tr>
                                   </tbody>
								</table>
					<!--// 2.근무상황 --> 
					
					
					<!-- 3.IP-USN 전송현황 --> 
					<div class="data_wrap">
					     <h1 style="clear:both;width:500px;padding-bottom:8px">3. 이동형측정기기 전송 현황</h1>
							<table class="dataTable" style="clear:both">
									<colgroup>
										<col width="110" />
                                        <col width="120" />
										<col width="90" />
										<col width="140" />
                                        <col />
									</colgroup>
									<thead>
										<tr>
											<th scope="col" class="bgStyle">구분</th>
                                            <th scope="col" class="bgStyle">측정소</th>
											<th scope="col" class="bgStyle">전송</th>
											<th scope="col" class="bgStyle">경보 발생<br />(건/시간)</th>
											<th scope="col" class="bgStyle">비고<br />(사유)</th>
										</tr>
								   </thead>
								   <tbody>
									   <c:forEach items="${ipusn}"  var="ipusn"  varStatus="status">
									   		<tr>
											<th scope="row">${ipusn.riverDiv}</th>
	                                        <th scope="row">${ipusn.branchName}</th>
											<td>
												<c:if test="${ipusn.rxCnt >= 144}">
													O
												</c:if>
												<c:if test="${ipusn.rxCnt < 72}">
													X
												</c:if>
												<c:if test="${ipusn.rxCnt >= 72 && ipusn.rxCnt < 144}">
													△
												</c:if>
											</td>
											<td>
												<c:if test="${isModify != 'Y'}">
													${ipusn.warningOc}
												</c:if>
												<c:if test="${isModify == 'Y'}">
													<input type="text" id="ipusn_oc_${status.index}" value="${ipusn.warningOc}" class="inputText" size="20" value="" style="text-align:center" onchange="errorTextChange(this, '${ipusn.factCode}', '${ipusn.branchNo}', '${status.index}')"/>
												</c:if>
											</td>
	                                        <td>
	                                            <c:if test="${isModify != 'Y'}">
			                                        ${ipusn.edataName}
												</c:if>
												<c:if test="${isModify == 'Y'}">
			                                        <select class="fixWidth23" id="usnEcode_${status.index}" name="usnEcode${status.index}" onchange="errorCodeChange(this, '${ipusn.factCode}', '${ipusn.branchNo}', '${status.index}')">
			                                        		<option value="none">선택해주세요</option>
			                                        	<c:forEach items="${errorCodeList}"  var="errorCode"  varStatus="stat">
															<option value="${errorCode.edataCode}">${errorCode.edataName}</option>
														</c:forEach>
													</select>		
													<script type="text/javascript">
											  			$("#usnEcode_${status.index} > option[value=${ipusn.edataCode}]").attr("selected","selected");
											  		</script>									
												</c:if>
												
										
	                                		</td>
										</tr>
									   </c:forEach>
                                   </tbody>
								</table>
                 				<p class="caption_bt" style="clear:both">
                 					* 전송 (×:미전송, ○:정상전송, △:12시간 이하, 방제정보시스템 생성자료 기준), <br />
			  						* 경보가 발생한 경우에는 발생내역 및 경과 등을 확인 기록 (비고란)
			  					</p>
                    <!-- 4.상황전파(사전조치) 현황 --> 
					     <h5 style="clear:both">4. 상황 전파 (사전 조치) 현황</h5> 
							<table class="dataTable" style="clear:both">
									<colgroup>
										<col width="90" />
                                        <col width="130" />
										<col width="250" />
                                        <col />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">구분</th>
                                            <th scope="col">시간</th>
											<th scope="col">대상</th>
											<th scope="col">내용</th>
										</tr>
								   </thead>
								   <tbody>
								   <c:if test="${spread1Cnt == 0 && spread2Cnt == 0}">
								   		<tr>
											<td colspan="4">전파 내용이 없습니다</td>
										</tr>
								   </c:if>
								    <c:forEach items="${spread1}"  var="spread1"  varStatus="status">
	                                    <tr>
	                                    	<c:if test="${status.first}">
											<th scope="row" rowspan="${spread1Cnt}">사고<br />전파</th>
	                                    	</c:if>
	                                        <td>
	                                        	${spread1.spreadTime}
	                                        	 <!--input type="text" class="inputText1" /> : <input type="text" class="inputText1" />-->
	                                        </td>
											<td>
											
											<c:if test="${isModify != 'Y'}">
	                                        	<ul class="checkList3">
	                                    		  <li><input id="s1_dept1${status.index}" type="checkbox" class="inputCheck" onclick="return false"/><label for="">환경청,</label></li>
	                                        	  <li><input id="s1_dept2${status.index}" type="checkbox" class="inputCheck" onclick="return false"/><label for="">지자체</label></li>
												  <li><input id="s1_dept3${status.index}" type="checkbox" class="inputCheck" onclick="return false"/><label for="">본사,</label></li>
												  <li><input id="s1_dept4${status.index}" type="checkbox" class="inputCheck" onclick="return false"/><label for="">지역본부</label></li>
	                                        	  <li><input id="s1_dept5${status.index}" type="checkbox" class="inputCheck" onclick="return false"/><label for="">시공사,</label></li>
												  <li><input id="s1_dept6${status.index}" type="checkbox" class="inputCheck" onclick="return false"/><label for="">기타</label></li>
												</ul>
											</c:if>
											<c:if test="${isModify == 'Y'}">
												<ul class="checkList3">
	                                    		  <li><input id="s1_dept1${status.index}" type="checkbox" class="inputCheck" onclick="clickDept(this, '${status.index}', '1', '${spread1.spreadTime}')" /><label for="">환경청,</label></li>
	                                        	  <li><input id="s1_dept2${status.index}" type="checkbox" class="inputCheck" onclick="clickDept(this, '${status.index}', '1', '${spread1.spreadTime}')" /><label for="">지자체</label></li>
												  <li><input id="s1_dept3${status.index}" type="checkbox" class="inputCheck" onclick="clickDept(this, '${status.index}', '1', '${spread1.spreadTime}')" /><label for="">본사,</label></li>
												  <li><input id="s1_dept4${status.index}" type="checkbox" class="inputCheck" onclick="clickDept(this, '${status.index}', '1', '${spread1.spreadTime}')" /><label for="">지역본부</label></li>
	                                        	  <li><input id="s1_dept5${status.index}" type="checkbox" class="inputCheck" onclick="clickDept(this, '${status.index}', '1', '${spread1.spreadTime}')" /><label for="">시공사,</label></li>
												  <li><input id="s1_dept6${status.index}" type="checkbox" class="inputCheck" onclick="clickDept(this, '${status.index}', '1', '${spread1.spreadTime}')" /><label for="">기타</label></li>
												</ul>
											</c:if>
												<script type="text/javascript">
													var deptStr1 = "${spread1.spreadDept}";
													for(var idx = 0 ; idx < deptStr1.length ; idx++)
													{
														var cb = $("#s1_dept" + (idx+1) + "${status.index}");
	
														if(deptStr1[idx] == "1")
															cb.attr("checked","checked");
													}
	
													clickDept(null, '${status.index}', '1', '${spread1.spreadTime}');
												</script>
	                                        </td>
											<td>
												<c:if test="${isModify != 'Y'}">
			                                        <textArea class="checkList3" id="s1_content${status.index}" readonly="readonly" style="color:gray">${spread1.smsContent}</textarea>
												</c:if>
			                                    <c:if test="${isModify == 'Y'}">
			                                        <textArea class="checkList3" id="s1_content${status.index}" onchange="clickDept(this, '${status.index}', '1', '${spread1.spreadTime}')">${spread1.smsContent}</textarea>
												</c:if>
											
	                                		</td>
										</tr>
									 </c:forEach>
									 
									 <c:forEach items="${spread2}"  var="spread2"  varStatus="status">
	                                    <tr>
	                                  		<c:if test="${status.first}">
												<th scope="row" rowspan="${spread2Cnt}">기상<br />특보</th>
	                                    	</c:if>
	                                        <td>
	                                        	${spread2.spreadTime}
	                                        	<!--<input type="text" class="inputText1" /> : <input type="text" class="inputText1" />-->
	                                        </td>
											<td>
												<c:if test="${isModify != 'Y'}">
		                                        	<ul class="checkList3">
		                                    		  <li><input id="s2_dept1${status.index}" type="checkbox" class="inputCheck" onclick="return false"/><label for="">환경청,</label></li>
		                                        	  <li><input id="s2_dept2${status.index}" type="checkbox" class="inputCheck" onclick="return false"/><label for="">지자체</label></li>
													  <li><input id="s2_dept3${status.index}" type="checkbox" class="inputCheck" onclick="return false"/><label for="">본사,</label></li>
													  <li><input id="s2_dept4${status.index}" type="checkbox" class="inputCheck" onclick="return false"/><label for="">지역본부</label></li>
		                                        	  <li><input id="s2_dept5${status.index}" type="checkbox" class="inputCheck" onclick="return false"/><label for="">시공사,</label></li>
													  <li><input id="s2_dept6${status.index}" type="checkbox" class="inputCheck" onclick="return false"/><label for="">기타</label></li>
													</ul>
												</c:if>
												<c:if test="${isModify == 'Y'}">
													<ul class="checkList3">
		                                    		  <li><input id="s2_dept1${status.index}" type="checkbox" class="inputCheck" onclick="clickDept(this, '${status.index}', '2', '${spread2.spreadTime}')"/><label for="">환경청,</label></li>
		                                        	  <li><input id="s2_dept2${status.index}" type="checkbox" class="inputCheck" onclick="clickDept(this, '${status.index}', '2', '${spread2.spreadTime}')"/><label for="">지자체</label></li>
													  <li><input id="s2_dept3${status.index}" type="checkbox" class="inputCheck" onclick="clickDept(this, '${status.index}', '2', '${spread2.spreadTime}')"/><label for="">본사,</label></li>
													  <li><input id="s2_dept4${status.index}" type="checkbox" class="inputCheck" onclick="clickDept(this, '${status.index}', '2', '${spread2.spreadTime}')"/><label for="">지역본부</label></li>
		                                        	  <li><input id="s2_dept5${status.index}" type="checkbox" class="inputCheck" onclick="clickDept(this, '${status.index}', '2', '${spread2.spreadTime}')"/><label for="">시공사,</label></li>
													  <li><input id="s2_dept6${status.index}" type="checkbox" class="inputCheck" onclick="clickDept(this, '${status.index}', '2', '${spread2.spreadTime}')"/><label for="">기타</label></li>
													</ul>
												</c:if>
												
												<script type="text/javascript">
														var deptStr2 = "${spread2.spreadDept}";
														for(var idx = 0 ; idx < deptStr2.length ; idx++)
														{
															var cb = $("#s2_dept" + (idx+1) + "${status.index}");
		
															if(deptStr2[idx] == "1")
																cb.attr("checked","checked");
														}
														clickDept(null, '${status.index}', '2', '${spread2.spreadTime}');
												</script>
	                                        </td>
											<td>
												<c:if test="${isModify != 'Y'}">
			                                        <textArea class="checkList3" id="s2_content${status.index}" readonly="readonly" style="color:gray">${spread2.smsContent}</textarea>
												</c:if>
												<c:if test="${isModify == 'Y'}">
			                                        <textArea class="checkList3" id="s2_content${status.index}" onchange="clickDept(this, '${status.index}', '2', '${spread2.spreadTime}')">${spread2.smsContent}</textarea>													
												</c:if>
												
											
	                                		</td>
										</tr>									 
									 </c:forEach>
									 

                                   </tbody>
								</table>
					<!--// 4.상황전파(사전조치) 현황 --> 
                    
                    <!-- 5.강우 현황 --> 
					     <h5 style="clear:both">5. 강우 현황</h5> 
							<table class="dataTable" style="clear:both">
									<colgroup>
										<col width="150" />
                                        <col />
										<col />
                                        <col />
                                        <col />
                                        <col />
                                        <col />
                                        <col />
									</colgroup>
									<thead>
										<tr>
											<th scope="col" rowspan="2" class="bgStyle">구분</th>
                                            <th scope="col" colspan="2" class="bgStyle">한강</th>
											<th scope="col" colspan="3" class="bgStyle">금강</th>
											<th scope="col" colspan="2" class="bgStyle">영산강</th>
										</tr>
                                        <tr>
											<th scope="col">여주</th>
                                            <th scope="col">충주</th>
                                            <th scope="col">부여</th>
                                            <th scope="col">공주</th>
                                            <th scope="col">연기</th>
                                            <th scope="col">나주</th>
                                            <th scope="col">광주</th>
										</tr>
								   </thead>
								   <tbody>
                                    <tr>
										<th scope="row">강수량(mm)</th>
                                        <td>${rainfall[0].rainFall}</td>
										<td>${rainfall[1].rainFall}</td>
                                        <td>${rainfall[10].rainFall}</td>
                                        <td>${rainfall[8].rainFall}</td>
                                        <td>${rainfall[9].rainFall}</td>
                                        <td>${rainfall[10].rainFall}</td>
                                        <td>${rainfall[12].rainFall}</td>
									</tr>
                                   </tbody>
                                   <thead>
                                   		<tr>
										<th scope="col" colspan="8" class="bgStyle" style="height:2px; padding:0"></th>
                                        </tr>
                                        <tr>
											<th scope="col" rowspan="2" class="bgStyle">구분</th>
                                            <th scope="col" colspan="7" class="bgStyle">낙동강</th>
										</tr>
                                        <tr>
											<th scope="col">부산</th>
                                            <th scope="col">창녕</th>
                                            <th scope="col">합천</th>
                                            <th scope="col">대구</th>
                                            <th scope="col">구미</th>
                                            <th scope="col">안동</th>
                                            <th scope="col">-</th>
										</tr>
								   </thead>
								   <tbody>
                                    <tr>
										<th scope="row">강수량(mm)</th>
                                        <td>${rainfall[2].rainFall}</td>
										<td>${rainfall[6].rainFall}</td>
										<td>${rainfall[3].rainFall}</td>
										<td>${rainfall[5].rainFall}</td>
										<td>${rainfall[4].rainFall}</td>
										<td>${rainfall[7].rainFall}</td>                                        
										<td> </td>                                        
									</tr>
                                   </tbody>                                
								</table>
                  					<p class="caption_bt" style="clear:both">
                  					* 기상청 자료 인용, 필요시 지역 추가 &middot; 변경 가능
				  					</p>
                               
					<!--// 5.강우 현황 --> 
                    
                    <!-- 6.고정식탁도계 전송현황 --> 
					     <h5 style="clear:both">6. 고정식탁도계 전송 현황</h5> 
							<table class="dataTable" style="clear:both">
									<colgroup>
										<col />
										<col />
                                        <col />
                                        <col />
                                        <col />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">소계</th>
                                            <th scope="col">낙동강</th>
											<th scope="col">금강</th>
											<th scope="col">영산강</th>
                                            <th scope="col">한강</th>
										</tr>
								   </thead>
								   <tbody>
                                    <tr>
										<td> ${r01TransCnt+r02TransCnt+r03TransCnt+r04TransCnt} / ${taksu1_cnt + taksu2_cnt + taksu3_cnt + taksu4_cnt}</td>
										<td> ${r02TransCnt} / ${taksu2_cnt}</td>
                                        <td> ${r03TransCnt} / ${taksu3_cnt}</td>
                                        <td> ${r04TransCnt} / ${taksu4_cnt}</td>
                                        <td> ${r01TransCnt} / ${taksu1_cnt}</td>
									</tr>
                                   </tbody>
								</table>
                              
                              
                            <h6>수계별 현황</h6> 
							<table class="dataTable">
									<colgroup>
										<col width="80px" />
										<col width="70px" />
                                        <col width="100px" />
                                        <col width="100px" />
                                        <col  />
                                        <col width="3px" />
                                        <col width="80px" />
										<col width="70px" />
                                        <col width="100px" />
                                        <col width="100px" />
                                        <col  />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">구분</th>
                                            <th scope="col">공구</th>
											<th scope="col">측정소</th>
											<th scope="col">전송</th>
                                            <th scope="col">비고<br />(사유)</th>
                                            <th scope="col" class="bgStyle"></th>
                                            <th scope="col">구분</th>
                                            <th scope="col">공구</th>
											<th scope="col">측정소</th>
											<th scope="col">전송</th>
                                            <th scope="col">비고<br />(사유)</th>
										</tr>
								   </thead>
								   <tbody>
								   
								   <c:forEach items="${taksu2}"  var="taksu2"  varStatus="status">
								   		<c:if test="${status.first}">
								   			<tr>
												<td rowspan="${taksu2_cnt}">낙동강</td>
	                                            <td>${taksu2.factName}</td>
												<td>${taksu2.branchName}</td>
	                                            <td>
	                                            	<c:if test="${taksu2.rxCnt >= 48}">
														O
													</c:if>
													<c:if test="${taksu2.rxCnt < 24}">
														X
													</c:if>
													<c:if test="${taksu2.rxCnt >= 24 && taksu2.rxCnt < 48}">
														△
													</c:if>
	                                            </td>
	                                            <td>
		                                            <c:if test="${isModify != 'Y'}">
			                                            ${taksu2.edataName}
													</c:if>
													<c:if test="${isModify == 'Y'}">
			                                            <select id="taksu2_${status.index}" name="" class="fixWidth14" onchange="errorCodeChange(this, '${taksu2.factCode}', '${taksu2.branchNo}')">
			                                            	<option value="none">선택해주세요</option>
				                                        	<c:forEach items="${errorCodeList}"  var="errorCode"  varStatus="stat">
																<option value="${errorCode.edataCode}">${errorCode.edataName}</option>
															</c:forEach>
											  			</select>
											  			<script type="text/javascript">
											  				$("#taksu2_${status.index} > option[value=${taksu2.edataCode}]").attr("selected","selected");
											  			</script>
													</c:if>
	                                            </td>
	                                            
	                                            <th scope="col" class="bgStyle" rowspan="${taksu2_cnt}"></th>
	                                            
	                                            <td rowspan="${taksu1_cnt}">한강</td>
	                                            <td>${taksu1[status.index].factName}</td>
												<td>${taksu1[status.index].branchName}</td>
	                                            <td>
	                                            	<c:if test="${taksu1[status.index].rxCnt >= 48}">
														O
													</c:if>
													<c:if test="${taksu1[status.index].rxCnt < 24}">
														X
													</c:if>
													<c:if test="${taksu1[status.index].rxCnt >= 24 && taksu1[status.index].rxCnt < 48}">
														△
													</c:if>
	                                            </td>
	                                            <td>
		                                            <c:if test="${isModify != 'Y'}">
			                                            ${taksu1[status.index].edataName}
													</c:if>
													<c:if test="${isModify == 'Y'}">
			                                            <select id="taksu1_${status.index}" name="" class="fixWidth14" onchange="errorCodeChange(this, '${taksu1[status.index].factCode}', '${taksu1[status.index].branchNo}')">
			                                            	<option value="none">선택해주세요</option>
				                                        	<c:forEach items="${errorCodeList}"  var="errorCode"  varStatus="stat">
																<option value="${errorCode.edataCode}">${errorCode.edataName}</option>
															</c:forEach>
											  			</select>
											  			<script type="text/javascript">
											  				$("#taksu1_${status.index} > option[value=${taksu1[status.index].edataCode}]").attr("selected","selected");
											  			</script>
													</c:if>
													
	                                            
	                                            </td>
											</tr>
								   		</c:if>
								   		<c:if test="${status.index > 0}">
								   			<tr>
												<td>${taksu2.factName}</td>
												<td>${taksu2.branchName}</td>
	                                            <td>
	                                            	<c:if test="${taksu2.rxCnt >= 48}">
														O
													</c:if>
													<c:if test="${taksu2.rxCnt < 24}">
														X
													</c:if>
													<c:if test="${taksu2.rxCnt >= 24 && taksu2.rxCnt < 48}">
														△
													</c:if>
	                                            </td>
	                                            <td>
		                                            <c:if test="${isModify != 'Y'}">
			                                            ${taksu2.edataName}
													</c:if>
													<c:if test="${isModify == 'Y'}">
			                                            <select id="taksu2_${status.index}" name="" class="fixWidth14" onchange="errorCodeChange(this, '${taksu2.factCode}', '${taksu2.branchNo}')">
			                                            	<option value="none">선택해주세요</option>
				                                        	<c:forEach items="${errorCodeList}"  var="errorCode"  varStatus="stat">
																<option value="${errorCode.edataCode}">${errorCode.edataName}</option>
															</c:forEach>
											  			</select>
											  			<script type="text/javascript">
											  				$("#taksu2_${status.index} > option[value=${taksu2.edataCode}]").attr("selected","selected");
											  			</script>
													</c:if>
	                                            </td>
	                                            
	                                            
	                                            <c:if test="${taksu1_cnt > status.index}">
			                                          <td>${taksu1[status.index].factName}</td>
													  <td>${taksu1[status.index].branchName}</td>
			                                          <td>
				                                          	<c:if test="${taksu1[status.index].rxCnt >= 48}">
																O
															</c:if>
															<c:if test="${taksu1[status.index].rxCnt < 24}">
																X
															</c:if>
															<c:if test="${taksu1[status.index].rxCnt >= 24 && taksu1[status.index].rxCnt < 48}">
																△
															</c:if>
			                                          </td>
			                                          <td>
					                                        <c:if test="${isModify != 'Y'}">
					                                             ${taksu1[status.index].edataName}
															</c:if>
															<c:if test="${isModify == 'Y'}">
					                                            <select id="taksu1_${status.index}" name="" class="fixWidth14" onchange="errorCodeChange(this, '${taksu1[status.index].factCode}', '${taksu1[status.index].branchNo}')">
					                                            	<option value="none">선택해주세요</option>
						                                        	<c:forEach items="${errorCodeList}"  var="errorCode"  varStatus="stat">
																		<option value="${errorCode.edataCode}">${errorCode.edataName}</option>
																	</c:forEach>
													  			</select>
													  			<script type="text/javascript">
													  				$("#taksu1_${status.index} > option[value=${taksu1[status.index].edataCode}]").attr("selected","selected");
													  			</script>
															</c:if>
			                                           </td>
	                                            </c:if>
	                                            
	                                            <c:if test="${taksu1_cnt <= status.index && taksu1_cnt+taksu3_cnt > status.index}">
	                                            	  <c:if test="${taksu1_cnt == status.index}">
		                                            	  <td rowspan="${taksu3_cnt}">금강</td>
	                                            	  </c:if>
			                                          <td>${taksu3[status.index-taksu1_cnt].factName}</td>
													  <td>${taksu3[status.index-taksu1_cnt].branchName}</td>
			                                          <td>
				                                          	<c:if test="${taksu3[status.index-taksu1_cnt].rxCnt >= 48}">
																O
															</c:if>
															<c:if test="${taksu3[status.index-taksu1_cnt].rxCnt < 24}">
																X
															</c:if>
															<c:if test="${taksu3[status.index-taksu1_cnt].rxCnt >= 24 && taksu3[status.index-taksu1_cnt].rxCnt < 48}">
																△
															</c:if>
			                                          </td>
			                                          <td>
			                                          		<c:if test="${isModify != 'Y'}">
					                                             ${taksu3[status.index-taksu1_cnt].edataName}
															</c:if>
															<c:if test="${isModify == 'Y'}">
					                                            <select id="taksu3_${status.index}" name="" class="fixWidth14" onchange="errorCodeChange(this, '${taksu3[status.index-taksu1_cnt].factCode}', '${taksu3[status.index-taksu1_cnt].branchNo}')">
					                                            	<option value="none">선택해주세요</option>
						                                        	<c:forEach items="${errorCodeList}"  var="errorCode"  varStatus="stat">
																		<option value="${errorCode.edataCode}">${errorCode.edataName}</option>
																	</c:forEach>
													  			</select>
													  			<script type="text/javascript">
													  				$("#taksu3_${status.index} > option[value=${taksu3[status.index-taksu1_cnt].edataCode}]").attr("selected","selected");
													  			</script>
															</c:if>
			                                           </td>
	                                            </c:if>
	                                            
	                                            
	                                            <c:if test="${taksu1_cnt + taksu3_cnt <= status.index && taksu1_cnt + taksu3_cnt + taksu4_cnt > status.index}">
	                                            	  <c:if test="${taksu1_cnt + taksu3_cnt == status.index}">
		                                            	  <td rowspan="${taksu4_cnt}">영산강</td>
	                                            	  </c:if>
			                                          <td>${taksu4[status.index-taksu1_cnt-taksu3_cnt].factName}</td>
													  <td>${taksu4[status.index-taksu1_cnt-taksu3_cnt].branchName}</td>
			                                          <td>
				                                          	<c:if test="${taksu4[status.index-taksu1_cnt-taksu3_cnt].rxCnt >= 48}">
																O
															</c:if>
															<c:if test="${taksu4[status.index-taksu1_cnt-taksu3_cnt].rxCnt < 24}">
																X
															</c:if>
															<c:if test="${taksu4[status.index-taksu1_cnt-taksu3_cnt].rxCnt >= 24 && taksu4[status.index-taksu1_cnt-taksu3_cnt].rxCnt < 48}">
																△
															</c:if>
			                                          </td>
			                                          <td>
				                                         <c:if test="${isModify != 'Y'}">
				                                           ${taksu4[status.index-taksu1_cnt-taksu3_cnt].edataName}
														</c:if>
														<c:if test="${isModify == 'Y'}">
				                                            <select id="taksu4_${status.index}" name="" class="fixWidth14" onchange="errorCodeChange(this, '${taksu4[status.index-taksu1_cnt-taksu3_cnt].factCode}', '${taksu4[status.index-taksu1_cnt-taksu3_cnt].branchNo}')">
				                                            	<option value="none">선택해주세요</option>
					                                        	<c:forEach items="${errorCodeList}"  var="errorCode"  varStatus="stat">
																	<option value="${errorCode.edataCode}">${errorCode.edataName}</option>
																</c:forEach>
												  			</select>
												  			<script type="text/javascript">
													  				$("#taksu4_${status.index} > option[value=${taksu4[status.index-taksu1_cnt-taksu3_cnt].edataCode}]").attr("selected","selected");
													  			</script>
														</c:if>
			                                           </td>
	                                            </c:if>
	                                            
	                                            
	                                            <c:if test="${(taksu1_cnt + taksu3_cnt + taksu4_cnt) <= status.index}">
	                                            	  <td></td>
	                                            	  <td></td>
													  <td></td>
			                                          <td></td>
			                                          <td></td>
	                                            </c:if>
											</tr>
								   		</c:if>
								   </c:forEach>
								   
								   <!--
                                    	<tr>
											<td rowspan="31">낙동강<br />(13/30)</td>
                                            <td>하</td>
											<td>1측정소(하)</td>
                                            <td></td>
                                            <td>
	                                            <select id="" name="" class="fixWidth14">
									  			</select>
                                            </td>
                                            
                                            <th scope="col" class="bgStyle" rowspan="32"></th>
                                            
                                            <td rowspan="9">금강<br />(7/9)</td>
                                            <td>행1</td>
											<td>1측정소(하)</td>
                                            <td></td>
                                            <td>
                                            <select id="" name="" class="fixWidth14">
								  			</select>
                                            </td>
										</tr>
								-->
                                   </tbody>
								</table>
                  					<p class="caption_bt" style="clear:both">
                  					* 사유 : 이상데이터 상태코드기준 적용, 전송시간(X:미전송, ○:정상전송, △:12시간 이하, 방제정보시스템 생성자료 기준)
				  					</p>
                                <!--// 6.고정식탁도계 전송현황 --> 
                                
                                
                              <!-- Btn -->   
                             <ul class="btnMenu">
								<c:if test="${isModify != 'Y' && data.compFlag != 'Y'}">
									<li><a href="javascript:modify()"><img src="<c:url value='/images/common/btn_edit.gif'/>" alt="수정" /></a></li>
								</c:if>
								<c:if test="${isModify == 'Y'}">
									<li><a href="javascript:save()" id="btnSave"><img src="<c:url value='/images/common/btn_save2.gif'/>" alt="저장" /></a></li>
									<li><a href="javascript:cancel()" id="btnCancel"><img src="<c:url value='/images/common/btn_cancel2.gif'/>" alt="취소" /></a></li>
								</c:if>
								<c:if test="${data.isMod != null && isModify != 'Y' && data.compFlag != 'Y'}">
									<li><a href="javascript:complete()" id="btnPrint"><img src="<c:url value='/images/common/btn_confirm.gif'/>" alt="완료" /></a></li>	
								</c:if>
								<c:if test="${data.compFlag == 'Y'}">
									<li><a href="javascript:report()" id="btnPrint"><img src="<c:url value='/images/common/btn_print2.gif'/>" alt="인쇄" /></a></li>
								</c:if>
									<li><a href="javascript:list()" id="btnPrint"><img src="<c:url value='/images/common/btn_list.gif'/>" alt="목록" /></a></li>
							</ul>
                            <!--// Btn -->      
                               
					</div>
					
                    
                         
                               
                    
				</div>
			</div>
		</div><!-- //content -->
		</form>
	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
<form name="report" method="post" action="<c:url value='/common/rdView.do'/>">
	<input type="hidden" name="mrdpath" />
	<input type="hidden" name="param" />
</form>
</body>
</html>
