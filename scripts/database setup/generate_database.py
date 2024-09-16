from app import db
from app.models import User, Post

# Create the database and the database table
db.create_all()

# Insert user data
user1 = User(username='admin', email='admin@example.com', password='password')
db.session.add(user1)
db.session.commit()

print("Database generated successfully!")
