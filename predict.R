if (!require("tcltk"))
{
print("Пакет не установлен")
stop()
}
if (!require("gWidgets"))
{
print("Пакет не установлен")
stop()
}
if (!require("gWidgetstcltk"))
{
print("Пакет не установлен")
stop()
}
if (!require("gWidgetsRGtk2"))
{
print("Пакет не установлен")
stop()
}
if(!require("xlsx"))
{
print("Пакет не установлен")
stop()
}
if(!require("car"))
{
print("Пакет не установлен")
stop()
}
work <- read.xlsx("D:/workR/data/01.xlsx", sheetIndex=1, header=T, encoding="UTF-8")
str(work)
work$pop[is.na(work$pop)]<- mean(work$pop, na.rm=TRUE)
work$inc[is.na(work$inc)] <- mean(work$inc,na.rm=TRUE)
work$crime[is.na(work$crime)] <- mean(work$crime, na.rm=TRUE)
work$edu[is.na(work$edu)] <- mean(work$edu, na.rm=TRUE)
work$cult[198] <- 1
culture <- work$cult
population <- work$pop
crime <- work$crime
income <- work$inc
education <- work$edu



w<-gwindow("Калькулятор решений", visible=TRUE, encoding="UTF-8",
width=700, height=1000, toolkit=guiToolkit())
group<-ggroup(horizontal=FALSE, container=w)
obj <- glabel("Список переменных", container =group,
handler = function(h,...)
gmessage("Выберите инсрумент для анализа и переменную(-ые)"))
obj <- gcombobox(c("income","population","education","crime","culture"), container=group)
obj <- gedit("Найти значимую переменную для открытия филиала(-ов) НИУ ВШЭ", container=group)
obj <- gtext("Наглядное представление дает анализ графиков.
Прелагаю ими воспользоваться, а также провести t-test переменных, корреляцию между ними.
Впрочем, вы можете поставить свою задачу", container=group, font.attr=list(style="bold"))

obj <- gbutton("Таблица данных", encoding="UTF-8", container=group,
handler = function(h,...) gtable(work, expand=TRUE, container = w))

obj <- gbutton("Плотность распределения", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("density.default", container=TRUE))
obj <- gbutton("Гистограмма", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("hist.default", container=TRUE))
obj <- gbutton("Диаграмма бокса&уискера", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("boxplot.default", container=TRUE))
obj <- gbutton("Точечная диаграмма", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("plot", container=TRUE))
obj <- gbutton("Проверка переменной на нормальность", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("qqnorm", container=TRUE))
obj <- gbutton("Столбиковая диаграмма", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("barplot.default", container=TRUE))
obj <- gbutton("t-test", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("t.test", container=TRUE))
obj <- gbutton("Корреляция Пирсона/Кендала/Спирмена", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("cor", container=TRUE))
## block closing of window
addHandlerUnrealize(w, handler = function(h,...) {
val <- gconfirm("Вы действительно хотите закрыть?", parent=h$obj)
if(as.logical(val))
return(FALSE) # destroy
else
return(TRUE) # don't destroy
})








