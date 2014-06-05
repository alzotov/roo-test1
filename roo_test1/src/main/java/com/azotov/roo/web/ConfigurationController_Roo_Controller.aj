// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.azotov.roo.web;

import com.azotov.roo.model.Configuration;
import com.azotov.roo.web.ConfigurationController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect ConfigurationController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String ConfigurationController.create(@Valid Configuration configuration, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, configuration);
            return "configurations/create";
        }
        uiModel.asMap().clear();
        configuration.persist();
        return "redirect:/configurations/" + encodeUrlPathSegment(configuration.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String ConfigurationController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Configuration());
        return "configurations/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String ConfigurationController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("configuration", Configuration.findConfiguration(id));
        uiModel.addAttribute("itemId", id);
        return "configurations/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String ConfigurationController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("configurations", Configuration.findConfigurationEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) Configuration.countConfigurations() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("configurations", Configuration.findAllConfigurations(sortFieldName, sortOrder));
        }
        return "configurations/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String ConfigurationController.update(@Valid Configuration configuration, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, configuration);
            return "configurations/update";
        }
        uiModel.asMap().clear();
        configuration.merge();
        return "redirect:/configurations/" + encodeUrlPathSegment(configuration.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String ConfigurationController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Configuration.findConfiguration(id));
        return "configurations/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String ConfigurationController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Configuration configuration = Configuration.findConfiguration(id);
        configuration.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/configurations";
    }
    
    void ConfigurationController.populateEditForm(Model uiModel, Configuration configuration) {
        uiModel.addAttribute("configuration", configuration);
    }
    
    String ConfigurationController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
