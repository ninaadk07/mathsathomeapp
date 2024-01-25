import pyodbc
from werkzeug.security import generate_password_hash, check_password_hash #to not store passwords without hashing
from flask import Flask, jsonify, request
from flask_cors import CORS
from flask import session

app = Flask(__name__)
app.config['SECRET_KEY'] = 'Alexio123' # Replace with a real secret key
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
    parent_family_id = request.headers.get('FamilyID')

    try:
        parent_family_id = int(parent_family_id)
    except (TypeError, ValueError):
        return jsonify({'error': 'Invalid FamilyID'}), 400

    conn = get_db_connection()
    cursor = conn.cursor()

    query = '''
    INSERT INTO Child (FamilyID, Name, DOB, Sex, Country, LevelOfEducation)
    VALUES (?, ?, ?, ?, ?, ?);
    '''
    
    try:
        cursor.execute(query, (
            parent_family_id,
            new_child['Name'],
            new_child['DOB'],
            new_child['Sex'],
            new_child['Country'],
            new_child['LevelOfEducation']
        ))
        conn.commit()
        return jsonify({'message': 'Child added'}), 201
    except pyodbc.Error as e:
        conn.rollback()
        print("Database error:", e)  # Print the error details
        return jsonify({'error': 'Database error', 'details': str(e)}), 500
    finally:
        conn.close()


@app.route('/database/register', methods=['POST'])
def register_user():
    data = request.json
    username = data.get('username')
    email = data.get('email')
    password = data.get('password')

    hashed_password = generate_password_hash(password)

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        cursor.execute('''
            INSERT INTO Family (Username, Email, PasswordHash) 
            VALUES (?, ?, ?);
        ''', (username, email, hashed_password))
        conn.commit()
        return jsonify({'message': 'User registered successfully'}), 201
    except pyodbc.Error as e:
        print(e)
        conn.rollback()
        return jsonify({'error': 'Could not register user'}), 500
    finally:
        conn.close()

@app.route('/login', methods=['POST'])
def login():
    data = request.json
    email = data.get('email')
    password = data.get('password')

    # Database connection
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Query to select user based on email
        cursor.execute("SELECT ID, PasswordHash FROM Family WHERE Email = ?", email)
        user = cursor.fetchone()

        if user and check_password_hash(user.PasswordHash, password):
            # Correct credentials, return success response
            return jsonify({'message': 'Login successful', 'familyID': user.ID}), 200
        else:
            # Incorrect credentials
            return jsonify({'error': 'Invalid credentials'}), 401
    except pyodbc.Error as e:
        print(e)
        return jsonify({'error': 'Database error'}), 500
    finally:
        conn.close()

if __name__ == '__main__':
    app.run(debug=True)
