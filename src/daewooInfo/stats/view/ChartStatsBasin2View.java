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

import com.softwarefx.DashStyle;
import com.softwarefx.StringAlignment;
import com.softwarefx.chartfx.server.AxisSection;
import com.softwarefx.chartfx.server.ChartServer;
import com.softwarefx.chartfx.server.ContentLayout;
import com.softwarefx.chartfx.server.DockArea;
import com.softwarefx.chartfx.server.DockBorder;
import com.softwarefx.chartfx.server.FileFormat;
import com.softwarefx.chartfx.server.Gallery;
import com.softwarefx.chartfx.server.MarkerShape;
import com.softwarefx.chartfx.server.TitleCollection;
import com.softwarefx.chartfx.server.TitleDockable;
import com.softwarefx.chartfx.server.adornments.GradientBackground;
import com.softwarefx.chartfx.server.adornments.SimpleBorder;
import com.softwarefx.chartfx.server.adornments.SimpleBorderType;

import daewooInfo.waterpolmnt.situationctl.view.ItemShape;

public class ChartStatsBasin2View extends AbstractView implements Ordered {
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	private Log log = LogFactory.getLog(ChartStatsBasin2View.class);
	/**
	 * @uml.property  name="chartTemplatePath"
	 */
	private String chartTemplatePath;
	/**
	 * @uml.property  name="order"
	 */
	private int order = Integer.MAX_VALUE;
	
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
		String sys = (String)model.get("sys");
		Float lawVl = (Float)model.get("lawVl");
		String itemCode = (String)model.get("itemCode");
		if(chartWidth == null || "".equals(chartWidth)) chartWidth = "680";
		if(chartHeight == null || "".equals(chartHeight)) chartHeight = "500";
		Double MaxY = 0.0;
		
		Double dLawVl = null;
		try
		{
			dLawVl = (double)lawVl;
		}
		catch(Exception e)
		{
			dLawVl = 50D;
		}
		
		ChartServer chart1 = new ChartServer(getServletContext(),request,response);
		Resource resource = new ServletContextResource(getServletContext(),getChartTemplatePath());
		chart1.importChart(FileFormat.XML, resource.getFile().getPath());
		
		chart1.setWidth(Integer.parseInt(chartWidth));
		chart1.setHeight(Integer.parseInt(chartHeight));
		
		chart1.getToolBar().setVisible(false); 
		
		if(legBox.equals("Y")) 
			chart1.getLegendBox().setVisible(true); 
		else 
			chart1.getLegendBox().setVisible(false); 

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

		//외곽 테두리 없애기
		SimpleBorder myBorder = new SimpleBorder();
		myBorder.setType(SimpleBorderType.NONE);
		chart1.setBorder(myBorder);

		//그라데이션 없애기
		GradientBackground myBorder1 = new GradientBackground();
		myBorder1.setEffectArea(0);
		chart1.setBackground(myBorder1);
		
		
		TitleDockable chartTitle = new TitleDockable();
		chartTitle.setAlignment(StringAlignment.CENTER);
		chartTitle.setFont(new java.awt.Font("굴림체",java.awt.Font.BOLD,10));
		chartTitle.setText(title);
		chartTitle.setTextColor(new java.awt.Color(99, 101, 99));		

		TitleCollection tc = chart1.getTitles();	
		tc.add(chartTitle);		
				
		if(axisTitleYn != null && axisTitleYn.equals("Y")) {			
			chart1.getAxisX().getTitle().setText(axisXTitle);
			chart1.getAxisY().getTitle().setText(axisYTitle);
		}		
				

