package daewooInfo.stats.view;

import java.awt.Color;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.Ordered;
import org.springframework.core.io.Resource;
import org.springframework.web.context.support.ServletContextResource;
import org.springframework.web.servlet.view.AbstractView;

import com.softwarefx.StringAlignment;
import com.softwarefx.chartfx.server.ChartServer;
import com.softwarefx.chartfx.server.ContentLayout;
import com.softwarefx.chartfx.server.DockArea;
import com.softwarefx.chartfx.server.DockBorder;
import com.softwarefx.chartfx.server.FieldMap;
import com.softwarefx.chartfx.server.FieldUsage;
import com.softwarefx.chartfx.server.FileFormat;
import com.softwarefx.chartfx.server.Gallery;
import com.softwarefx.chartfx.server.MarkerShape;
import com.softwarefx.chartfx.server.TitleCollection;
import com.softwarefx.chartfx.server.TitleDockable;
import com.softwarefx.chartfx.server.adornments.GradientBackground;
import com.softwarefx.chartfx.server.adornments.SimpleBorder;
import com.softwarefx.chartfx.server.adornments.SimpleBorderType;
import com.softwarefx.chartfx.server.dataproviders.XmlDataProvider;
import com.softwarefx.chartfx.server.statistical.Statistics;

import daewooInfo.waterpolmnt.situationctl.view.ItemShape;

/**
 * 상관관계분석 차트를 가져오는 View Class
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 * 수정일			 수정자		수정내용
 * -------		--------	---------------------------
 * 2010.6.28	 김태훈		 최초 생성
 *
 */
public class ChartStatisticsView extends AbstractView implements Ordered {
	private Log log = LogFactory.getLog(ChartStatisticsView.class);
	private String chartTemplatePath;
	private int order = Integer.MAX_VALUE;
	
