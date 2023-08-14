package com.proj.salad.prod.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.proj.salad.prod.service.ProdServiceImpl;
import com.proj.salad.prod.vo.NutrientVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/* 김동혁 - Controller 추가 */
@Controller
public class ProdController {

    @Autowired
    ProdServiceImpl prodService;

    @Autowired
    NutrientVO nutrientVO;

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public ModelAndView homePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = getViewName(request);
        ModelAndView mav = new ModelAndView();
        mav.setViewName(viewName);

        return mav;
    }

    /* 김동혁 추가 : 메인 페이지 추가 (23.07.14) */
    @RequestMapping(value = "/menu", method = RequestMethod.GET)
    public ModelAndView menuPage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = getViewName(request);

        // 제품리스트 담을 리스트 생성
        List prodList = new ArrayList();
        
        // Service에서 상품 목록 select, prodList에 담기
        prodList = prodService.selectProdList();
        System.out.println("prodList 객체 확인 : " + prodList);

        // ModelAndView 생성 후 JSP에 prodList 리스트 전달
        ModelAndView mav = new ModelAndView();
        mav.addObject("prodList", prodList);
        mav.setViewName(viewName);

        return mav;
    }

    /* 김동혁 detail 메소드 추가 (23.07.18) */
    @RequestMapping(value = "/detail", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public String detailPage(@RequestParam int prodNum,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = getViewName(request);

        System.out.println("shopdetail");

        // 영양소 VO 생성
        NutrientVO nutrientVO = new NutrientVO();

        // prodNum으로 영양소 테이블 조회
        nutrientVO = prodService.selectProdNutrient(prodNum);
        System.out.println("영양소 VO : " + nutrientVO);

        // JSON 으로 리턴값 보내기
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonData = objectMapper.writeValueAsString(nutrientVO);

        return jsonData;
    }

    private String getViewName(HttpServletRequest request) throws Exception {
        String contextPath = request.getContextPath();
        String uri = (String) request.getAttribute("javax.servlet.include.request_uri");
        if (uri == null || uri.trim().equals("")) {
            uri = request.getRequestURI();
        }

        int begin = 0;
        if (!((contextPath == null) || ("".equals(contextPath)))) {
            begin = contextPath.length();
        }

        int end;
        if (uri.indexOf(";") != -1) {
            end = uri.indexOf(";");
        } else if (uri.indexOf("?") != -1) {
            end = uri.indexOf("?");
        } else {
            end = uri.length();
        }

        String viewName = uri.substring(begin, end);
        if (viewName.indexOf(".") != -1) {
            viewName = viewName.substring(0, viewName.lastIndexOf("."));
        }
        if (viewName.lastIndexOf("/") != -1) {
            viewName = viewName.substring(viewName.lastIndexOf("/"), viewName.length());
        }
        return viewName;
    }
}
