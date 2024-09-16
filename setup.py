from setuptools import setup, find_packages

setup(
    name='projectzerodays-vengence',
    version='1.0.0',
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'Flask',
        'Flask-SQLAlchemy',
        'Flask-Bcrypt',
        'Flask-Login',
        'Flask-WTF',
        'Flask-Mail',
        'Pillow',
        'requests',
        'pytest'
    ],
    entry_points={
        'console_scripts': [
            'run=run:main',
        ],
    },
)
