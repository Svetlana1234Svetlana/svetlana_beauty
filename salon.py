import psycopg2 as ps

connection = ps.connect(
     host='localhost',
     user='postgres',
     password='123',
     database='demo',
     port='5432'
)
cursor = connection.cursor()
print("Добро пожаловать в систему управления салоном Светлана")
print("Выберите действие:(1-4)")
print("1. Вывести список салонов")
print("2. Вывести список клиентов")
print("3. Добавить новый салон")
print("4. Добавить нового клиента")


action = int(input())
if (action == 1):
    cursor = connection.cursor()
    postgreSQL_select_Query = "select * from salon.salons"
    cursor.execute(postgreSQL_select_Query)
    salon = cursor.fetchall()
    print (salon)
elif (action == 2):
    cursor = connection.cursor()
    postgreSQL_select_Query = "select * from salon.clients"
    cursor.execute(postgreSQL_select_Query)
    client = cursor.fetchall()
    print (client)
elif (action == 3):
    cursor = connection.cursor()
    insert_query = """insert into salon.salons (name_salon, contact_phone, address)
    values ('Рейбан2', '89777904638', 'г Москва ул. Зюганова 18');"""
    cursor.execute(insert_query)
    connection.commit()
    print("Новый салон добавлен")
elif (action == 4):
    cursor = connection.cursor()
    insert_query = """insert into salon.clients (name_clients, contact_phone)
    values ('Урманов', '89777893517');"""
    cursor.execute(insert_query)
    connection.commit()
    print("Новый  клиент добавлен")
else:
    print("Ошибка")










