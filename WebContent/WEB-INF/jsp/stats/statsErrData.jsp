<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='css/content.css'/>" />
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
			<div class="content_wrap page_waterpolstat">
				<div class="inner_riverstat">
					<!-- 유역별 통계 검색 -->
					<div class="search_all_wrap">
					<form action="" onsubmit="return false">
						<dl>
							<dt><img src="<c:url value='/images/content/tit_search_div.gif'/>" alt="구분" /></dt>
							<dd>
								<ul class="checkList">
									<li><input type="radio" class="inputRadio" id="" name="" value="1" checked="checked" /><label for="">수동 판별</label></li>
								  	<li><input type="radio" class="inputRadio" id="" name="" value="2"/><label for="">자동 판별</label></li>
								</ul>
							</dd>
						</dl>
                        <dl>
							<dt><img src="<c:url value='/images/content/tit_search_system.gif'/>" alt="시스템" /></dt>
							<dd>
								<select class="fixWidth13" id="system" name="system">
										<option value="" selected="selected">전체</option>
                                        <option value="U">이동형측정기기</option>
<!-- 										<option value="T">탁수모니터링</option> -->
										<option value="A">국가수질자동측정망</option>
								</select>
							</dd>
							<dt><img src="<c:url value='/images/content/tit_search_branch.gif'/>" alt="측정소" /></dt>
							<dd>
								<select class="fixWidth7"   id="sugye" name="sugye">
								   <option value="R01">한강</option>
								   <option value="R02">낙동강</option>
								   <option value="R03">금강</option>
								   <option value="R04">영산강</option>
								</select>
								<span>&gt;</span>
									<select class="fixWidth11"  id="factCode" name="factCode">
										<option value="none">선택</option>
									</select>
								<span>&gt;</span>
								<select class="fixWidth11"  id="branchNo" name="branchNo">
									<option value="1">제 1 측정소</option>
								</select>
							</dd>
						</dl>
                        
						<div class="btnInBox">
						  <dl>
							<dt><img src="<c:url value='/images/content/tit_search_div.gif'/>" alt="구분" /></dt>
							<dd>
								<ul class="checkList">
									<li><input type="radio" class="inputRadio" id="" name="gubun" value="1" /><label for="">일간</label></li>
								  	<li><input type="radio" class="inputRadio" id="" name="gubun" value="2" checked="checked" /><label for="">월간</label></li>
									<li><input type="radio" class="inputRadio" id="" name="gubun" value="3" /><label for="">분기</label></li>
                                    <li><input type="radio" class="inputRadio" id="" name="gubun" value="3" /><label for="">년간</label></li>
								</ul>
							</dd>
							<dt><label for=""></label></dt>
							<dd>
								<p class="part1">
                               	  <select id="year" name="year" style="width:80px;"><option>2010년</option>
								  </select>
                                    <select id="quarter" name="quarter" style="width:60px;"><option>4분기</option>
									</select>
                                    <select id="month" name="month" style="width:60px;"><option>12월</option>
									</select>
                                    <select id="day" name="day" style="width:60px;display:none"><option>30일</option>
									</select>
								</p>
							</dd>
						</dl>
						   
                           <p class="btn_search"><input id="search" type="image" src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" /></p>
					  </div>
					</form>
                   
				    </div>
					<!-- //유역별 통계 검색 -->
					
                    <div class="showData">
						
                        <p class="p_total_cnt2">[ 2010년 12월 월간 통계 ]</p>
                        
                        <ul class="dataBtn">
							<li><img id="chart" src="<c:url value='/images/common/btn_graph.gif'/>" alt="그래프" /></li>
							<li><img id="excel" src="<c:url value='/images/common/btn_excel.gif'/>" alt="엑셀" /></li>
						</ul>
                    
						<!-- 유역별 통계 현황 -->
						<div class="data_wrap">
							<div class="overBox">
								<table class="dataTable">
									<colgroup>
										<col />
										<col />
										<col />
										<col />
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
											<th scope="col" rowspan="2">기간</th>
                                            <th scope="col" rowspan="2">시스템</th>
											<th scope="col" rowspan="2">수계</th>
											<th scope="col" rowspan="2">지역</th>
											<th scope="col" rowspan="2">측정소</th>
											<th scope="col" colspan="6">이상 데이터 유형</th>
										</tr>
										<tr>
											<th scope="col">1</th>
											<th scope="col">2</th>
											<th scope="col">3</th>
                                            <th scope="col">4</th>
                                            <th scope="col">5</th>
                                            <th scope="col">...</th>
										</tr>
									</thead>
									<tbody id="statsBody">
                                    <tr>
										<td>3월</td>
                                        <td>탁수</td>
										<td>한강</td>
										<td>제1공구</td>
										<td>제1측정소</td>
										<td>-</td>
										<td>-</td>
										<td>-</td>
										<td>-</td>
                                        <td>-</td>
										<td>-</td>
									</tr>
									<tr class="add">
										<td>3월</td>
                                        <td>탁수</td>
										<td>한강</td>
										<td>제1공구</td>
										<td>제1측정소</td>
										<td>-</td>
										<td>-</td>
										<td>-</td>
										<td>-</td>
                                        <td>-</td>
										<td>-</td>
									</tr>
                                    </tbody>
								</table>
							</div>
						</div>
						<!-- //유역별 통계 현황 -->
					</div><!-- //showData -->
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
