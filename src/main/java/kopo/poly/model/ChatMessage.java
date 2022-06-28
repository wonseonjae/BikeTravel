package kopo.poly.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

@JsonInclude(JsonInclude.Include.NON_DEFAULT)
@Getter
@Setter

public class ChatMessage {

    private MessageType type;
    private String roomId;
    private String regDate;
    private String content;
    private String sender;
}