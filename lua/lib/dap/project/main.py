#! venv/bin/python
# -*- coding:utf-8 -*-

import requests


def main():
    response = requests.get("https://www.baidu.com")
    print(response.text)


if __name__ == "__main__":
    main()
