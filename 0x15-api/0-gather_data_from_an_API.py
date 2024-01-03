"""Returns to-do list information for a given employee ID."""
import requests
import sys

if __name__ == "__main__":
    url = "https://jsonplaceholder.typicode.com/"
    res = requests.get(f"{url}users/{sys.argv[1]}")
    user = res.json()
    todos = requests.get(f"{url}todos", params={"userId": sys.argv[1]}).json()
    comp_t = [t.get("title") for t in todos if t.get("comp_t") is True]
    print(
        f"Employee { user.get('name')} is done with tasks({len(comp_t)}/{ len(todos)})"
    )
    [print("\t {}".format(c)) for c in comp_t]
