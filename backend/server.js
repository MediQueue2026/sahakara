import express from 'express';
import cors from 'cors';

const app = express();
app.use(cors());
app.use(express.json());

const todayKey = () => new Date().toISOString().slice(0, 10);

const seed = () => {
  const d = todayKey();
  return {
    config: { name: "Kamala", salary: 45000, hours: 8, perStar: 300 },
    tasks: [
      { uid: "a1", lib: "t1", date: d, priority: 1, status: "done", star: true, mins: 30 },
      { uid: "a2", lib: "t8", date: d, priority: 1, status: "open", star: false, mins: 60 },
      { uid: "a3", lib: "t4", date: d, priority: 0, status: "open", star: false, mins: 40 },
      { uid: "a4", lib: "t13", date: d, priority: -1, status: "blocked", reason: "supplies", star: false, mins: 30 },
    ],
    attendance: { [d]: "present" },
    ledger: [
      { id: "p1", date: d, type: "advance", amount: 10000, note: "Advance requested" },
    ],
    flags: [],
  };
};

let db = seed();

app.get('/api/state', (req, res) => {
  res.json(db);
});

app.post('/api/state', (req, res) => {
  db = { ...db, ...req.body };
  res.json({ success: true });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Backend running on port ${PORT}`));
