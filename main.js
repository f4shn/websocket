const http = require("http");
const express = require("express");
const WebSocket = require("ws");
const { Client, GatewayIntentBits } = require("discord.js");

const app = express();
app.use(express.static("public"));

const serverPort = process.env.PORT || 10000;
const server = http.createServer(app);
const wss = new WebSocket.Server({ port: serverPort });

// Determine the URL and print it
const host = process.env.HOST || 'localhost';
console.log(`WebSocket server started at: ws://${host}:${serverPort}`);

server.listen(serverPort, () => {
  console.log(`Server started on port ${serverPort}`);
});

const discordClient = new Client({
  intents: [
    GatewayIntentBits.Guilds,
    GatewayIntentBits.GuildMessages,
    GatewayIntentBits.MessageContent,
  ],
});

const TARGET_CHANNEL_ID = '1317472928149016606';

// Object to store client's amounts
const clientAmounts = {};

discordClient.on('messageCreate', (message) => {
  if (message.channel.id === TARGET_CHANNEL_ID && !message.author.bot) {
    const messageContent = `${message.content}`;
    broadcast(null, messageContent, true);
  }
});

const broadcast = (ws, message, includeSelf) => {
  wss.clients.forEach((client) => {
    if ((includeSelf || client !== ws) && client.readyState === WebSocket.OPEN) {
      client.send(message);
    }
  });
};

wss.on("connection", function (ws) {
  console.log("Connection Opened");
  console.log("Client size: ", wss.clients.size);

  // Assign initial amount for the new client
  const clientId = generateClientId();
  clientAmounts[clientId] = 0; // Initial amount is set to 0

  ws.on("message", (data) => {
    let stringifiedData = data.toString();
    if (stringifiedData === 'pong') {
      console.log('keepAlive');
      return;
    }
    broadcast(ws, stringifiedData, false);
  });

  ws.on("close", () => {
    console.log("Closing connection");
    // Update the client's amount when they disconnect
    clientAmounts[clientId] += 1; // Change this logic based on how you want to modify the amount
    console.log(`Client disconnected. New amount for client ${clientId}: ${clientAmounts[clientId]}`);
    
    // Optionally clean up the amount for the client
    delete clientAmounts[clientId];
    console.log("Client amounts: ", clientAmounts);
  });
});

// Function to generate unique client IDs
const generateClientId = () => {
  return `client-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
}

discordClient.login(process.env.DISCORD_BOT_TOKEN);

app.get('/', (req, res) => {
  res.send('Hello World!');
});
