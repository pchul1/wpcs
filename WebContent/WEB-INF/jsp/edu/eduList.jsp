<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<sec:authorize ifAnyGranted="ROLE_USER">
		<script  type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
		</script> 
	</sec:authorize>
	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script  type='text/javascript'> -->
<!-- 			alert('로그인이 필요한 페이지 입니다'); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script>  -->
<%-- 	</sec:authorize> --%>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />

	<script type="text/javascript">

	// 교육 시작일
	var strDate = "";
	// 교육 종료일
	var endDate = "";

	var today = new Date(); 
	var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);

	yday = yday.getFullYear()+ addzero(yday.getMonth()+1) + addzero(yday.getDate());
	today = today.getFullYear()+ addzero(today.getMonth()+1) + addzero(today.getDate());

	
	$(function () {	

		// 파일 전송을 위해서..
		var frm = $('#insertForm');
		frm.ajaxForm(fileUploadCallback);
		frm.submit(function(){return false; });
		
		$('#addRow').click(addRow);
		$('#delRow').click(delRow);
		$('#save').click(save);
		$('#eduMemeberBtn').click(eduMemeberBtnFunc);
		
		$.datepicker.setDefaults({
		    monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		    showMonthAfterYear:true,
		    dateFormat: 'yymmdd',
		    showOn: 'both',
		    buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
		    buttonImageOnly: true
		});

		$("#strDate").datepicker({
		    buttonText: '시작일'
		    
		});
		$("#endDate").datepicker({
		    buttonText: '종료일'
		});

		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}

		if(strDate != null && strDate != "")
			$("#strDate").val(strDate);
		else
			$("#strDate").val(yday);

		if(endDate != null && endDate != "")
			$("#endDate").val(endDate);
		else
			$("#endDate").val(today);
		
		dataLoad();
		$("#dataList tr:odd").attr("class","add");
	});

	// 신청자 조회 (팝업)
	function eduMemeberBtnFunc()
	{
		var eduSeq = $("#eduSeq").val();
		var tmpMemberCnt = $("#tmpMemberCnt").val();
		if (tmpMemberCnt > 0) {
			var popupEduMemberList = window.open("<c:url value='/edu/eduMemberList.do?eduSeq="+eduSeq+"'/>",'popupEduMemberList','resizable=yes,scrollbars=yes,width=700,height=700');
		} else {
			alert('신청자가 없습니다.');
		}
	}
	
	// 첨부파일 콜백 함수
	function fileUploadCallback(data, state) 
	{
		if(data == "error") {
			alert("파일 전송중 오류가 발생하였습니다.");
			return false;
		} 

		alert("반영되었습니다.");

		var pageNo = $("#pageNo").val(); 
		if (pageNo == null) pageNo = 1;
		
		addRow();
		dataLoad(pageNo);
	}

	// 첨부파일 서버에 전송
	function FileUpload(){

		var mode = $("#mode").val();
		var eduSeq = $("#eduSeq").val();
		
		var title = $("#title").val();
		var content = $("#eduContent").val();
		var strDate = $("#strDate").val();
		var endDate = $("#endDate").val();
		var capacity = $("#capacity").val();
		
		if (title == '' || content == '' || strDate == '' || endDate == '') {
			alert('수정 및 입력하려는 데이터가 정확하지 않습니다.');
			return false;
		}

		var pageNo = $("#pageNo").val(); 
		if (pageNo == null) pageNo = 1;
		
		//파일전송
		var frm;
		frm = $('#insertForm');
		frm.attr("action","<c:url value='/edu/mergeEdu.do'/>");
		frm.submit(); 
	}
	
	// 입력폼 초기화
	function addRow()
	{
		$("#mode").val("insert");

		$("#eduSeq").val("0");
		$("#title").val("");
		$("#strDate").val(today);
		$("#endDate").val(today);
		$("#capacity").val("");
		$("#eduContent").val("");
		$("#atchFile").remove();
		$("#fileDiv").append("<input type='file' name='atchFile' id='atchFile' style='width:370px;'>");
		$("#fileDiv2").empty();
	}

	// 입력폼에 있는 값 삭제
	function delRow(eduSeq)
	{
		if ($("#mode").val() == 'update') {

			if (confirm('삭제하시겠습니까?')) {
				
				$("#mode").val("delete");
	
				var eduSeq = $("#eduSeq").val();
				
				var pageNo = $("#pageNo").val(); 
				if (pageNo == null) pageNo = 1;
				
				$.ajax({
					type: "POST",
					url: "<c:url value='/edu/deleteEdu.do'/>",
					data: {eduSeq:eduSeq
						},
					dataType:"json",
					beforeSend : function(){
						},
					success : function(result){
						if (result.updateCnt == '1') {
							alert('삭제되었습니다.');
							addRow();
							dataLoad(pageNo);
						} else {
							alert('삭제되지 않았습니다.\n잠시후 다시 시도 해 보시기 바랍니다.');
						}
					}
				});
			}
		} else {
			alert('삭제할 데이터가 없습니다.');
		}
		
	}

	// 입력폼에 있는 데이터 저장 / 수정
	function save()
	{	
		FileUpload();

		
	}

	// 목록에서 클릭시 ...
	function clickItemList(eduSeq)
	{
		$("#mode").val("update");
		$("#eduSeq").val(eduSeq);

		dataLoadDetail(eduSeq);
	}

	// 상세정보 가져오기
	function dataLoadDetail(eduSeq)
	{
		$.ajax({
			type: "POST",
			url: "<c:url value='/edu/eduDataList.do'/>",
			data: {eduSeq:eduSeq
				},	
			dataType:"json",
			beforeSend : function(){

					$("#title").val('불러 오는중...');
            		$("#eduContent").val('불러 오는중...');
            		$("#strDate").val('');
            		$("#endDate").val('');
            		$("#capacity").val('');
					
					$("#title").attr('enabled',false);
            		$("#eduContent").attr('enabled',false);
            		$("#strDate").attr('enabled',false);
            		$("#endDate").attr('enabled',false);
            		$("#capacity").attr('enabled',false);
				},				
			success : function(result){

				var tot = result['list'].length;

				if( tot <= 0 ){

		        }else{
	            	for(var i=0; i < tot; i++){
	                    var obj = result['list'][i];

	            		$("#title").val(obj.title);
	            		$("#eduContent").val(obj.content);
	            		$("#strDate").val(obj.strDate.replace(/-/gi,''));
	            		$("#endDate").val(obj.endDate.replace(/-/gi,''));
	            		$("#capacity").val(obj.capacity);

	            		$("#title").attr('enabled',true);
	            		$("#eduContent").attr('enabled',true);
	            		$("#strDate").attr('enabled',true);
	            		$("#endDate").attr('enabled',true);
	            		$("#capacity").attr('enabled',true);


	            		$("#requestCnt").empty();
	            		$("#requestCnt").append(obj.memberCnt);

	            		$("#tmpMemberCnt").val(obj.memberCnt);
	            		$("#atchFileId").val(obj.atchFileId);
	            		getAtchFileInfo(obj.atchFileId);

		        	}
	            }
			}
		});
	}

	// 첨부파일 정보 가져오기
	function getAtchFileInfo(fileId)
	{
		$.ajax({
			type: "POST",
			url: "<c:url value='/cmmn/selectFileInfs.do'/>",
			data: {param_atchFileId:fileId
				},	
			beforeSend : function(){
				},				
			success : function(result){
				//alert(result);
				$("#fileDiv2").empty();
				$("#fileDiv2").append(result);
			}
		});
	}
	
	// 데이터 목록 불러오기
	function dataLoad(pageNo)
	{
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/edu/eduDataList.do'/>",
			data: {title:$('#searchTitle').val(),
					pageIndex:pageNo
				},	
			dataType:"json",
			beforeSend : function(){
				$("#dataList").html("");
				$("#dataList").html("<tr><td colspan='5'>데이터를 불러오는 중 입니다...</td></tr>");	
				},				
			success : function(result){

				var tot = result['list'].length;

				if( tot <= 0 ){
	            	$("#dataList").html("<tr><td colspan='5'>조회 결과 없음 (조회 기간등 검색 조건을 확인해주세요.)</td></tr>");
	            }else{
	            	$("#dataList").html("");
	                for(var i=0; i < tot; i++){
	                    var obj = result['list'][i];
						var item;
	                   	item = "<tr style='cursor:hand' onclick=\"clickItemList('"+obj.eduSeq+"')\">"
								+"<td class='num'><span>"+obj.num+"</span></td>"
		                 		+"<td>"+obj.title+"</td>"
		                 		+"<td>"+obj.strDate+" ~ "+obj.endDate+"</td>"
		                 		+"<td>"+obj.capacity+"</td>"
		                 		+"<td>"+obj.memberCnt+"</td>"
	                 		 	+"</tr>";

	              		$("#dataList").append(item);

	              		$("#dataList tr:odd").attr("class","add");
	                }
	            }

	            // 페이징 정보
	            var pageStr = makePaginationInfo(result['paginationInfo']);
	            $("#pagination").empty();
	            $("#pagination").append(pageStr);

	            // 총건수 표시
	            $("#totcnt").empty();
				$("#totcnt").append("[총 "+result['paginationInfo'].totalRecordCount+"건]");	            	
			}
		});
	}

	// 페이지 번호 클릭	
	function linkPage(pageNo){
		$("#pageNo").val(pageNo);
		dataLoad(pageNo);				    
	} 
	</script>
