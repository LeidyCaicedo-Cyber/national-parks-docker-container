// State park directory API - a tiny web server that answers ONE
// question: "which parks are in the directory?" It listens on
// port 3000, connects to SQL Server, and turns table rows into
// JSON.

const express = require('express');
const mssql = require('mssql');

const app = express();

// The db connection config. Notice the server name is "db" -
// the name of the service in compose.yaml. Docker's DNS resolves
// it to the database container's IP address. The password comes
// from an environment variable, not this file.
const config = {
  server: process.env.DB_HOST || 'db',
  user: 'sa',
  password: process.env.DB_PASSWORD,
  database: 'ParksDb',
  options: {
    encrypt: false,
    trustServerCertificate: true,
  },
  connectionTimeout: 15000,
  requestTimeout: 15000,
};

app.get('/api/parks', async (req, res) => {
  try {
    const pool = await mssql.connect(config);
    const result = await pool.request().query(
      'SELECT Id, Name, State, Established, Acres, Description FROM Parks ORDER BY Established'
    );
    // Rename columns to camelCase so the webpage's fetch() gets
    // clean JSON keys: { id, name, state, established, acres, description }
    const parks = result.recordset.map(row => ({
      id: row.Id,
      name: row.Name,
      state: row.State,
      established: row.Established,
      acres: row.Acres,
      description: row.Description,
    }));
    res.json(parks);
  } catch (err) {
    console.error('database error:', err.message);
    res.status(500).json({ error: 'database unavailable' });
  }
});

// Health check endpoint: proves the container is alive and
// listening, even when no database is connected. We use this
// to test the image before the database exists.
app.get('/', (req, res) => {
  res.json({ status: 'ok' });
});

// Every other path is a 404. The load balancer only forwards
// /api/* here, so this should rarely happen.
app.use((req, res) => {
  res.status(404).json({ error: 'not found' });
});

const port = 3000;
app.listen(port, () => {
  console.log(`parks api listening on port ${port}`);
});
