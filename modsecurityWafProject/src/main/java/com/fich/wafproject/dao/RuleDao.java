
package com.fich.wafproject.dao;

import com.fich.wafproject.model.Rule;

public interface RuleDao {
    
    void saveRule(Rule rule);
    
    public Rule findByRuleId(String ruleId);
    
}
