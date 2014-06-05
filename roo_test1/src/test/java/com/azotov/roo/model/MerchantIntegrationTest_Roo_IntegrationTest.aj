// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.azotov.roo.model;

import com.azotov.roo.model.Merchant;
import com.azotov.roo.model.MerchantDataOnDemand;
import com.azotov.roo.model.MerchantIntegrationTest;
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

privileged aspect MerchantIntegrationTest_Roo_IntegrationTest {
    
    declare @type: MerchantIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: MerchantIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: MerchantIntegrationTest: @Transactional;
    
    @Autowired
    MerchantDataOnDemand MerchantIntegrationTest.dod;
    
    @Test
    public void MerchantIntegrationTest.testCountMerchants() {
        Assert.assertNotNull("Data on demand for 'Merchant' failed to initialize correctly", dod.getRandomMerchant());
        long count = Merchant.countMerchants();
        Assert.assertTrue("Counter for 'Merchant' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void MerchantIntegrationTest.testFindMerchant() {
        Merchant obj = dod.getRandomMerchant();
        Assert.assertNotNull("Data on demand for 'Merchant' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Merchant' failed to provide an identifier", id);
        obj = Merchant.findMerchant(id);
        Assert.assertNotNull("Find method for 'Merchant' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'Merchant' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void MerchantIntegrationTest.testFindAllMerchants() {
        Assert.assertNotNull("Data on demand for 'Merchant' failed to initialize correctly", dod.getRandomMerchant());
        long count = Merchant.countMerchants();
        Assert.assertTrue("Too expensive to perform a find all test for 'Merchant', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<Merchant> result = Merchant.findAllMerchants();
        Assert.assertNotNull("Find all method for 'Merchant' illegally returned null", result);
        Assert.assertTrue("Find all method for 'Merchant' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void MerchantIntegrationTest.testFindMerchantEntries() {
        Assert.assertNotNull("Data on demand for 'Merchant' failed to initialize correctly", dod.getRandomMerchant());
        long count = Merchant.countMerchants();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<Merchant> result = Merchant.findMerchantEntries(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'Merchant' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'Merchant' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void MerchantIntegrationTest.testFlush() {
        Merchant obj = dod.getRandomMerchant();
        Assert.assertNotNull("Data on demand for 'Merchant' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Merchant' failed to provide an identifier", id);
        obj = Merchant.findMerchant(id);
        Assert.assertNotNull("Find method for 'Merchant' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyMerchant(obj);
        Integer currentVersion = obj.getVersion();
        obj.flush();
        Assert.assertTrue("Version for 'Merchant' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void MerchantIntegrationTest.testMergeUpdate() {
        Merchant obj = dod.getRandomMerchant();
        Assert.assertNotNull("Data on demand for 'Merchant' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Merchant' failed to provide an identifier", id);
        obj = Merchant.findMerchant(id);
        boolean modified =  dod.modifyMerchant(obj);
        Integer currentVersion = obj.getVersion();
        Merchant merged = obj.merge();
        obj.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'Merchant' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void MerchantIntegrationTest.testPersist() {
        Assert.assertNotNull("Data on demand for 'Merchant' failed to initialize correctly", dod.getRandomMerchant());
        Merchant obj = dod.getNewTransientMerchant(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'Merchant' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'Merchant' identifier to be null", obj.getId());
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
        Assert.assertNotNull("Expected 'Merchant' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void MerchantIntegrationTest.testRemove() {
        Merchant obj = dod.getRandomMerchant();
        Assert.assertNotNull("Data on demand for 'Merchant' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Merchant' failed to provide an identifier", id);
        obj = Merchant.findMerchant(id);
        obj.remove();
        obj.flush();
        Assert.assertNull("Failed to remove 'Merchant' with identifier '" + id + "'", Merchant.findMerchant(id));
    }
    
}
