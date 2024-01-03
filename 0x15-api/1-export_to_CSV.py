#!/usr/bin/python3
"""Exports information to CSV format."""
import csv
import requests
import sys

if __name__ == "__main__":
    user_id = sys.argv[1]
    url = "https://jsonplaceholder.typicode.com/"
    res = requests.get(f"{url}users/{sys.argv[1]}")
    user = res.json()
    name = user.get("username")
    todos = requests.get(url + "todos", params={"userId": user_id}).json()

    with open(f"{user_id}.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
        writer.writerows(
            [user_id, name, x.get("completed"), x.get("title")] for x in todos
        )
