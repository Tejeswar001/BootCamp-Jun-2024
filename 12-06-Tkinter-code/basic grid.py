from tkinter import *

root = Tk()
root.title("Tkinter window")
root.configure(bg = 'white')
root.geometry('300x100')

name = StringVar()
passw = StringVar()

def run():
    n = name.get()
    p = passw.get()

    print(f"Your Name: {n}")
    print(f"Your Password: {p}")

    name.set("")
    passw.set("")

l1 = Label(root, text = 'Hello, enter your name and set a password!')
l1.grid(row=0,column=1)

l2 = Label(root, text = 'name:')
entry1 = Entry(root,textvariable = name)
l3 = Label(root, text = 'passwaord:')
entry2 = Entry(root,textvariable = passw)

b1 = Button(root,text = "Submit", command = run)

l2.grid(row = 1, column = 0)
entry1.grid(row = 1, column = 1)
l3.grid(row = 2, column = 0)
entry2.grid(row = 2, column = 1)
b1.grid(row = 3, column = 1)

root.mainloop()
