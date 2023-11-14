class Config(object):
	"""
	Configuration base, for all environments.
	"""
	DEBUG = True
	TESTING = False 
	SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://alex:alex@localhost/setcourse' # use this one for docker 'mysql+pymysql://alex:alex@mysql/setcourse'
	SECRET_KEY = "MINHACHAVESECRETA"
	CSRF_ENABLED = True
	SQLALCHEMY_TRACK_MODIFICATIONS = True