	/**
	 * 상관관계분석 차트를 생성한다.
	 * 
	 */	
	@SuppressWarnings("unchecked")
	@Override
	protected void renderMergedOutputModel(Map model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		
		String title = (String)model.get("title");
		List<String> itemNameList = (List<String>)model.get("itemNameList");
		List<String> itemCodeList = (List<String>)model.get("itemCodeList");
		Map<String, List> itemDataMap = (Map<String, List>)model.get("itemDataMap");
		//String constLine = (String)model.get("constLine");
		//Map<String, String> constantMap = (Map<String, String>)model.get("constantMap");
		Integer itemDataSize = (Integer)model.get("itemDataSize"); 
		String chartWidth = (String)model.get("width");
		String chartHeight = (String)model.get("height");
		String legBox = (String)model.get("legBox");
		int chartType = (Integer)model.get("chartType");
		String axisTitleYn = (String)model.get("axisTitleYn");
		String axisXTitle = (String)model.get("axisXTitle");
		String axisYTitle = (String)model.get("axisYTitle");
		if("null".equals(chartWidth)) chartWidth = "680";
		if("null".equals(chartHeight)) chartHeight = "500";
		Double MaxY = 0.0;
//		log.debug("axisXTitle ==== "+axisXTitle);
//		log.debug("axisYTitle ==== "+axisYTitle);
		if("TUR00".equals(axisXTitle))
			axisXTitle = "탁도";
		else if("TMP00".equals(axisXTitle))
			axisXTitle = "수온";
		else if("PHY00".equals(axisXTitle))
			axisXTitle = "pH";
		else if("DOW00".equals(axisXTitle))
			axisXTitle = "DO";
		else if("CON00".equals(axisXTitle))
			axisXTitle = "전기전도도";
		else if("FLW00".equals(axisXTitle))
			axisXTitle = "유량";
		else if("WLV00".equals(axisXTitle))
			axisXTitle = "수위";
		else if("TOF00".equals(axisXTitle))
			axisXTitle = "Chl-a";
		
		if("TUR00".equals(axisYTitle))
			axisYTitle = "탁도";
		else if("TMP00".equals(axisYTitle))
			axisYTitle = "수온";
		else if("PHY00".equals(axisYTitle))
			axisYTitle = "pH";
		else if("DOW00".equals(axisYTitle))
			axisYTitle = "DO";
		else if("CON00".equals(axisYTitle))
			axisYTitle = "전기전도도";
		else if("FLW00".equals(axisYTitle))
			axisYTitle = "유량";
		else if("WLV00".equals(axisYTitle))
			axisYTitle = "수위";
		else if("TOF00".equals(axisYTitle))
			axisYTitle = "Chl-a";
		
		//차트 생성
		ChartServer chart1 = new ChartServer(getServletContext(),request,response);
		Resource resource = new ServletContextResource(getServletContext(),getChartTemplatePath());
		chart1.importChart(FileFormat.XML, resource.getFile().getPath());
		
		//차트 크기 설정
		chart1.setWidth(Integer.parseInt(chartWidth));
		chart1.setHeight(Integer.parseInt(chartHeight));
		
		//외곽 테두리 없애기
		SimpleBorder myBorder = new SimpleBorder();
		myBorder.setType(SimpleBorderType.NONE);
		chart1.setBorder(myBorder);
		
		//그라데이션 없애기
		GradientBackground myBorder1 = new GradientBackground();
		myBorder1.setEffectArea(0);
		chart1.setBackground(myBorder1);
		
		// 툴바 유무 처리
		chart1.getToolBar().setVisible(false); 
		
		//레전드 박스 유무 처리
		if(legBox.equals("Y")) 
			chart1.getLegendBox().setVisible(true); 
		else 
			chart1.getLegendBox().setVisible(false); 
		
		//차트 타입 설정
		switch(chartType) {
			case 1 :
				chart1.setGallery(Gallery.LINES);
				break;
			case 2 :
				chart1.setGallery(Gallery.BAR);
				break;
			case 3 :
				chart1.setGallery(Gallery.SCATTER);
				break;
			default :
				chart1.setGallery(Gallery.LINES);
		}
		
		
		//타이틀 설정
		TitleDockable chartTitle = new TitleDockable();
		chartTitle.setAlignment(StringAlignment.CENTER);
		chartTitle.setFont(new java.awt.Font("굴림체",java.awt.Font.BOLD,10));
		chartTitle.setText(title);
		chartTitle.setTextColor(new java.awt.Color(99, 101, 99));
		
		TitleCollection tc = chart1.getTitles();
		tc.add(chartTitle);
		
		//축 타이틀 값이 있을경우 값 설정 
		if(axisTitleYn != null && axisTitleYn.equals("Y")) {
			chart1.getAxisX().getTitle().setText(axisXTitle);
			chart1.getAxisY().getTitle().setText(axisYTitle);
		}
		
		chart1.getAxisX().getLabelsFormat().setCustomFormat("#0.##");
		chart1.getAxisY().getLabelsFormat().setCustomFormat("#0.##");
		
		//차트 시리즈 및 포인트 설정
		chart1.getData().clear();
		chart1.getData().setSeries(itemCodeList.size());
		chart1.getData().setPoints(itemDataSize.intValue());
		
		
		log.debug("itemCodeList.size ==== "+itemCodeList.size());
		//차트에 보여질 데이터 설정
		for( int i=0; i < itemCodeList.size(); i++) {
			String code = itemCodeList.get(i);
			List<Map> dataList = itemDataMap.get(code);
			
			for( int j=0; j < dataList.size(); j++) {
				Map<String,String> data = dataList.get(j);
				String x = data.get("x");
				String y = data.get("y");
				chart1.getData().set(i, j, Double.valueOf(y));
				if(MaxY < Double.valueOf(y)) MaxY = Double.valueOf(y) + 1.0;
				chart1.getData().getLabels().set(j, x);
			}
		}
		
		//Series 텍스트 설정
		for(int i=0; i < itemNameList.size(); i++) {
			chart1.getSeries().get(i).setText(itemNameList.get(i));
		}
		
		//LegendBox 설정
		chart1.getLegendBox().setBorder(DockBorder.EXTERNAL);
		chart1.getLegendBox().setDock(DockArea.RIGHT);
		chart1.getLegendBox().setContentLayout(ContentLayout.CENTER);
		
		chart1.getAxisX().setStaggered(false);
		//if("Y".equals(constLine))chart1.getAxisY().setMax(MaxY);
		chart1.setAntialiasing(true);
		
		//차트 출력
		chart1.renderControl();
	}
	
	public String getChartTemplatePath() {
		return chartTemplatePath;
	}
	
	
	public void setChartTemplatePath(String chartTemplatePath) {
		this.chartTemplatePath = chartTemplatePath;
	}
	
	
	public void setOrder(int order) {
		this.order = order;
	}
	
	
	public int getOrder() {
		return this.order;
	}
	
}
