package com.fich.wafproject.service;
 
import com.fich.wafproject.model.Rule;
import java.util.List;
 
public interface RuleService {
     
    void saveRule(Rule rule);
    
    Rule findByRuleId(String ruleId);
     
    List<Rule> findAll();
}