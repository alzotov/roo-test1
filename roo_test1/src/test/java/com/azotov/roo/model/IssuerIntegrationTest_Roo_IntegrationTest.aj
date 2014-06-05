// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.azotov.roo.model;

import com.azotov.roo.model.Issuer;
import com.azotov.roo.model.IssuerDataOnDemand;
import com.azotov.roo.model.IssuerIntegrationTest;
import java.util.Iterator;
import java.util.List;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect IssuerIntegrationTest_Roo_IntegrationTest {
    
    declare @type: IssuerIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: IssuerIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: IssuerIntegrationTest: @Transactional;
    
    @Autowired
    IssuerDataOnDemand IssuerIntegrationTest.dod;
    
    @Test
    public void IssuerIntegrationTest.testCountIssuers() {
        Assert.assertNotNull("Data on demand for 'Issuer' failed to initialize correctly", dod.getRandomIssuer());
        long count = Issuer.countIssuers();
        Assert.assertTrue("Counter for 'Issuer' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void IssuerIntegrationTest.testFindIssuer() {
        Issuer obj = dod.getRandomIssuer();
        Assert.assertNotNull("Data on demand for 'Issuer' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Issuer' failed to provide an identifier", id);
        obj = Issuer.findIssuer(id);
        Assert.assertNotNull("Find method for 'Issuer' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'Issuer' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void IssuerIntegrationTest.testFindAllIssuers() {
        Assert.assertNotNull("Data on demand for 'Issuer' failed to initialize correctly", dod.getRandomIssuer());
        long count = Issuer.countIssuers();
        Assert.assertTrue("Too expensive to perform a find all test for 'Issuer', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<Issuer> result = Issuer.findAllIssuers();
        Assert.assertNotNull("Find all method for 'Issuer' illegally returned null", result);
        Assert.assertTrue("Find all method for 'Issuer' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void IssuerIntegrationTest.testFindIssuerEntries() {
        Assert.assertNotNull("Data on demand for 'Issuer' failed to initialize correctly", dod.getRandomIssuer());
        long count = Issuer.countIssuers();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<Issuer> result = Issuer.findIssuerEntries(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'Issuer' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'Issuer' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void IssuerIntegrationTest.testFlush() {
        Issuer obj = dod.getRandomIssuer();
        Assert.assertNotNull("Data on demand for 'Issuer' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Issuer' failed to provide an identifier", id);
        obj = Issuer.findIssuer(id);
        Assert.assertNotNull("Find method for 'Issuer' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyIssuer(obj);
        Integer currentVersion = obj.getVersion();
        obj.flush();
        Assert.assertTrue("Version for 'Issuer' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void IssuerIntegrationTest.testMergeUpdate() {
        Issuer obj = dod.getRandomIssuer();
        Assert.assertNotNull("Data on demand for 'Issuer' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Issuer' failed to provide an identifier", id);
        obj = Issuer.findIssuer(id);
        boolean modified =  dod.modifyIssuer(obj);
        Integer currentVersion = obj.getVersion();
        Issuer merged = obj.merge();
        obj.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'Issuer' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void IssuerIntegrationTest.testPersist() {
        Assert.assertNotNull("Data on demand for 'Issuer' failed to initialize correctly", dod.getRandomIssuer());
        Issuer obj = dod.getNewTransientIssuer(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'Issuer' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'Issuer' identifier to be null", obj.getId());
        try {
            obj.persist();
        } catch (final ConstraintViolationException e) {
            final StringBuilder msg = new StringBuilder();
            for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                final ConstraintViolation<?> cv = iter.next();
                msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
            }
            throw new IllegalStateException(msg.toString(), e);
        }
        obj.flush();
        Assert.assertNotNull("Expected 'Issuer' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void IssuerIntegrationTest.testRemove() {
        Issuer obj = dod.getRandomIssuer();
        Assert.assertNotNull("Data on demand for 'Issuer' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Issuer' failed to provide an identifier", id);
        obj = Issuer.findIssuer(id);
        obj.remove();
        obj.flush();
        Assert.assertNull("Failed to remove 'Issuer' with identifier '" + id + "'", Issuer.findIssuer(id));
    }
    
}