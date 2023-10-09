attr = {
  email:  'test@example.com',
  password: 'admin123',
  confirmed_at: Time.current,
  confirmation_sent_at: Time.current
}

Administrator.create!(attr)
