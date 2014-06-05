// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.azotov.roo.web;

import com.azotov.roo.model.Issuer;
import com.azotov.roo.model.IssuerAgent;
import com.azotov.roo.web.IssuerAgentController;
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

privileged aspect IssuerAgentController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String IssuerAgentController.create(@Valid IssuerAgent issuerAgent, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, issuerAgent);
            return "issueragents/create";
        }
        uiModel.asMap().clear();
        issuerAgent.persist();
        return "redirect:/issueragents/" + encodeUrlPathSegment(issuerAgent.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String IssuerAgentController.createForm(Model uiModel) {
        populateEditForm(uiModel, new IssuerAgent());
        return "issueragents/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String IssuerAgentController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("issueragent", IssuerAgent.findIssuerAgent(id));
        uiModel.addAttribute("itemId", id);
        return "issueragents/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String IssuerAgentController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("issueragents", IssuerAgent.findIssuerAgentEntries(firstResult, sizeNo, sortFieldName, sortOrder));
            float nrOfPages = (float) IssuerAgent.countIssuerAgents() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("issueragents", IssuerAgent.findAllIssuerAgents(sortFieldName, sortOrder));
        }
        return "issueragents/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String IssuerAgentController.update(@Valid IssuerAgent issuerAgent, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, issuerAgent);
            return "issueragents/update";
        }
        uiModel.asMap().clear();
        issuerAgent.merge();
        return "redirect:/issueragents/" + encodeUrlPathSegment(issuerAgent.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String IssuerAgentController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, IssuerAgent.findIssuerAgent(id));
        return "issueragents/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String IssuerAgentController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        IssuerAgent issuerAgent = IssuerAgent.findIssuerAgent(id);
        issuerAgent.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/issueragents";
    }
    
    void IssuerAgentController.populateEditForm(Model uiModel, IssuerAgent issuerAgent) {
        uiModel.addAttribute("issuerAgent", issuerAgent);
        uiModel.addAttribute("issuers", Issuer.findAllIssuers());
    }
    
    String IssuerAgentController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
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