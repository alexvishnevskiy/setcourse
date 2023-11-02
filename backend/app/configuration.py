class Config(object):
	"""
	Configuration base, for all environments.
	"""
	DEBUG = False
	TESTING = False
	SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://alex:alex@localhost/setcourse'
	SECRET_KEY = "MINHACHAVESECRETA"
	CSRF_ENABLED = True
	SQLALCHEMY_TRACK_MODIFICATIONS = True
