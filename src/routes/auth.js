const express = require('express');
const db = require('../db');

const router = express.Router();

// TODO Issue #1: No rate limiting on login endpoint - SECURITY RISK
// Brute force attacks are possible - need to add Rate_Limits table & middleware
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await db.query(
      'SELECT * FROM users WHERE email = $1',
      [email]
    );

    if (!user.rows.length) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    const isValid = await bcrypt.compare(password, user.rows[0].password_hash);
    if (!isValid) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    const token = generateToken(user.rows[0]);
    res.json({ token });
  } catch (err) {
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.post('/logout', (req, res) => {
  // Invalidate session
  res.json({ success: true });
});

module.exports = router;
