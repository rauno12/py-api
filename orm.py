from typing import Optional, Awaitable

from config import mysql as mysql_config

from peewee import *
from tornado.web import RequestHandler

# Database connection
db = MySQLDatabase(
    mysql_config['db'],
    user=mysql_config['user'],
    passwd=mysql_config['passwd'],
    host=mysql_config['host']
)


# Database model definitions
class BaseModel(Model):
    class Meta:
        database = db


class Sector(BaseModel):
    id = AutoField()
    parent_id = IntegerField()
    name = CharField()

    class Meta:
        table_name = 'sector'


class Submission(BaseModel):
    id = AutoField()
    session_id = CharField(unique=True)
    username = CharField()
    is_agree_of_terms = BooleanField()

    class Meta:
        table_name = 'submission'


class SubmissionSector(BaseModel):
    submission_id = ForeignKeyField(Submission, backref='sectors')
    sector_id = ForeignKeyField(Sector, object_id_name='asd')

    class Meta:
        table_name = 'submission_sector'
        primary_key = CompositeKey('submission_id', 'sector_id')


# Request handler "middleware" for opening and closing ORM database connections
class OrmRequestHandler(RequestHandler):
    def prepare(self):
        db.connect()
        return super(OrmRequestHandler, self).prepare()

    def on_finish(self):
        if not db.is_closed():
            db.close()
        return super(OrmRequestHandler, self).on_finish()

    def data_received(self, chunk: bytes) -> Optional[Awaitable[None]]:
        pass
