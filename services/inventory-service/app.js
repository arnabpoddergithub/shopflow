const express = require('express');
const app = express();
app.use(express.json());

let inventory = [
  { id: 1, item: "laptop", stock: 50 },
  { id: 2, item: "phone", stock: 100 },
  { id: 3, item: "tablet", stock: 30 }
];

app.get('/health', (req, res) => {
  res.json({ status: 'healthy', service: 'inventory-service' });
});

app.get('/inventory', (req, res) => {
  res.json({ inventory });
});

app.get('/inventory/:item', (req, res) => {
  const found = inventory.find(i => i.item === req.params.item);
  if (!found) return res.status(404).json({ error: 'item not found' });
  res.json(found);
});

app.listen(3000, () => {
  console.log('inventory-service running on port 3000');
});

module.exports = app;
