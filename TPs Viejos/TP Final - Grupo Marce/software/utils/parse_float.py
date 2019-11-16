# coding=utf-8
import re

def getText(text, neg=False):

    # regnumber = re.compile(r'^\d+(?:[,.]\d*)?$')
    #
    # if not regnumber.match(text.get("1.0", 'end-1c')):
    #     return None
    # else:
    #     return float(text.get("1.0", 'end-1c'))
    txt = text.get("1.0", 'end-1c')
    #print("text = ", txt)
    try:
        return float(txt)
    except ValueError:
        return None