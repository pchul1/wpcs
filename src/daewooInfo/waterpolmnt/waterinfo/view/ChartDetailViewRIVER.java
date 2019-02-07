package daewooInfo.waterpolmnt.waterinfo.view;

import java.awt.Color;
import java.util.HashMap;
import java.util.Iterator;
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
import com.softwarefx.chartfx.server.AxisPosition;
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

public class ChartDetailViewRIVER extends AbstractView implements Ordered {
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	private Log log = LogFactory.getLog(ChartDetailViewRIVER.class);
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
		String wLine = (String)model.get("wLine");
		String image = (String)model.get("image");
		String sys = (String)model.get("sys");
		Float lawVl = (Float)model.get("lawVl");
		if(chartWidth == null || "".equals(chartWidth)) chartWidth = "680";
		if(chartHeight == null || "".equals(chartHeight)) chartHeight = "500";
		Double MaxY = 0.0;
		Double MinY = 9999999D;
		
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
		
		chart1.setContextMenus(false);
		
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
				
		chart1.getAxisX().getLabelsFormat().setCustomFormat("#0.###");
		chart1.getAxisY().getLabelsFormat().setCustomFormat("#0.###");
		chart1.getAxisY2().getLabelsFormat().setCustomFormat("#0.###");
		
		if(axisTitleYn != null && axisTitleYn.equals("Y")) {			
			chart1.getAxisX().getTitle().setText(axisXTitle);
			chart1.getAxisY().getTitle().setText(axisYTitle);
		}		
				
		//sub Y축 관련
		chart1.getData().clear();
		chart1.getAxisY2().setVisible(true);
		chart1.getAxisY2().setPosition(AxisPosition.FAR);
		
		if(wLine != null || "Y".equals(wLine))
		{
			//차트 위치 조정
			//chart1.getPlotAreaMargin().setBottom(10);
			chart1.getPlotAreaMargin().setTop(10);
			//chart1.getPlotAreaMargin().setLeft(5);
			//chart1.getPlotAreaMargin().setRight(15);
			
			if(itemCodeList.size() > 0)
			{
				String cd = itemCodeList.get(0);
			
				if(cd.equals("TUR00") || cd.equals("TUR"))
				{
					//경계선 표시
					AxisSection as = new AxisSection();
					as.setFrom(50);
					as.setTo(51);
					as.setBackColor(new Color(248, 62, 7));
					as.setVisible(true);
					chart1.getAxisY().getSections().add(as);
				}
			}
		}
		
		
		if("T".equals(sys))
		{
			if(itemCodeList.size() == 1) //한 항목 선택일 때
			{
				String cd = itemCodeList.get(0);
			
				if(cd.equals("TUR00") || cd.equals("TUR"))
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
		}
		
		
		chart1.getData().clear();
		chart1.getData().setSeries(itemCodeList.size()); 
		chart1.getData().setPoints(itemDataSize.intValue()); 
		
		//SUB Y축 관련
		double sMaxY = 0.0;
		Map<Integer, Double> sMax = new HashMap<Integer, Double>();
		
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
			
			//Sub Y축 관련
			sMaxY = 0.0;
		
			
			for( int j=0; j < dataList.size(); j++) {
				Map<String,String> data = dataList.get(j);
				String x = data.get("x");
				String y = data.get("y");
				
				if(y == null || "0".equals(y) || (!"A".equals(sys) && "0.00".equals(y)))
				{
						continue;
				}
				y = y.replace(",", "");
				
				chart1.getData().set(i, j, Double.valueOf(y));
				if(MaxY < Double.valueOf(y)) MaxY = Double.valueOf(y);
				if(MinY > Double.valueOf(y)) MinY = Double.valueOf(y);
				chart1.getData().getLabels().set(j, x);
				
				//Sub Y축 관련
				if(sMaxY < Double.valueOf(y)) sMaxY = Double.valueOf(y);
			}
			
			//Sub Y축 관련
			sMax.put(i, sMaxY);
		}
		
		if(MinY > 0)
			MinY = 0D;
		
		
		Double minMax = 999999D;
		//Max값들 중에 최대값을 제외한 평균
		Double yMaxAvg =  0D;
		for(int idx = 0 ; idx < sMax.size() ; idx++)
		{
			Double nMax = sMax.get(idx);
			if(nMax.doubleValue() == MaxY.doubleValue())
				continue;
			
			yMaxAvg+=nMax;
		}
		
		yMaxAvg = yMaxAvg / (sMax.size() - 1);
		
		//50% 추가
		minMax = yMaxAvg + (yMaxAvg/2);
		
		Boolean yLabelFlag = false;
		Boolean y2LabelFlag = false;
		
		for(int i=0; i < itemNameList.size(); i++) {
			//SUB Y축 관련
			if(chart1.getSeries().size() > 1 && MaxY >= minMax)
			{
				if(sMax.get(i) > minMax.doubleValue())
				{
					chart1.getSeries().get(i).setAxisY(chart1.getAxisY2());
					if(!y2LabelFlag)
					{
						chart1.getAxisY2().getTitle().setText(itemNameList.get(i));
						chart1.getAxisY2().getTitle().setSeparation(14);
						chart1.getPlotAreaMargin().setRight(10);
						chart1.getAxisY2().getTitle().setLineAlignment(StringAlignment.FAR);
						y2LabelFlag = true;
					}
				}
				else
				{
					if(!yLabelFlag)
					{
						chart1.getAxisY().getTitle().setText(itemNameList.get(i));
						chart1.getAxisY().getTitle().setSeparation(-10);
						chart1.getPlotAreaMargin().setLeft(0);
						chart1.getAxisY().getTitle().setLineAlignment(StringAlignment.NEAR);
						yLabelFlag = true;
					}
				}
			}
		}
		
		//SUB Y축 관련
		if(chart1.getSeries().size() > 1)
		{
			chart1.getAxisY().setMin(MinY);
			chart1.getAxisY().setMax(minMax);
			//chart1.getAxisY().setStep(10);
			
			if(MaxY <= 1 && MaxY > 0  && !itemCodeList.get(0).equals("TUR00"))
				chart1.getAxisY().setStep(0.1);
			
			
			if(MaxY >= minMax)
			{
				chart1.getAxisY2().setMin(MinY);
				
				double tmpMax = MaxY + ((((int)(MaxY/50)+1)*50) - MaxY);
				
				chart1.getAxisY2().setMax(tmpMax);
			
				chart1.getAxisY2().getGrids().getMajor().setVisible(false);
			}
			else
			{
				chart1.getAxisY2().setVisible(false);	
			}
		}
		else
		{
			chart1.getAxisY2().setVisible(false);
			
			if(MaxY <= 1 && MaxY > 0  && !itemCodeList.get(0).equals("TUR00"))
				chart1.getAxisY().setStep(0.1);
		}

		for(int i=0; i < itemNameList.size(); i++) {
			if(itemCodeList.size() > 0)
			{
				String unit = ItemShape.getItemUnit(itemCodeList.get(i));
				chart1.getSeries().get(i).setText(itemNameList.get(i) + unit);
			}
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
		if("Y".equals(image))
			chart1.renderToStream();
		else
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
