package daewooInfo.common.security.intercept;

import java.util.LinkedHashMap;
import org.springframework.beans.factory.FactoryBean;
import daewooInfo.common.security.service.ISecuredObjectService;

/**
 * DB 기반의 보호자원 맵핑 정보를 얻어 이를 참조하는 Bean 의 초기화 데이터로 제공한다.
 * 
 * @author ByungHun Woo
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.20  ByungHun Woo    최초 생성
 *
 * </pre>
 */

public class ResourcesMapFactoryBean implements FactoryBean {
	
    /**
	 * @uml.property  name="resourceType"
	 */
    private String resourceType;
    /**
	 * @uml.property  name="resourcesMap"
	 */
    private LinkedHashMap resourcesMap;
    /**
	 * @uml.property  name="securedObjectService"
	 * @uml.associationEnd  
	 */
    private ISecuredObjectService securedObjectService;

	/**
	 * setResourceType
	 * @param resourceType
	 * @exception Exception
	 * @uml.property  name="resourceType"
	 */
    public void setResourceType(String resourceType) {
        this.resourceType = resourceType;
    }
    
	/**
	 * setSecuredObjectService
	 * @param securedObjectService
	 * @exception Exception
	 * @uml.property  name="securedObjectService"
	 */
    public void setSecuredObjectService(
            ISecuredObjectService securedObjectService) {
        this.securedObjectService = securedObjectService;
    }
    
	/**
	 * init
	 * @exception Exception
	 */
    public void init() throws Exception {
        if ("method".equals(resourceType)) {
            resourcesMap = securedObjectService.getRolesAndMethod();
        } else if ("pointcut".equals(resourceType)) {
            resourcesMap = securedObjectService.getRolesAndPointcut();
        } else {
            resourcesMap = securedObjectService.getRolesAndUrl();
        }
    }
    
	/**
	 * getObject
	 * @return Object resourcesMap
	 * @exception Exception
	 */
    public Object getObject() throws Exception {
        if (resourcesMap == null) {
            init();
        }
        return resourcesMap;
    }
    
	/**
	 * getObjectType
	 * @return Class LinkedHashMap.class
	 */
    public Class getObjectType() {
        return LinkedHashMap.class;
    }
    
	/**
	 * isSingleton
	 * @return boolean
	 */
    public boolean isSingleton() {
        return true;
    }
}
