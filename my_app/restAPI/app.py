import pyodbc
from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)

CORS(app)


def get_db_connection():
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 18 for SQL Server};'
        'SERVER=mathsathome.database.windows.net;'
        'DATABASE=mathsathome;'
        'UID=Team44AEN;'
        'PWD=Alexio123;'
    )
    return conn

@app.route('/')
def index(): 
    return "Hello, World!"

@app.route('/database/children', methods=['GET'])
def get_children():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM Child;')
    children = cursor.fetchall()
    children_list = [{'ID': row[0], 'FamilyID': row[1], 'Name': row[2], 'DOB': row[3].strftime('%d-%m-%y'), 'Sex': row[4], 'Country': row[5], 'LevelOfEducation': row[6]} for row in children]
    conn.close()
    return jsonify(children_list)

@app.route('/database/child', methods=['POST'])
def add_child():
    new_child = request.json
    conn = get_db_connection()
    cursor = conn.cursor()
    query = '''
    INSERT INTO Child (FamilyID, Name, DOB, Sex, Country, LevelOfEducation)
    VALUES (?, ?, ?, ?, ?, ?);
    '''
    cursor.execute(query, (
        new_child['FamilyID'],
        new_child['Name'],
        new_child['DOB'],
        new_child['Sex'],
        new_child['Country'],
        new_child['LevelOfEducation']
    ))
    conn.commit()
    conn.close()
    return "Child added", 201

if __name__ == '__main__':
    app.run(debug=True)
