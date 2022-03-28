const ws = require("ws");
// const {WebSocket} = ws;
const uuid =  require("uuid");


const users = new Map();
let cur_clicked;
let cur_clickerman_id;
const wsServer = new ws.WebSocketServer({port:8000});

wsServer.on('connection', (ws) => {
  const id = uuid.v4();
  users.set(id,ws);
  if (!cur_clickerman_id)
    cur_clickerman_id = id;

  console.log(`User ${id} connected`);
  console.log(cur_clickerman_id)
  ws.send(JSON.stringify({
    active: id === cur_clickerman_id,
    clicked: cur_clicked
  }));

  ws.on('close', () => {
    users.delete(id);

    cur_clickerman_id = users.keys().next().value;
    if (cur_clickerman_id)  
      users.get(cur_clickerman_id).send(JSON.stringify({
        active: true, clicked: cur_clicked
      }));
    
    console.log(`User ${id} disconnected`);

    if (!users.size)
      cur_clicked = undefined;
  });

  ws.on('message', (raw) => {
    if (id === cur_clickerman_id) {
      const {clicked} = JSON.parse(raw);
      cur_clicked = clicked;
      console.log(`User ${cur_clickerman_id} clicked on ${cur_clicked} cell`);
    }
    else {
      console.log(`Illegal access from ${id}`);
    }
    users.forEach((socket, sid) => 
      socket.send(JSON.stringify({
        active: sid === cur_clickerman_id,
        clicked: cur_clicked
      }))
    );
  });

});
