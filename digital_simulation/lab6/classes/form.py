import tkinter as tk
#
# def submit(name,age):
#     print("Name:", name.get())
#     print("Age:", age.get())
#
# def display():
#     root = Tk()
#     root.title("Digital simulation")
#     root.geometry("300x200")
#     root.maxsize(900, 600)
#     root.minsize(300, 300)
#     root.config(bg="skyblue")
#     root.configure(padx=10, pady=10)
#
#     # Создаем метки и поля ввода
#     name_label = Label(root, text="Name:")
#     name_label.grid(row=0, column=0)
#
#     name = Entry(root)
#     name.grid(row=0, column=10)
#
#     age_label = Label(root, text="Age:")
#     age_label.grid(row=1, column=0)
#
#     # message = Message(root, text="Вычислительная система состоит из трех ЭВМ. С интервалом () мин. в систему поступают задания, которые с вероятностью: () идут на первую ЭВМ, с () адресуются второй ЭВМ, а все остальные идут на обработку на третью ЭВМ. Перед каждой ЭВМ имеется очередь заданий, длина которой не ограничена. После обработки задания на первой ЭВМ оно с вероятностью () поступает в очередь ко второй ЭВМ и с вероятностью () - в очередь к третьей ЭВМ. После обработки на второй или третьей ЭВМ задание считается выполненным.")
#     # message.grid(row=1, column=0)
#
#     age = Entry(root)
#     age.grid(row=1, column=1)
#
#     # Создаем кнопку для отправки данных
#     submit_button = Button(root, text="Submit", command=submit)
#     submit_button.grid(row=2, column=0, columnspan=2)
#
#     root.mainloop()
class Form:
    def __init__(self, root):
        self.root = root
        self.frame = tk.Frame(self.root)
        self.frame.pack()

        self.label1 = tk.Label(self.frame, text="Name:")
        self.label1.grid(row=0, column=0)
        self.entry1 = tk.Entry(self.frame)
        self.entry1.grid(row=0, column=1)

        self.label2 = tk.Label(self.frame, text="Email:")
        self.label2.grid(row=1, column=0)
        self.entry2 = tk.Entry(self.frame)
        self.entry2.grid(row=1, column=1)

        self.button = tk.Button(self.frame, text="Submit", command=self.submit)
        self.button.grid(row=2, columnspan=2)

    def submit(self):
        name = self.entry1.get()
        email = self.entry2.get()
        print(f"Name: {name}")
        print(f"Email: {email}")