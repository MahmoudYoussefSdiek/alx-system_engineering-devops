#!/usr/bin/python3
"""
Python script that, using this REST API, for a given employee ID,
exports information about his/her TODO list progress to a CSV file.
"""

import csv
import requests
from sys import argv


if __name__ == '__main__':
    user_id = argv[1]
    user_url = 'https://jsonplaceholder.typicode.com/users/{}'.format(user_id)
    todo_url = 'https://jsonplaceholder.typicode.com/todos?userId={}'.format(
        user_id)

    user_response = requests.get(user_url)
    todo_response = requests.get(todo_url)

    user_data = user_response.json()
    todo_data = todo_response.json()

    csv_filename = '{}.csv'.format(user_id)
    with open(csv_filename, mode='w') as csv_file:
        fieldnames = [
            'USER_ID', 'USERNAME', 'TASK_COMPLETED_STATUS', 'TASK_TITLE']
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)

        writer.writeheader()
        for task in todo_data:
            writer.writerow({
                'USER_ID': user_id,
                'USERNAME': user_data['username'],
                'TASK_COMPLETED_STATUS': str(task['completed']),
                'TASK_TITLE': task['title']
            })
