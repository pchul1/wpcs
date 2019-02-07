package daewooInfo.stats.view;

import java.awt.Color;
import java.util.HashMap;
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
import com.softwarefx.chartfx.server.ChartServer;
import com.softwarefx.chartfx.server.ContentLayout;
import com.softwarefx.chartfx.server.DockArea;
import com.softwarefx.chartfx.server.DockBorder;
import com.softwarefx.chartfx.server.Gallery;
import com.softwarefx.chartfx.server.MarkerShape;
import com.softwarefx.chartfx.server.TitleCollection;
import com.softwarefx.chartfx.server.TitleDockable;
import com.softwarefx.chartfx.server.FileFormat;
import com.softwarefx.chartfx.server.adornments.GradientBackground;
import com.softwarefx.chartfx.server.adornments.SimpleBorder;
import com.softwarefx.chartfx.server.adornments.SimpleBorderType;

import daewooInfo.waterpolmnt.situationctl.view.ItemShape;

/**
 * 상황관리 통계 차트를 가져오는 View Class
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------     --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 */
public class RelateChartView extends AbstractView implements Ordered {
	private Log log = LogFactory.getLog(RelateChartView.class);
	private String chartTemplatePath;
	private int order = Integer.MAX_VALUE;
	
    /**
     * 상황관리 통계 차트를 생성한다.
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
		String itemCodeX = (String)model.get("itemCodeX");
		String itemCodeY = (String)model.get("itemCodeY");
		
		if("null".equals(chartWidth)) chartWidth = "680";
		if("null".equals(chartHeight)) chartHeight = "500";
		Double MaxY = 0.0;
		Double MinY = 9999999D;
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
		
		
		//sub Y축 관련
		chart1.getAxisY2().setVisible(true);
		chart1.getAxisY2().setPosition(AxisPosition.FAR);
		
		
		chart1.getData().clear();
		//차트 시리즈 및 포인트 설정
		chart1.getData().setSeries(itemCodeList.size()); 
		chart1.getData().setPoints(itemDataSize.intValue());
		
		//SUB Y축 관련
		double sMaxY = 0.0;
		Map<Integer, Double> sMax = new HashMap<Integer, Double>();
		
		log.debug("itemCodeList.size ==== "+itemCodeList.size());
		//차트에 보여질 데이터 설정
		for( int i=0; i < itemCodeList.size(); i++) {
			
			String code = itemCodeList.get(i);
			List<Map> dataList = itemDataMap.get(code);
			
			if(code.equals(itemCodeX))
			{
				chart1.getSeries().get(i).setMarkerShape(MarkerShape.RECT);
				chart1.getSeries().get(i).setColor(new Color(0, 20, 202));
			}
			else if(code.equals(itemCodeY))
			{
				chart1.getSeries().get(i).setMarkerShape(MarkerShape.CIRCLE);
				chart1.getSeries().get(i).setColor(new Color(0, 162, 0));
			}
			
			//Sub Y축 관련
			sMaxY = 0.0;
			
			for( int j=0; j < dataList.size(); j++) {
				
				Map<String,String> data = dataList.get(j);
				String x = data.get("x");
				String y = data.get("y");
				
				if(y == null || "0".equals(y))
				{
					continue;
				}
				
				chart1.getData().set(i, j, Double.valueOf(y));
				if(MaxY < Double.valueOf(y)) MaxY = Double.valueOf(y);
				if(MinY > Double.valueOf(y)) MinY = Double.valueOf(y);
				chart1.getData().getLabels().set(j, x);
				
				//Sub Y축 관련
				if(sMaxY < Double.valueOf(y)  && !y.equals(Integer.MAX_VALUE+"")) sMaxY = Double.valueOf(y);
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
			
			if(minMax <= 1 && minMax > 0)
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
			
			if(MaxY <= 1 && MaxY > 0)
				chart1.getAxisY().setStep(0.1);
		}
		
		//Series 텍스트 설정
		for(int i=0; i < itemNameList.size(); i++) {
			if(itemCodeList.get(i).length() >= 5){
				String unit = ItemShape.getItemUnit(itemCodeList.get(i).substring(0, 5));
				chart1.getSeries().get(i).setText(itemNameList.get(i) + unit);
			}
		}
		
		//chart1.getAxisY().setMax(MaxY);
		
		
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
