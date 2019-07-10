package com.song.controller;

import com.song.po.User;
import com.song.service.CheckUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.*;

import org.springframework.web.servlet.ModelAndView;


import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;


@Controller
public class LandController {

    @Autowired
    CheckUser checkUser;

    @RequestMapping(value = "/landingJump", method=RequestMethod.POST)
    @ResponseBody
    public String  landingJump(HttpServletResponse response, @RequestParam("username")String username, @RequestParam("password") String password) throws Exception{
//        参数中的username 是可以匹配上一个页面中表单中name值为 username的input标签
        User user = new User();
        user.setPassword(password);
        user.setUsername(username);
        int result = checkUser.checkUserPass(user);
        if(result == 1) {
            Map<String, WebSocketServer> map = WebSocketServer.map;
            Iterator<Map.Entry<String, WebSocketServer>> iterator = map.entrySet().iterator();
            System.out.println(username);
            while (iterator.hasNext()) {
                Map.Entry<String, WebSocketServer> entry = iterator.next();
                if (entry.getKey().equals(username)) {
                    return "{\"state\":-2}";
                }
            }
        }
        System.out.println(result);
        if(result == 1){
            return "{\"state\":1}";
        }else if(result == 0){
            return "{\"state\":0}";
        }else{
            return "{\"state\":-1}";
        }
    }

    @RequestMapping(value = "/registerCheck", method=RequestMethod.POST)
    @ResponseBody
    public String registerCheck(@PathParam("username") String username) throws Exception{
        int result = checkUser.checkUserName(username);
        if(result == 1){
            return "{\"state\":1}";
        }else{
            return "{\"state\":0}";
        }
    }

    @RequestMapping("/successful")
    public ModelAndView successfulLand(String username) throws Exception{
        System.out.println(username);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("username",username);
        Map<String,WebSocketServer> map = WebSocketServer.map;;
        modelAndView.addObject("userMap",map);
        System.out.println(map);
        modelAndView.setViewName("chatRoom");
        return modelAndView;
    }

    @RequestMapping("/registerUser")
    public void AddNewUser(HttpServletResponse response,String username,String password) throws Exception{
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        checkUser.addNewUser(user);
        response.sendRedirect("index.jsp");
    }
}
