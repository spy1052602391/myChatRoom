package com.song.controller;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import java.text.SimpleDateFormat;
import java.util.*;


@ServerEndpoint(value = "/websocket/{username}")
public class WebSocketServer{

    static Map<String,WebSocketServer> map = new HashMap<>();

    private static Integer onlineNum = 0;
    private Session session;
    private String name;

    @OnOpen
    public void onOpen(@PathParam("username")String username, Session session){
        this.session = session;
        map.put(username,this);
        this.name = username;
        this.addOnlineNum();
        System.out.println("第"+this.getOnlineNum()+"个用户已经登陆");
        this.onSend("names_"+username+",上线啦!快去找TA他聊天吧!");
    }

    @OnClose
    public void onClose(){
        map.remove(this.name);
        this.subOnlineNum();
        this.onSend("quit_"+this.name);
        System.out.println("有用户退出登陆的，当前还剩用户"+this.getOnlineNum()+"人");
    }

    @OnError
    public void onError(Session session, Throwable error) {
        System.err.println("发生错误！");
        error.printStackTrace();
    }

    public void onSend(String message){
        Set<Map.Entry<String,WebSocketServer>> set = map.entrySet();
        for(Map.Entry<String,WebSocketServer> entry : set){
            try {
                entry.getValue().session.getBasicRemote().sendText(message);
            } catch (Exception e) {
                e.printStackTrace();
                continue;
            }
        }
    }


    //消息监控方法，有消息从客户端发送过来，这个方法就执行一次
    @OnMessage
    public void onMessage(String msg){
        System.out.println("消息监控:"+msg);
        Date t = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.onSend("content_"+this.name+":"+msg);
    }

    //用户增加
    public synchronized void addOnlineNum(){
        onlineNum++;
    }

    //用户下线
    public synchronized void subOnlineNum(){
        onlineNum--;
    }


    //当前用户数
    private Integer getOnlineNum(){
        return onlineNum;
    }
}