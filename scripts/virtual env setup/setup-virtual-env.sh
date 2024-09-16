# Create a virtual environment
python -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Installation Script

# Create a virtual environment
python -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Set up environment variables
export FLASK_ENV=development
export SECRET_KEY=your_secret_key
export SQLALCHEMY_DATABASE_URI=sqlite:///site.db

# Run the generate database script
python scripts/generate_database.py

# Launch the web server
python run.py