</head>
<body>
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
		<div id="content" class="sub_situationmng">
			<div class="content_wrap page_opermng">
				<div class="inner_fluxmng">
					
					<div class="forms_gis">
						<!-- 등록 폼 -->
						<form name="insertForm" method="post" id="insertForm" class="formBox1" style="width:516px;" enctype="multipart/form-data">
							<input type="hidden" name="mode" id="mode" value="insert"/>
							<input type="hidden" name="pageNo" id="pageNo" value="1"/>
							<input type="hidden" name="eduSeq" id="eduSeq" value="0"/>
							<input type="hidden" name="tmpMemberCnt" id="tmpMemberCnt" value="0"/>
							<input type="hidden" name="atchFileId" id="atchFileId"/>
							<fieldset>
								<legend class="hidden_phrase">교육 관리 폼</legend>
								<h4>교육 관리</h4>
								<div class="overBox">
									<table class="dataTable">
										<colgroup>
											<col width="120px" />
											<col />
										</colgroup>					
										<thead>
											<tr>
												<th scope="row">교육명</th>
												<td>
													<input type="text" style="width:370px;" id="title" name="title"/>
												</td>
											</tr>
											<tr>
												<th scope="row">교육기간</th>
												<td style="text-align:left;">
													&nbsp;
													<input type="text" class="inputText" id="strDate" name="strDate" readonly="readonly" style="width:90px;"/>
													<span>~</span>
													<input type="text" class="inputText" id="endDate" name="endDate" readonly="readonly" style="width:90px;"/>
												</td>
											</tr>
											<tr>
												<th scope="row">교육정원</th>
												<td style="text-align:left;">
													&nbsp;
													<input style="width:100px;" type="text" id="capacity" name="capacity" onkeydown="onlyNumberInput()"/>명
												</td>
											</tr>
											<tr>
												<th scope="row">교육내용</th>
												<td>
													<textarea style="width:370px; height:250px; border:1;" id="eduContent" name="content"></textarea>
												</td>
											</tr>
											<tr>
												<th scope="row">첨부파일</th>
												<td>
													<div id="fileDiv">
														<input type="file" style="width:370px;" id="atchFile" name="atchFile"/>
													</div>
													<div id="fileDiv2">
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row">신청자 목록</th>
												<td style="text-align:left;">
													&nbsp;&nbsp;
													(<span id="requestCnt">0</span> 명이 신청중입니다.) <img src="<c:url value='/images/common/btn_search2.gif'/>" alt="조회" id="eduMemeberBtn" style="cursor:pointer;vertical-align:middle;"/>
												</td>
											</tr>
										</thead>
										<tbody id="sectionSpeedBody"></tbody>
									</table>
								</div>
								<ul class="btn">
									<li>
										<img src="<c:url value='/images/common/btn_new.gif'/>" alt="신규" id="addRow" style="cursor:pointer;"/>
									</li>
									<li>
										<img src="<c:url value='/images/common/btn_del.gif'/>" alt="삭제" id="delRow" style="cursor:pointer;"/>
									</li>
									<li>
										<img id="save" src="<c:url value='/images/common/btn_save.gif'/>" alt="저장" style="cursor:pointer;"/>
									</li>
								</ul>
							</fieldset>
						</form>
						<!-- //교육 등록(수정) -->
						<!-- 교육폼 -->
						<div class="form_overBox" style="width:500px;">
							<form action="" class="formBox2" onsubmit="return false;" >		
								<fieldset>
									<legend class="hidden_phrase">교육 검색 폼</legend>
									교육명
									<input type="text" id="searchTitle"/>
									<input id="search" onclick="javascript:dataLoad()" type="image" src="<c:url value='/images/common/btn_search3.gif'/>" alt="검색" />
								</fieldset>
							</form>
							<form action="" onsubmit="return false;">						
								<fieldset>
									<legend class="hidden_phrase">교육 목록</legend>
										<div class="overBox">
											<div align="right" id="totcnt">&nbsp;</div>
											<table class="dataTable">
												<colgroup>
													<col width="38px"/>
													<col />
													<col width="150px" />
													<col width="60px" />
													<col width="60px" />
												</colgroup>
												<thead>
													<tr>
														<th scope="col">NO</th>
														<th scope="col">교육명</th>
														<th scope="col">교육기간</th>
														<th scope="col">정원</th>
														<th scope="col">신청수</th>
													</tr>
												</thead>
												<tbody  id="dataList">&nbsp;</tbody>
											</table>
											<ul class="paginate" id="pagination"></ul>
										</div>
								</fieldset>
							</form>
						</div>
						
					</div>
				</div>
			</div>
		</div><!-- //content -->
	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>