import discord
import os
import subprocess

TOKEN = os.environ['TOKEN']
ifconfig_cmd = ['ifconfig']

intents = discord.Intents.default()
intents.message_content = True

client = discord.Client(intents=intents)

@client.event
async def on_ready():
    print(f'Logged in as {str(client)}')

@client.event
async def on_message(message):
    if message.content.startswith('$ifconfig'):
        await message.channel.send(f'Printing: \n```\n{get_log()}\n```')
        return

def get_log():
    proc = subprocess.Popen(ifconfig_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    o, e = proc.communicate()
    # raise an error if the command fails
    if proc.returncode != 0:
        raise Exception(f'Command failed with error: {e.decode()}')
    # decode the output and return it
    return o.decode("utf-8")

client.run(TOKEN)
