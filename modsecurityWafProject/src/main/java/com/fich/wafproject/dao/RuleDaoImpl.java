
package com.fich.wafproject.dao;

import com.fich.wafproject.model.Rule;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
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
    
}
