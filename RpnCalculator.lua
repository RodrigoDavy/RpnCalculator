#!/bin/lua

dofile('rpn.lua')

-- pass token as command line argument or insert it into code
local token = arg[1] or ""

-- create and configure new bot with set token
local bot, extension = require("lua-bot-api").configure(token)

-- override onMessageReceive function so it does what we want
extension.onTextReceive = function (msg)
	print("New Message by " .. msg.from.first_name)

-- msg.from.id

	if (msg.text == "/start") then
		if(msg.chat.type=='private') then
			bot.sendMessage(msg.from.id, "Hi, my name is " .. bot.first_name .. "!\n\nRPN = Reverse Polish Notation. It's a t-thing! Look it up at Wikipedia\n\nI was made by @GladiadorDePlastico. Quite a guy!")
			bot.sendMessage(msg.from.id, "My commands are:\n/start (Get this lovely welcome message)\n/print (prints the RPN stack)\n/pop (Pops the element on the top of the stack)\n/clear (clears the stack)\n/help (summons Satan)")
			bot.sendMessage(msg.from.id,'Insert a math operation in RPN notation, for example: 2 2 +')
		else
			bot.sendMessage(msg.chat.id,"Please send this command at @Rpncalculatorbot")
		end
	elseif (msg.text == "/help") then
		if(msg.chat.type=='private') then
			bot.sendMessage(msg.from.id,"The available operations are '+ - * / ^'\nI could implement more operations but I'm a lazy piece of shit")
			bot.sendMessage(msg.from.id,"Example using the RPN calculator:\n'3 5' <<Inserts the numbers 3 and 5 into the stack>>\n'2 2 + 3 *' <<This is equivalent to (2+2)*3>>")
			bot.sendMessage(msg.from.id,"May Satan be with you! 👺👺👺")
		else
			bot.sendMessage(msg.chat.id,"Please send this command at @Rpncalculatorbot")
		end
	elseif (msg.text == "/print") then
		bot.sendMessage(msg.chat.id,'Stack:\n' .. printPilha(msg.chat.id))
	elseif (msg.text == "/pop") then
		popPilha(msg.chat.id)
		bot.sendMessage(msg.chat.id,'Stack:\n' .. printPilha(msg.chat.id))
	elseif (msg.text == "/clear") then
		clearPilha(msg.chat.id)
		bot.sendMessage(msg.chat.id,'Stack:\n' .. printPilha(msg.chat.id))
	elseif (msg.text:sub(1,5) == "/math") then
		rpn(msg.chat.id,msg.text:sub(7))
		bot.sendMessage(msg.chat.id,'Stack:\n' .. printPilha(msg.chat.id))
	else
		rpn(msg.chat.id,msg.text)
		bot.sendMessage(msg.chat.id,'Stack:\n' .. printPilha(msg.chat.id))
	end
end

-- This runs the internal update and callback handler
-- you can even override run()
extension.run()
