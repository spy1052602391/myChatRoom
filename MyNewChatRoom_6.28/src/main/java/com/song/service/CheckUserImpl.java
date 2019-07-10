package com.song.service;

import com.song.dao.UserMapper;
import com.song.po.User;
import org.springframework.beans.factory.annotation.Autowired;

public class CheckUserImpl implements CheckUser {

    @Autowired
    UserMapper userMapper;

    @Override
    public int checkUserPass(User user) throws Exception {
        User user1 = userMapper.queryUserByName(user);
        if(user1 == null){
            return 0;
        }
        if(!user1.getPassword().equals(user.getPassword())){
            return -1;
        }else{
            return 1;
        }
    }

    @Override
    public void addNewUser(User user) throws Exception {
        userMapper.addUser(user);
    }

    @Override
    public int checkUserName(String username) throws Exception {
        User user = new User();
        user.setUsername(username);
        User user1 = userMapper.queryUserByName(user);
        int result = 1;
        if(user1 == null)
            result = 0;
        return result;
    }
}
