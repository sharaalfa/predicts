import pandas as pd
import numpy as np
from tkinter import*

a=pd.read_excel('C:/Users/admin/Downloads/01/01.xlsx',\
                index_col=1)
a1=a.dropna()
a1.at[a1['cult']==1,'cult']='Да'
a1.at[a1['cult']==0,'cult']='Нет'
b=pd.DataFrame({
                #'Населенный пункт':a1['city'],\
                'Количество вузов':a1['edu'],\
                'Численность населения':a1['pop'],\
                'Средние доходы':a1['inc'],\
                'Криминогенность':a1['crime'],\
                'Наличие культурного центра':a1['cult']
                })


# создание базового окна
#root=Tk()
#root.title("Правильное решение")
#root.geometry("800x400")
# внутри окна создается рамка для
# размещения других элементов
#app=Frame(root)
#app.grid()


class Application(Frame):
    """GUI-приложение, определяющее значимые параметры\
для принятия решения открытия филиала НИУ ВШЭ"""
    def __init__(self,master):
        super(Application,self).__init__(master)
        self.grid()
        self.create_widgets()
        
    def create_widgets(self):
        
        # метка-инструкция
        self.inst_lbl=Label(self,text="Чтобы получить данные по конкретному\
        населенному пункту, достаточно ввести \
        его наименование с учетом регистра")
        self.inst_lbl.grid(row=0,column=0,columnspan=2,sticky=W)
        # метка около поля ввода наименование населенного пункта
        self.ord_lbl=Label(self,text="Введите наименование :")
        self.ord_lbl.grid(row=4,column=1,sticky=W)
        # текстовое поле для ввода наименования с учетом регистра
        self.ord_ent=Entry(self)
        self.ord_ent.grid(row=5,column=1,sticky=W)
        
        # кнопка отправки значения
        self.submit_but=Button(self,text="Показать",command=self.reveal)
        self.submit_but.grid(row=6,column=1)
        # кнопка расчета зависимости отклика и фичей
        self.s_but=Button(self,text="Корреляционная матрица",\
                         width=30,height=5,\
                         bg="white",fg="blue",command=self.printer)
        self.s_but.grid(row=8,column=0)
        self.s_but=Button(self,text="Список населенных пунктов",\
                         width=30,height=5,\
                         bg="black",fg="white",command=self.city)
        self.s_but.grid(row=8,column=1)
        # создание текстовых областей, в которые будет выведены ответы
        self.city_txt=Text(self,width=54,height=1,font="14",wrap=WORD)
        self.city_txt.grid(row=3,column=0,padx=1,pady=5)
        self.city_txt1=Text(self,width=54,height=1,font="14",wrap=WORD)
        self.city_txt1.grid(row=4,column=0,padx=1,pady=10)
        self.city_txt2=Text(self,width=54,height=1,font="14",wrap=WORD)
        self.city_txt2.grid(row=5,column=0,padx=1,pady=10)
        self.city_txt3=Text(self,width=54,height=1,font="14",wrap=WORD)
        self.city_txt3.grid(row=6,column=0,padx=1,pady=10)
        self.city_txt4=Text(self,width=54,height=1,font="14",wrap=WORD)
        self.city_txt4.grid(row=7,column=0,padx=1,pady=10)
        #self.txt.bind()
        #self.txt.pack()
        
        
        #self.but.bind("<Button-1>",self.printer)
        #self.but.pack()
    def printer(self):
            print(b.corr())

    def city(self):
        a=pd.read_excel('C:/Users/admin/Downloads/01/01.xlsx')
        a1=a.dropna()
        print(a1['city'])
    def reveal(self):
        #print (b.loc[20])
        c=self.ord_ent.get()
        v=np.array([c], dtype='object')
        x=b.loc[v]
        #f=np.concatenate([b.loc[v]])
        #x=pd.DataFrame()
        #z=x.reindex(index=['a','c','d','s'])

        def data(co):
            x1=x[co]
            x2=pd.DataFrame({'':x1.values})
            return x2.unstack().head()
        


        return self.city_txt.delete(0.0,END),self.city_txt.insert\
               (0.0,{"Численность населения": data('Численность населения')}),\
        self.city_txt1.delete(0.0,END),\
        self.city_txt1.insert(0.0,{"Средние доходы":data('Средние доходы')}),\
        self.city_txt2.delete(0.0,END),\
        self.city_txt2.insert(0.0,{"Криминогенность":data('Криминогенность')}),\
        self.city_txt3.delete(0.0,END),\
        self.city_txt3.insert(0.0,{\
            "Наличие культурного центра":data('Наличие культурного центра')}),\
        self.city_txt4.delete(0.0,END),\
        self.city_txt4.insert(0.0,{"Количество вузов":data('Количество вузов')}),\
    
    
    



    
          
        

# основная часть
root=Tk()
root.title("Где открыть филиал НИУ ВШЭ?")
root.geometry("800x400")
app=Application(root)


app.grid()
root.mainloop()



