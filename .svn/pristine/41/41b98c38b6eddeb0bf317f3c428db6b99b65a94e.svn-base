// div slider

var $common = {};

$common.slide = function(id, align, size) {
	var box = '#' + id;	
	var anim = {};
	
	anim[align] = size;
	$(box).animate(anim, 500);
};

// comma
$common.setComma = function(n) {
	var reg = /(^[+-]?\d+)(\d{3})/;
	n += '';

	while (reg.test(n)) {
		n = n.replace(reg, '$1' + ',' + '$2');
	}

	return n;
};

// popup
$common.popup = function(url, width, height) {
	open(url, "토양지하수정보시스템","left=0, top=0, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=auto, resizable=yes, width=" + width + ", height=" + height);
};

// result table to excel
$common.gridToExcel = function(stype, data) {
	var html = "<table border='1'><thead><tr>";
	var header = [];
	
	switch(stype) {
		case 1:
			header = ['지점코드', '지점명', '환경청', '조사년도', '조사반기', '음용여부', '용도', '주소', '수소이온농도(pH)', '총대장균군', '질산성질소(NO3-N)', '염소이온(Cl-)', '카드뮴(Cd)', '비소(As)', '시안(CN)', '수은(Hg)', '유기인', '페놀(Phenol)', '납(Pb)', '6가크롬(Cr+6)', '트리클로로에틸렌(TCE)', '테트라클로로에틸렌(PCE)', '1,1,1-TCE(1,1,1-TCE)', '벤젠(Benzene)', '톨루엔(Toluene)', '에틸벤젠(Ethyl Benzene)', '크실렌(Xylene)', '전기전도도(EC)'];
			break;
			
		case 2:
			header =['지점코드', '지점명', '시도구분', '조사년도', '조사반기', '음용여부', '용도', '주소', '수소이온농도(pH)', '총대장균군', '질산성질소(NO3-N)', '염소이온(Cl-)', '카드뮴(Cd)', '비소(As)', '시안(CN)', '수은(Hg)', '유기인', '페놀(Phenol)', '납(Pb)', '6가크롬(Cr+6)', '트리클로로에틸렌(TCE)', '테트라클로로에틸렌(PCE)', '1,1,1-TCE(1,1,1-TCE)', '벤젠(Benzene)', '톨루엔(Toluene)', '에틸벤젠(Ethyl Benzene)', '크실렌(Xylene)'];
			break;
			
		case 3:
			header =['지점코드', '지점명', '환경청', '조사년도', '지목', '면적', '주소', '카드뮴(Cd)', '구리(Cu)', '비소(As)', '수은(Hg)', '납(Pb)', '6가크롬(Cr+6)', '아연(Zn)', '니켈(Ni)', '불소(F)', '유기인', '폴리클로리네이티드비페닐(PCB)', '시안(CN)', '페놀(Phenol)', '석유계총탄화수소(TPH)', '트리클로로에틸렌(TCE)', '테트라클로로에틸렌(PCE)', '벤젠(Benzene)', '톨루엔(Toluene)', '에틸벤젠(Ethyl Benzene)', '크실렌(Xylene)', '벤조(a)피렌(Benpy)'];
			break;
			
		case 4:
			header =['지점코드', '지점명', '주소', '등록년도', '등록반기', '홀수', '시도구분', '총면적', '골프장유형', '농약사용면적', '농약미사용면적', '농약사용량 실물량', '농약사용량 성분량', '사용면적대비농약사용량 실물량', '사용면적대비농약사용량 성분량', '총면적대비농약사용량 실물량', '총면적대비농약사용량 성분량'];
			break;
	}
	
	for(var i in header) {
		html += "<th>" + header[i] + "</th>";
	}
	
	html += "</tr></thead><tbody>";
	
	for(var i in data) {
		html += "<tr>";
				
		for(var j in header) {
			var tempData = data[i][header[j]];
			
			if(tempData == undefined || tempData == null || tempData == "null") tempData= "";
			
			html += "<td>" + tempData + "</td>";
		}
		
		html += "</tr>";
	}
	
	html += "</tbody></table>";

	$("#excelHidden td").attr("style", "mso-number-format:'\\@'; text-align: center;");
	
	$("#excelHidden").empty();
	$("#excelHidden").append(html);

	$("#excel_val").val("");
	$("#excel_val").val(
		$("<div>").append(
			$('#excelHidden').clone()
		).html()
	);

	$("#form1").submit();
};

function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}
