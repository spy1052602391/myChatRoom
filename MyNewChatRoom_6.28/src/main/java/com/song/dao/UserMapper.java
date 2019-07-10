package com.song.dao;

import com.song.po.User;

public interface UserMapper {

    public User queryUserByName(User user) throws Exception;

    public void addUser(User user) throws Exception;

}
