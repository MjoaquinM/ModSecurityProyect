package com.fich.wafproject.service;
 
import com.fich.wafproject.model.Rule;
 
public interface RuleService {
     
    void saveRule(Rule rule);
    
    Rule findByRuleId(String ruleId);
     
}