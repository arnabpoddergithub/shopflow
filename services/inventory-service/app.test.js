const request = require('supertest');
const app = require('./app');

test('health check returns 200', async () => {
  const res = await request(app).get('/health');
  expect(res.statusCode).toBe(200);
});

test('get inventory returns 200', async () => {
  const res = await request(app).get('/inventory');
  expect(res.statusCode).toBe(200);
});

test('get specific item returns 200', async () => {
  const res = await request(app).get('/inventory/laptop');
  expect(res.statusCode).toBe(200);
  expect(res.body.stock).toBe(50);
});

test('unknown item returns 404', async () => {
  const res = await request(app).get('/inventory/unknown');
  expect(res.statusCode).toBe(404);
});
