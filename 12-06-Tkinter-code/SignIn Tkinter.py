from tkinter import *

root = Tk()
root.title('sign in')
root.geometry('500x400')

name = StringVar()
email = StringVar()
phno = StringVar()

def userdata():
    n = name.get()
    e = email.get()
    p = phno.get()

    print(f"user {n}\n email {e}\n Phone number {p}")

    name.set('')
    email.set('')
    phno.set('')
    

f1 = Frame(root)
f1.pack(pady = 25)

l1 = Label(f1, text = 'Sign In', font = ('black',30))
l1.pack()

f2 = Frame(root)
f2.pack(padx = 40, pady = 15)

l2 = Label(f2, text = 'username', font = ('black',10))
l2.pack(side = 'left',padx = 10)

e1 = Entry(f2, textvariable = name, width = 30)
e1.pack(side = 'right')

f3 = Frame(root)
f3.pack(padx = 40, pady = 15)

l3 = Label(f3, text = 'Email', font = ('black',10))
l3.pack(side = 'left', padx = 10)

e2 = Entry(f3, textvariable = email, width = 30)
e2.pack(side = 'right')

f4 = Frame(root)
f4.pack(padx = 40, pady = 15)

l4 = Label(f4, text = 'Phone No.', font = ('black',10))
l4.pack(side = 'left', padx = 10)

e3 = Entry(f4, textvariable = phno, width = 30)
e3.pack(side = 'right')

f5 = Frame(root)
f5.pack(padx = 40,pady = 5)

b1 = Button(f5,text = 'submit',width = 9,height = 2, command = userdata)
b1.pack(pady = 5, padx = 5)

root.mainloop()

