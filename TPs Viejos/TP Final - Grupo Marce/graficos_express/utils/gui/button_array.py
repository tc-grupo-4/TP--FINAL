import tkinter.ttk as ttk
from tkinter import *
from data import *

class ButtonArray(ttk.Frame):
    def __init__(self, container):
        super(ButtonArray, self).__init__(container)
        self.container = container

    def addGreenButton(self, title):
        button = Button(self, height=1,text=title,
                              command=lambda: self.retrieve_input(title), font=data.myFont,
                              background="dark sea green")
        button.pack(side=LEFT, expand=1, fill=BOTH)

    def addRedutton(self, title):
        button = Button(self, height=1,text=title,
                              command=lambda: self.retrieve_input(title), font=data.myFont,
                              background="light coral")
        button.pack(side=LEFT, expand=1, fill=BOTH)

    def addBlueButton(self, title):
        button = Button(self, height=1,text=title,
                              command=lambda: self.retrieve_input(title), font=data.myFont,
                              background="dodger blue")
        button.pack(side=LEFT, expand=1, fill=BOTH)

    def addGold2Button(self, title):
        button = Button(self, height=1, text=title,
                        command=lambda: self.retrieve_input(title), font=data.myFont,
                            background="thistle")
        button.pack(side=LEFT, expand=1, fill=BOTH)

    def retrieve_input(self, name):
        self.container.buttonPressed(name)

