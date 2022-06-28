package kopo.poly.service.impl;

import kopo.poly.mapper.IChatMapper;
import kopo.poly.model.ChatMessage;
import kopo.poly.service.IChatService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class ChatService implements IChatService {
    @Resource(name = "ChatMapper")
    private IChatMapper chatMapper;

    @Override
    public int insertChat(ChatMessage pDTO, String Key) throws Exception {
        chatMapper.insertChat(pDTO, Key);
        return 0;
    }

    @Override
    public int insertJoin(ChatMessage pDTO, String Key) throws Exception {
        chatMapper.insertJoin(pDTO, Key);
        return 0;
    }

    @Override
    public List<ChatMessage> fetchChat(String Key) throws Exception {

        List<ChatMessage> rList = chatMapper.fetchChat(Key);
        return rList;
    }
}
