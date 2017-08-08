package com.fich.wafproject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fich.wafproject.dao.RuleDao;
import com.fich.wafproject.model.Rule;

@Service("ruleService")
@Transactional
public class RuleServiceImpl implements RuleService {

    @Autowired
    private RuleDao dao;

    @Override
    public void saveRule(Rule rule) {
        dao.saveRule(rule);
    }

    @Override
    public Rule findByRuleId(String ruleId) {
        Rule rule = dao.findByRuleId(ruleId);
        return rule;
    }

}
