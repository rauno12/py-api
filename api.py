from playhouse.shortcuts import model_to_dict
from tornado.ioloop import IOLoop
from tornado.web import Application

from orm import db, OrmRequestHandler, Sector, Submission, SubmissionSector, DoesNotExist

import json
import uuid

# Handler for Sector-s
class SectorRequestHandler(OrmRequestHandler):
    def get(self):
        response_data = []
        for sector in Sector.select():
            # Convert a model instance to a dictionary
            response_data.append(model_to_dict(sector))

        # Convert dictionary to JSON and return
        self.write(json.dumps(response_data))

# Handler for Submission-s
class SubmissionRequestHandler(OrmRequestHandler):
    # Creating a new Submission record
    # Service will generate and return session_id (tied with this submission)
    def post(self, _):
        payload = json.loads(self.request.body)

        # Generate new session id
        session_id = generate_session_id()

        # Start transaction for data integrity (relational tables update)
        with db.transaction():
            # Create new main record
            s = Submission.create(
                session_id=session_id,
                username=payload['username'],
                is_agree_of_terms=payload['is_agree_of_terms']
            )

            # Create relations between Submission ans sectors
            for sector in payload['sectors']:
                SubmissionSector.create(
                    submission_id=s.id,
                    sector_id=sector['sector_id']
                )

        # Set HTTP status 201 Created
        self.set_status(201)

        # Set generated session_id as response
        self.write({'session_id': '%s' % session_id})

    # Update existing Submission record.
    # session_id is used as a unique reference for update.
    def put(self, session_id):
        # Decode given request body from JSON format
        payload = json.loads(self.request.body)

        # Determine existence of Submission of given session
        try:
            submission = Submission.get(Submission.session_id == session_id)
        except DoesNotExist:
            # Return HTTP status 404 Not Found
            self.set_status(404)
            return

        # Start transaction for data integrity (relational tables update)
        with db.transaction():
            submission.username = payload['username']
            submission.is_agree_of_terms = payload['is_agree_of_terms']
            submission.save()

            # Swipe first all existing relations, then add new ones
            SubmissionSector.delete().where(
                SubmissionSector.submission_id == submission.id
            ).execute()

            # Create new relations between Submission ans sectors
            for sector in payload['sectors']:
                SubmissionSector.create(
                    submission_id=submission.id,
                    sector_id=sector['sector_id']
                )

        # Set HTTP status 204 No Content (Success)
        self.set_status(204)

    # Get submission data by session_id
    def get(self, session_id):
        # Determine existence of Submission of given session
        try:
            submission = Submission.get(Submission.session_id == session_id)
        except DoesNotExist:
            # Return HTTP status 404 Not Found
            self.set_status(404)
            return

        # Convert a model instance to a dictionary
        model_dict = model_to_dict(submission, backrefs=True, max_depth=1, exclude=[Submission.id, Submission.session_id])

        # Convert dictionary to JSON and return
        self.write(json.dumps(model_dict))


# Function to generate unique session id
def generate_session_id():
    return uuid.uuid4().hex

def make_api():
    return Application([
        (r'/sectors', SectorRequestHandler),
        (r'/submission/([a-zA-Z0-9]+)', SubmissionRequestHandler)
    ])

if __name__ == '__main__':
    app = make_api()
    app.listen(8888)
    IOLoop.current().start()