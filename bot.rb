require 'telegram/bot'
require './fifteen.rb'

# TODO
# * перенести хранение игр в Redis (заодно уберем потенциальную утечку памяти)
# * добавить проверку на выигрышную комбинацию
# * добавить демонизацию и логгинг
# * правильное обращение с эксепшнами

Telegram::Bot::Client.run(ENV['BOT_TOKEN']) do |bot|
  bot.listen do |message|
  @games ||= {}
  case message
    when Telegram::Bot::Types::CallbackQuery
      row, col = message.data.split(',').map(&:to_i)

      fifteen = @games.fetch(message.from.id, {})[message.message.message_id]
      if fifteen
        changed_fifteen = fifteen.slide!(row, col) 
        unless (changed_fifteen.field == fifteen.field) 
          @games[message.from.id][message.message.message_id] = changed_fifteen
          kb = changed_fifteen.field.map.with_index do |row, row_index|
            row.map.with_index do |number, col_index|
              Telegram::Bot::Types::InlineKeyboardButton.new(text: number, callback_data: [row_index, col_index].join(","))
            end
          end
          markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
          bot.api.editMessageReplyMarkup(chat_id: message.from.id, message_id: message.message.message_id, reply_markup: markup)
        end
      end
    when Telegram::Bot::Types::Message
      if message.text == '/start'
        @fifteen = Fifteen.new

        kb = @fifteen.field.map.with_index do |row, row_index|
          row.map.with_index do |number, col_index|
            Telegram::Bot::Types::InlineKeyboardButton.new(text: number, callback_data: [row_index, col_index].join(","))
          end
        end
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
        resp = bot.api.send_message(chat_id: message.chat.id, text: 'New game started', reply_markup: markup)
        message_id = resp['result']['message_id']
        @games[message.chat.id] ||= {}
        @games[message.chat.id][message_id] = @fifteen
      end
    end
  end
end
