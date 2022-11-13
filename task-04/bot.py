import os
import telebot
import requests
from dotenv import load_dotenv
import csv

# TODO: 1.1 Get your environment variables
load_dotenv()
TOKEN = os.getenv("TOKEN")
API = os.getenv("API")
bot = telebot.TeleBot(TOKEN)


@bot.message_handler(commands=['start', 'hello'])
def greet(message):
    global botRunning
    botRunning = True
    bot.reply_to(
        message, 'Hello there! I am a bot that will show movie information for you and export it in a CSV file.\n\n')


@bot.message_handler(commands=['stop', 'bye'])
def goodbye(message):
    global botRunning
    botRunning = False
    bot.reply_to(message, 'Bye!\nHave a good time')


@bot.message_handler(func=lambda message: botRunning, commands=['help'])
def helpProvider(message):
    bot.reply_to(message, '1.0 You can use \"/movie MOVIE_NAME\" command to get the details of a particular movie. '
                          'For eg: \"/movie The Shawshank Redemption\"\n\n2.0. You can use \"/export\" command to '
                          'export all the movie data in CSV format.\n\n3.0. You can use \"/stop\" or the command '
                          '\"/bye\" to stop the bot.')


@bot.message_handler(func=lambda message: botRunning, commands=['movie'])
def getMovie(message):
    global poster
    bot.reply_to(message, 'Getting movie info...')
    # TODO: 1.2 Get movie information from the API
    response = requests.get(f"http://www.omdbapi.com/?i=tt3896198&apikey={API}&t={message.text[7::]}")
    dict_resp = response.json()
    reply = ''
    fields = []
    rows = []
    extras = ["DVD", "Production", "imdbVotes", "Plot", "imdbID", "Language", "Writer", "Director", "Country", "Actors", "BoxOffice", "Awards", "Response", "Website", "Runtime", "Released"]
    # TODO: 1.3 Show the movie information in the chat window
    for i in dict_resp:
        if i == "Poster":
            poster = requests.get(dict_resp[i])
        elif i in extras:
            fields.append(i)
            rows.append(dict_resp[i])
        elif i == "Ratings":
            for j in dict_resp[i]:
                if j['Source'] == "Rotten Tomatoes":
                    fields.append(j['Source'])
                    rows.append(j['Value'])
                    reply = f"{reply}{j['Source']}:{j['Value']}\n"
        else:
            fields.append(i)
            rows.append(dict_resp[i])
            reply = f"{reply}{i}:{dict_resp[i]}\n"
    bot.send_photo(message.chat.id, poster.content, caption=reply)
    # TODO: 2.1 Create a CSV file and dump the movie information in it
    try:
        with open("csv_file.csv", "w") as csvfile:
            csvwriter = csv.writer(csvfile)
            print(reply)
            csvwriter.writerow(fields)
            csvwriter.writerow(rows)
    except:
        bot.reply_to(message, "error creating csv file")


@bot.message_handler(func=lambda message: botRunning, commands=['export'])
def getList(message):
    global chat_id
    bot.reply_to(message, 'Generating file...')
    #  TODO: 2.2 Send downlodable CSV file to telegram chat
    doc = open('csv_file.csv', 'r')
    bot.send_document(message.chat.id, doc)


@bot.message_handler(func=lambda message: botRunning)
def default(message):
    bot.reply_to(message, 'I did not understand '+'\N{confused face}')


bot.infinity_polling()
