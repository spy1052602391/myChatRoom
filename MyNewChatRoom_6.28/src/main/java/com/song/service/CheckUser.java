package com.song.service;

import com.song.po.User;

public interface CheckUser {

    public int checkUserPass(User user) throws  Exception;

    public void addNewUser(User user) throws Exception;

    public int checkUserName(String username) throws Exception;
}
