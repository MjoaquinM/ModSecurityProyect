
package com.fich.wafproject.dao;

import com.fich.wafproject.model.Event;
import com.fich.wafproject.model.Rule;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

@Repository("RuleDao")
public class RuleDaoImpl extends AbstractDao<Integer, Rule> implements RuleDao {
    
    public void saveRule(Rule rule) {
        persist(rule);
    }
    
    @Override
    public Rule findByRuleId(String ruleId){
        Criteria crit = createEntityCriteria();
        crit.add(Restrictions.eq("ruleId", ruleId));
        Rule rule = (Rule) crit.uniqueResult();
        return rule;
    }
    
    @Override
    public Rule findById(Integer id) {
        return getByKey(id);
    }

    @Override
    public List<Rule> findAllRules() {
        Criteria crit = this.createEntityCriteria();//.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        crit.setProjection(Projections.distinct(Projections.property("id")));
        List<Rule> rules = new ArrayList<Rule>();
        for(Object idRule : crit.list()){
            rules.add(this.findById((Integer) idRule));
        }
        return (List<Rule>) rules;
    }
    
}
