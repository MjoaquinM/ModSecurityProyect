
package com.fich.wafproject.dao;

import com.fich.wafproject.model.Rule;
import java.util.List;

public interface RuleDao {
    
    void saveRule(Rule rule);
    
    public Rule findByRuleId(String ruleId);
    
    List<Rule> findAll();
    
}
