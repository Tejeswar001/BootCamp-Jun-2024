import mysql.connector

connection = mysql.connector.connect(host='localhost',database='world',user='root',password='Password')
if connection.is_connected():
    print("hey, you are connected")
    c = connection.cursor()
    c.execute("select max(ID),min(ID),sum(ID) from city")
    r = c.fetchall()
    for i in r:
        print(i)
