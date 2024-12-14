const http = require("http");
const express = require("express");
const WebSocket = require("ws");
const { Client, GatewayIntentBits } = require("discord.js");
require("dotenv").config(); // Make sure to include dotenv for environment variables

const app = express();
app.use(express.static("public"));

const serverPort = process.env.PORT || 3000;
const server = http.createServer(app);

let keepAliveId;

// Set up WebSocket server
const wss =
  process.env.NODE_ENV === "production"
    ? new WebSocket.Server({ server })
    : new WebSocket.Server({ port: 5001 });

server.listen(serverPort, () => {
  console.log(`Server started on port ${serverPort} in stage ${process.env.NODE_ENV}`);
});

// Set up Discord client
const discordClient = new Client({
  intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMessages, GatewayIntentBits.MessageContent],
});

// Listen for incoming WebSocket connections
wss.on("connection", function (ws) {
  console.log("Connection Opened");
  console.log("Client size: ", wss.clients.size);

  if (wss.clients.size === 1) {
    console.log("first connection. starting keepalive");
    keepServerAlive();
  }

  ws.on("message", (data) => {
    let stringifiedData = data.toString();
    if (stringifiedData === 'pong') {
      console.log('keepAlive');
      return;
    }
    broadcast(ws, stringifiedData, false);
  });

  ws.on("close", () => {
    console.log("closing connection");
    if (wss.clients.size === 0) {
      console.log("last client disconnected, stopping keepAlive interval");
      clearInterval(keepAliveId);
    }
  });
});

// Implement broadcast function
const broadcast = (ws, message, includeSelf) => {
  wss.clients.forEach((client) => {
    if ((includeSelf || client !== ws) && client.readyState === WebSocket.OPEN) {
      client.send(message);
    }
  });
};

// Keep server alive
const keepServerAlive = () => {
  keepAliveId = setInterval(() => {
    wss.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send('ping');
      }
    });
  }, 50000);
};

// Send hello world response
app.get('/', (req, res) => {
  res.send('Hello World!');
});

// Connect to Discord
discordClient.once('ready', () => {
  console.log(`Logged in as ${discordClient.user.tag}`);
});

// Listen for messages on a specific channel
discordClient.on('messageCreate', (message) => {
  if (!message.author.bot) { // Ignore messages from bots
    const messageContent = `${message.author.username}: ${message.content}`;
    broadcast(null, messageContent, true); // Send to all WebSocket clients
  }
});

// Log in to Discord
discordClient.login(process.env.DISCORD_BOT_TOKEN);
