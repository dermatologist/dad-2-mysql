# Loads the dad database on to a MySQL database
# By Bell Eapen
# Last modified on May 1, 2018

import csv

import pymysql.cursors

import settings

# Connect to the database
connection = pymysql.connect(host=settings.HOST, user=settings.USER,
                             password=settings.PASSWORD, db=settings.DB, charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)

# Step 1. Convert dad spss files to csv using pspp-convert
with open(settings.FILENAME, newline='') as f:
    # reader = csv.DictReader(f) # Use this reader if you want to address by column name
    reader = csv.reader(f)
    next(reader, None)  # skip the headers
    for row in reader:
        print(row[0])
        add_row = (row[1], row[11], row[3], row[4], row[2], row[5], row[8], row[6],
                   row[7], row[9], row[10], row[141], row[154], row[155], row[156], row[157], row[158])
        try:
            with connection.cursor() as cursor:
                # Create a new encounter
                sql = "INSERT INTO `encounter` " \
                      "(`patient_id`, `morbidity`, `age`, `gender`, " \
                      "`province`, `inst_from`, `inst_to`, `admit_cat`, `entry_code`, " \
                      "`discharge_disp`, `weight`, `gestation`, `tlos`, `alos`, `alc_los`, `rel_discharge`, " \
                      "`rel_admission`) " \
                      "VALUES (%s, %s, %s, %s, %s, %s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
                cursor.execute(sql, add_row)
                encounter_id = connection.insert_id()

                # Fix any blank cells
                column_range = range(1, 153)
                for column in column_range:
                    if row[column] == ' ':
                        row[column] = '-1'

                # Create the linked diagnosis records
                column_range = range(11, 60)
                for column in column_range:
                    if column % 2 == 1:
                        if len(row[column]) > 2:
                            print(row[column] + ' | ' + row[column + 1])
                            sql = "INSERT INTO `morbidity` " \
                                  "(`icd_10_ca`, `type`, `encounter_encounter_id`) " \
                                  "VALUES (%s, %s, %s)"
                            cursor.execute(sql, (row[column], row[column + 1], encounter_id))

                # Create the linked intervention records
                column_range = range(61, 140)
                for column in column_range:
                    if column % 4 == 1:
                        if len(row[column]) > 2:
                            print(row[column] + ' | ' + row[column + 1] + ' | ' + row[column + 2] + ' | ' + row[
                                column + 3])
                            sql = "INSERT INTO `intervention` " \
                                  "(`cci_code`, `status`, `location`, `anaesthetic`, `encounter_encounter_id`) " \
                                  "VALUES (%s, %s, %s, %s, %s)"
                            cursor.execute(sql, (row[column], row[column + 1],
                                                 row[column + 2], row[column + 3], encounter_id))

                # Create the linked speciality care records
                column_range = range(142, 153)
                for column in column_range:
                    if column % 2 == 0:
                        if int(row[column]) < 99:
                            print(row[column] + ' | ' + row[column + 1])
                            sql = "INSERT INTO `special_care` " \
                                  "(`unit`, `hours`, `encounter_encounter_id`) " \
                                  "VALUES (%s, %s, %s)"
                            cursor.execute(sql, (row[column], row[column + 1],
                                                 encounter_id))


        finally:
            connection.commit()

with connection.cursor() as cursor:
    # Read a single record
    sql = "SELECT `patient_id` FROM `encounter` WHERE `gender`=%s"
    cursor.execute(sql, (1))
    result = cursor.fetchall()
    print(result)

connection.close()
