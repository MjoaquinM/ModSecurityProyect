//package com.fich.wafproject.dao;
// 
//import org.springframework.stereotype.Repository;
// 
//import com.fich.wafproject.model.EventRule;
//import java.util.List;
//import org.hibernate.Criteria;
//import org.hibernate.criterion.Order;
// 
//@Repository("EventRuleDao")
//public class EventRuleDaoImpl extends AbstractDao<Integer, EventRule> implements EventRuleDao {
// 
//    public void saveEventRule(EventRule eventRule) {
//        persist(eventRule);
//    }
//
//    public List<EventRule> findAll() {
//        Criteria crit = createEntityCriteria().setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
//        crit.addOrder(Order.asc("ruleId"));
//        return (List<EventRule>)crit.list();
//    }
// 
//}