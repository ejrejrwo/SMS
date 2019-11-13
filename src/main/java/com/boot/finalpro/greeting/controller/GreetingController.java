package com.boot.finalpro.greeting.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.util.HtmlUtils;

import com.boot.finalpro.greeting.util.Chat;
import com.boot.finalpro.greeting.util.Greeting;
import com.boot.finalpro.greeting.util.HelloMessage;

@Controller
public class GreetingController {
	
	@MessageMapping("/hello")
	@SendTo("/topic/greetings")
	public Greeting greeting(HelloMessage message) throws Exception {
		Thread.sleep(100); // delay
		return new Greeting("Hello, " + HtmlUtils.htmlEscape(message.getName()) + "!");
	}
	
	@MessageMapping("/chat")
	@SendTo("/topic/chat")
	public Chat chat(Chat chat) throws Exception {
	  return new Chat(chat.getName(), chat.getMessage());
	}
	
	@MessageMapping("/teamchat")
	@SendTo("/topic/teamchat")
	public Chat teamchat(Chat chat) throws Exception {
	  return new Chat(chat.getTeam(),chat.getName(), chat.getMessage());
	}

}
