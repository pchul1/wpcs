<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="/css/newFrontCommon.css"/>
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery-1.3.2.min.js'/>"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/tab.js"></script>
<script type="text/javascript">
	function MM_openBrWindow(theURL,winName,features) { //v2.0
		window.open(theURL,winName,features);
	}
</script>
</head>
<body>
<!-- wrap -->

<div id="wrap"> 
  
	<!--header -->
	<div class="header_wrap">
		<c:import url="/WEB-INF/jsp/pub/include/client_header.jsp"/>
	</div>
	<!--header --> 
  
	<!--container -->
	<div class="container_wrap">
		<div id="container"> 
		    
			<!--content wrap -->
			<div class="content_wrap">
				<div id="snb">
					<c:import url="/WEB-INF/jsp/pub/include/leftMenu1.jsp"/>
				</div>
				<div class="content">
					<!-- Navi -->
					<p class="spot">홈 &gt; 센터소개 &gt; <span class="point">보유장비 현황</span></p>
					<h3>보유장비 현황</h3>
					<!-- Navi -->
						<h4>방제센터 방제장비 보유 현황('16.12월말 기준)</h4>
						 <div class="section_table02">
							<table width="736" border="0" cellpadding="0" cellspacing="0" summary="장비명, 수계">
								<caption>방제센터 방제장비 보유 현황</caption>
								<tr>
									<th colspan="3" rowspan="2">장비명</th>
									<th colspan="5">수계<br/>(운영본부)</th>
								</tr>
								<tr>
									<th>합계</th>
									<th>한강<br/>(수도권동부)</th>
									<th>낙동강<br/>(대구경북)</th>
									<th>금강<br/>(충청권)</th>
									<th>영산강<br/>(호남권)</th>
									<!-- <th>본사</th>
									<th>비고</th> -->
								</tr>
								<tr style="font-weight:bold;border-top:2px solid #0066b3 !important;">
									<td colspan="3" style="background:rgba(237, 245, 250, 2)">합&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;계</td>
									<td>137<br/>(멀티콥터포함)</td>
									<td>34</td>
									<td>37</td>
									<td>37</td>
									<td>27</td>
									<!-- <td>27</td>
									<td>&nbsp;</td> -->
								</tr>
								<tr style="font-weight:bold;border-top:2px solid #0066b3 !important;">
									<td colspan="3" style="background:rgba(237, 245, 250, 2)">선&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;박</td>
									<td>24</td>
									<td>5</td>
									<td>9</td>
									<td>6</td>
									<td>4</td>
									<!-- <td>-</td>
									<td>&nbsp;</td> -->
								</tr>
								<tr>
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">수질감시선</td>
									<td>4</td>
									<td>-</td>
									<td>2</td>
									<td>1</td>
									<td>1</td>
									<!-- <td>-</td>
									<td>&nbsp;</td> -->
								</tr>
								<tr>
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">기동방제선</td>
									<td>2</td>
									<td>-</td>
									<td>2</td>
									<td>-</td>
									<td>-</td>
									<!-- <td>-</td>
									<td>&nbsp;</td> -->
								</tr>
								<tr>
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">방제바지선</td>
									<td>1</td>
									<td>-</td>
									<td>-</td>
									<td>1</td>
									<td>-</td>
									<!-- <td>-</td>
									<td>&nbsp;</td> -->
								</tr>
								<tr>
									<td rowspan="6" style="background:rgba(237, 245, 250, 1)">보조방제선</td>
									<td colspan="2">소계</td>
									<td>17</td>
									<td>5</td>
									<td>5</td>
									<td>4</td>
									<td>3</td>
									<!-- <td>-</td>
									<td>&nbsp;</td> -->
								</tr>
								<tr>
									<td colspan="2">FRP선</td>
									<td>3</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>-</td>
									<!-- <td>-</td>
									<td>&nbsp;</td> -->
								</tr>
								<tr>
									<td colspan="2">모터고무보트(8인)</td>
									<td>5</td>
									<td>1</td>
									<td>2</td>
									<td>1</td>
									<td>1</td>
									<!-- <td>-</td>
									<td>&nbsp;</td> -->
								</tr>
								<tr>
									<td colspan="2">동력고무보트(2인)</td>
									<td>4</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<!-- <td>-</td>
									<td>2인승</td> -->
								</tr>
								<tr>
									<td colspan="2">립 보트</td>
									<td>4</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<!-- <td>-</td>
									<td>&nbsp;</td> -->
								</tr>
								<tr>
									<td colspan="2">알루미늄보트</td>
									<td>1</td>
									<td>1</td>
									<td>-</td>
									<td>-</td>
									<td>-</td>
									<!-- <td>-</td>
									<td>&nbsp;</td> -->
								</tr>
								<tr style="font-weight:bold;border-top:2px solid #0066b3 !important;">
									<td colspan="3" style="background:rgba(237, 245, 250, 2)">차&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;량</td>
									<td>31</td>
									<td>9</td>
									<td>7</td>
									<td>11</td>
									<td>4</td>
									<!-- <td>3</td>
									<td>&nbsp;</td> -->
								</tr>
								<!-- <tr>
									<td rowspan="4" style="background:rgba(237, 245, 250, 1)">차량</td>
									<td colspan="2">소계</td>
									<td>26</td>
									<td>5</td>
									<td>8</td>
									<td>5</td>
									<td>5</td>
									<td>3</td>
									<td>&nbsp;</td>
								</tr> -->
								<tr style="border-top:2px solid #0066b3 !important;">
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">기동방제차량</td>
									<td>5</td>
									<td>1</td>
									<td>2</td>
									<td>1</td>
									<td>1</td>
									<!-- <td>-</td>
									<td>3.5톤</td> -->
								</tr>
								<tr>
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">방제장비견인차량</td>
									<td>6</td>
									<td>1</td>
									<td>2</td>
									<td>2</td>
									<td>1</td>
									<!-- <td>-</td>
									<td>1톤</td> -->
								</tr>
								<tr>
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">1톤 기동방제차량</td>
									<td>4</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<!-- <td>-</td>
									<td>1톤</td> -->
								</tr>
								<tr>
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">궤도형운반차량</td>
									<td>1</td>
									<td>-</td>
									<td>-</td>
									<td>1</td>
									<td>-</td>
									<!-- <td>(3)</td>
									<td>()임차차량</td> -->
								</tr>
								<tr>
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">방제물품 트레일러</td>
									<td>12</td>
									<td>6</td>
									<td>-</td>
									<td>6</td>
									<td>-</td>
									<!-- <td>-</td>
									<td>()유회수기용</td> -->
								</tr>
								<tr>
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">전동지게차(2.0톤)</td>
									<td>1</td>
									<td>-</td>
									<td>1</td>
									<td>-</td>
									<td>-</td>
									<!-- <td>-</td>
									<td>2톤</td> -->
								</tr>
								<tr>
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">4륜오토바이</td>
									<td>2</td>
									<td>-</td>
									<td>1</td>
									<td>-</td>
									<td>1</td>
									<!-- <td>-</td>
									<td></td> -->
								</tr>
								<tr style="font-weight:bold;border-top:2px solid #0066b3 !important;">
									<td colspan="3" style="background:rgba(237, 245, 250, 2)">유회수기</td>
									<td>15</td>
									<td>4</td>
									<td>4</td>
									<td>4</td>
									<td>3</td>
									<!-- <td>-</td>
									<td>&nbsp;</td> -->
								</tr>
								<tr style="border-top:2px solid #0066b3 !important;">
									<td rowspan="3" style="background:rgba(237, 245, 250, 1)">대형</td>
									<td colspan="2">소계</td>
									<td>8</td>
									<td>2</td>
									<td>2</td>
									<td>2</td>
									<td>2</td>
									<!-- <td>-</td>
									<td>&nbsp;</td> -->
								</tr>
								<tr>
									<td colspan="2">경질유용</td>
									<td>4</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<!-- <td>-</td>
									<td></td> -->
								</tr>
								<tr>
									<td colspan="2">중질유용</td>
									<td>4</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<!-- <td>-</td>
									<td></td> -->
								</tr>
								<tr>
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">소형</td>
									<td>4</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<!-- <td>-</td>
									<td></td> -->
								</tr>
								<tr>
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">진공흡입기</td>
									<td>3</td>
									<td>1</td>
									<td>1</td>
									<td>1</td>
									<td>-</td>
									<!-- <td>-</td>
									<td></td> -->
								</tr>
								<tr style="border-top:2px solid #0066b3 !important;">
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">멀티콥터<sup>1)</sup></td>
									<td>2</td>
									<td>-</td>
									<td>-</td>
									<td>-</td>
									<td>-</td>
									<!-- <td>1</td>
									<td></td> -->
								</tr>
								<tr style="border-top:2px solid #0066b3 !important;">
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">에어텐트</td>
									<td>1</td>
									<td>-</td>
									<td>1</td>
									<td>-</td>
									<td>-</td>
									<!-- <td>1</td>
									<td></td> -->
								</tr>
								<tr style="border-top:2px solid #0066b3 !important;">
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">이동형측정기기</td>
									<td>16</td>
									<td>4</td>
									<td>4</td>
									<td>4</td>
									<td>4</td>
									<!-- <td>1</td>
									<td></td> -->
								</tr>
								<tr style="border-top:2px solid #0066b3 !important;">
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">측정기기 5종<sup>2)</sup></td>
									<td>24</td>
									<td>6</td>
									<td>6</td>
									<td>6</td>
									<td>6</td>
									<!-- <td>1</td>
									<td></td> -->
								</tr>
								<tr style="border-top:2px solid #0066b3 !important; border-bottom:2px solid #0066b3 !important;">
									<td colspan="3" style="background:rgba(237, 245, 250, 1)">기타 보조방제장비 5종<sup>3)</sup></td>
									<td>24</td>
									<td>6</td>
									<td>6</td>
									<td>6</td>
									<td>6</td>
									<!-- <td>1</td>
									<td></td> -->
								</tr>
							</table>
							1) 멀티콥터 : 본사 수질오염방제팀 보유<br/>
							2) 측정기기 5종 : 거리측정기, 수심측정기, 유속측정기, 일반항목측정기, 점도계<br/>
							3) 기타 보조방제장비 5종 : 동력분무기, 발전기, 양수기, 예초기, 전동선외기<br/><br/><br/>
						</div>
					<div class="list_type01" style="margin-top:40px;">
						<h4>방제지원 장비</h4>
						<div style="width: 800px;">
							<div style="width: 390px; float: left;">
								<img src="/images/new/new_pic_01.gif" alt="방제바지선"/>
								<p style="text-align:center;font-weight:bold;">방제바지선</p>
							</div>
							<div style="width: 390px; float: left;">
								<img src="/images/new/new_pic_02.gif" alt="기동방제선" />
								<p style="text-align:center;font-weight:bold;">기동방제선</p>
							</div>
							<div style="width: 390px; float: left;">
								<img src="/images/new/new_pic_03.gif" alt="보조방제선-립 보트" />
								<p style="text-align:center;font-weight:bold;">보조방제선-립 보트</p>
							</div>
							<div style="width: 390px; float: left;">
								<img src="/images/new/new_pic_04.gif" alt="기동방제차량" />
								<p style="text-align:center;font-weight:bold;">기동방제차량</p>
							</div>
							<div style="width: 390px; float: left;">
								<img src="/images/new/new_pic_05.gif" alt="진공흡입기" />
								<p style="text-align:center;font-weight:bold;">진공흡입기</p>
							</div>
							<div style="width: 390px; float: left;">
								<img src="/images/new/new_pic_06.gif" alt="유회수기" />
								<p style="text-align:center;font-weight:bold;">유회수기</p>
							</div>
							<div style="width: 390px; float: left;">
								<img src="/images/new/new_pic_07.gif" alt="동력분무기" />
								<p style="text-align:center;font-weight:bold;">동력분무기</p>
							</div>
						</div>
					</div>
					
					
						 <div class="section_table02" style="margin-top:60px;">
						 <h4>방제센터 방제물품 보유 현황('16.12월말 기준)</h4><br/>
							<table width="736" border="0" cellpadding="0" cellspacing="0" summary="구분,단위,계,각 수계로 이루어짐">
								<caption>방제센터 방제물품 보유 현황</caption>
								<tr>
								<th>구 분</th>
								<th>단위</th>
								<th>계</th>
								<th>한강<br/>(수도권동부)</th>
								<th>낙동강<br/>(대구경북권)</th>
								<th>금강<br/>(충청권)</th>
								<th>영산강<br/>(호남권)</th>
								</tr>
								<tr style="border-top:2px solid #0066b3 !important;">
									<td>오일펜스</td>
									<td>m</td>
									<td>6,400</td>
									<td>1,600</td>
									<td>2,220</td>
									<td>1,540</td>
									<td>1,040</td>
								</tr>
								<tr>
									<td>유흡착포<br/>(매트형)</td>
									<td>Box</td>
									<td>573</td>
									<td>114</td>
									<td>265</td>
									<td>151</td>
									<td>43</td>
								</tr>
								<tr>
									<td>유흡착제<br/>(롤형)</td>
									<td>Box</td>
									<td>451</td>
									<td>122</td>
									<td>173</td>
									<td>110</td>
									<td>46</td>
								</tr>
								<tr>
									<td>유흡착제<br/>(붐형)</td>
									<td>Box</td>
									<td>375</td>
									<td>70</td>
									<td>172</td>
									<td>105</td>
									<td>28</td>
								</tr>
								<tr>
									<td rowspan="2">유겔화제</td>
									<td>5kg/can</td>
									<td>103</td>
									<td>10</td>
									<td>68</td>
									<td>13</td>
									<td>12</td>
								</tr>
								<tr>
									<td>10kg/box</td>
									<td>48</td>
									<td>6</td>
									<td>20</td>
									<td>12</td>
									<td>10</td>
								</tr>
								<tr>
									<td>유처리제</td>
									<td>캔<br/>(18ℓ)</td>
									<td>186</td>
									<td>13</td>
									<td>113</td>
									<td>40</td>
									<td>20</td>
								</tr>
								<tr>
									<td>회수유<br/>저장용기</td>
									<td>개</td>
									<td>80</td>
									<td>12</td>
									<td>48</td>
									<td>10</td>
									<td>10</td>
								</tr>
								<tr>
									<td>수동분무기</td>
									<td>개</td>
									<td>25</td>
									<td>6</td>
									<td>9</td>
									<td>7</td>
									<td>3</td>
								</tr>
								<tr>
									<td>전동분무기</td>
									<td>개</td>
									<td>16</td>
									<td>4</td>
									<td>4</td>
									<td>4</td>
									<td>4</td>
								</tr>
								<tr>
									<td>일회용방제복</td>
									<td>벌</td>
									<td>916</td>
									<td>188</td>
									<td>444</td>
									<td>70</td>
									<td>214</td>
								</tr>
								<tr>
									<td>긴급처리Bag</td>
									<td>개</td>
									<td>7</td>
									<td>2</td>
									<td>3</td>
									<td>1</td>
									<td>1</td>
								</tr>
								<tr>
									<td>기름응고제</td>
									<td>팩</td>
									<td>200</td>
									<td>40</td>
									<td>80</td>
									<td>40</td>
									<td>40</td>
								</tr>
								<tr>
									<td>기름제거붐</td>
									<td>개</td>
									<td>15</td>
									<td>3</td>
									<td>6</td>
									<td>3</td>
									<td>3</td>
								</tr>
								<tr>
									<td>필로우</td>
									<td>개</td>
									<td>10</td>
									<td>2</td>
									<td>4</td>
									<td>2</td>
									<td>2</td>
								</tr>
								<tr style="border-bottom:2px solid #0066b3 !important;">
									<td>개인보호구 세트<sup>1)</sup></td>
									<td>set</td>
									<td>16</td>
									<td>4</td>
									<td>4</td>
									<td>4</td>
									<td>4</td>
								</tr>
							</table>
							1) 개인보호구 세트 : 방독마스크(유기화합물용), 방독마스크 필터(유기화합물용), 보호안경, 안전장갑(내화학용), 반장화, 보호복(화학물질용 4형식)
						</div>
				</div>
			</div>
			<!--content wrap --> 
		    
		</div>
	</div>
	<!--container --> 
  
	<!--footer -->
	<div class="footer_wrap">
		<div id="footer">
			<c:import url="/WEB-INF/jsp/pub/include/client_footer.jsp" />
		</div>
	</div>
	<!--footer --> 
  
</div>
<!-- wrap -->

</body>
</html>