		chart1.getAxisX().getLabelsFormat().setCustomFormat("#0.##");
		chart1.getAxisY().getLabelsFormat().setCustomFormat("#0.##");
		
		
		if("T".equals(sys))
		{
			String cd = itemCode;
		
			if(cd != null && (cd.equals("TUR00") || cd.equals("TUR")))
			{
				//경계선 표시
				AxisSection as = new AxisSection();
				as.setFrom(dLawVl);
				as.setTo(dLawVl+0.2D);
				as.setBackColor(new Color(255, 153, 51));
				as.setVisible(true);
				chart1.getAxisY().getSections().add(as);
			}
		}
		
		
		chart1.getData().clear();
		chart1.getData().setSeries(itemCodeList.size()); 
		chart1.getData().setPoints(itemDataSize.intValue()); 
		
		
		log.debug("itemCodeList.size ==== "+itemCodeList.size());
		for( int i=0; i < itemCodeList.size(); i++) {
			String code = itemCodeList.get(i);
			List<Map> dataList = itemDataMap.get(code);			

			//특정 항목별 그래프 색상 고정(일반항목 5가지만)
			Color color = ItemShape.getSeriesColor(code, sys);
			if(color != null)
				chart1.getSeries().get(i).setColor(color);
			
			//항목별 그래프 포인트 모양
			MarkerShape marker = ItemShape.getMarkerShape(code, sys);
			if(marker != null)
				chart1.getSeries().get(i).setMarkerShape(marker);
			
			if("MAX".equals(code) || "MIN".equals(code))
			{
				chart1.getSeries().get(i).getLine().setStyle(DashStyle.DOT);
			}
			
			if("FLW".equals(code))
			{
				chart1.getSeries().get(i).setAxisY(chart1.getAxisY2());
				chart1.getAxisY2().getGrids().getMajor().setVisible(false);
				chart1.getSeries().get(i).setGallery(Gallery.BAR);
				chart1.getSeries().get(i).setVolume((short)25);
			}
			
			for( int j=0; j < dataList.size(); j++) {
				Map<String,String> data = dataList.get(j);
				String x = data.get("x");
				String y = data.get("y");
				
				y = y.replaceAll(",", "");
				
				chart1.getData().set(i, j, Double.valueOf(y));
				if(MaxY < Double.valueOf(y)) MaxY = Double.valueOf(y) + 1.0;
				chart1.getData().getLabels().set(j, x);
			}
		}

		for(int i=0; i < itemNameList.size(); i++) {
			String unit = ItemShape.getItemUnit(itemCodeList.get(i));
			chart1.getSeries().get(i).setText(itemNameList.get(i) + unit);
		}
		
		//탁수모니터링시스템에서 탁수 선택시 기준값은 무조건 표시합니다
		if(chart1.getSeries().size() == 1 && (itemCodeList.get(0).equals("TUR00") || itemCodeList.get(0).equals("TUR")))
		{
			if(MaxY <= dLawVl)
			{
				Double max = dLawVl + 20;
				chart1.getAxisY().setMax(max);
			}
		}
		
		
		chart1.getLegendBox().setBorder(DockBorder.NONE);
		chart1.getLegendBox().setDock(DockArea.RIGHT);
		chart1.getLegendBox().setContentLayout(ContentLayout.CENTER);

		chart1.getAxisX().setStaggered(false);
			
		//if("Y".equals(constLine))chart1.getAxisY().setMax(MaxY);
		chart1.setAntialiasing(true);
		chart1.renderControl();
	}

	/**
	 * @return
	 * @uml.property  name="chartTemplatePath"
	 */
	public String getChartTemplatePath() {
		return chartTemplatePath;
	}


	/**
	 * @param chartTemplatePath
	 * @uml.property  name="chartTemplatePath"
	 */
	public void setChartTemplatePath(String chartTemplatePath) {
		this.chartTemplatePath = chartTemplatePath;
	}


	/**
	 * @param order
	 * @uml.property  name="order"
	 */
	public void setOrder(int order) {
		this.order = order;
	}
	
	/**
	 * @return
	 * @uml.property  name="order"
	 */
	public int getOrder() {
		return this.order;
	}

}
