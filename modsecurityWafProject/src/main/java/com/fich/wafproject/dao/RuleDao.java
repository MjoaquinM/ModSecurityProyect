
package com.fich.wafproject.dao;

import com.fich.wafproject.model.Rule;
import java.util.List;

public interface RuleDao {
    
    void saveRule(Rule rule);
    
    public Rule findByRuleId(String ruleId);
    
    public Rule findById(Integer id);
    
    public List<Rule> findAllRules();
    
    
}
