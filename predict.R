if (!require("tcltk"))
{
print("����� �� ����������")
stop()
}
if (!require("gWidgets"))
{
print("����� �� ����������")
stop()
}
if (!require("gWidgetstcltk"))
{
print("����� �� ����������")
stop()
}
if (!require("gWidgetsRGtk2"))
{
print("����� �� ����������")
stop()
}
if(!require("xlsx"))
{
print("����� �� ����������")
stop()
}
if(!require("car"))
{
print("����� �� ����������")
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



w<-gwindow("����������� �������", visible=TRUE, encoding="UTF-8",
width=700, height=1000, toolkit=guiToolkit())
group<-ggroup(horizontal=FALSE, container=w)
obj <- glabel("������ ����������", container =group,
handler = function(h,...)
gmessage("�������� ��������� ��� ������� � ����������(-��)"))
obj <- gcombobox(c("income","population","education","crime","culture"), container=group)
obj <- gedit("����� �������� ���������� ��� �������� �������(-��) ��� ���", container=group)
obj <- gtext("��������� ������������� ���� ������ ��������.
�������� ��� ���������������, � ����� �������� t-test ����������, ���������� ����� ����.
�������, �� ������ ��������� ���� ������", container=group, font.attr=list(style="bold"))

obj <- gbutton("������� ������", encoding="UTF-8", container=group,
handler = function(h,...) gtable(work, expand=TRUE, container = w))

obj <- gbutton("��������� �������������", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("density.default", container=TRUE))
obj <- gbutton("�����������", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("hist.default", container=TRUE))
obj <- gbutton("��������� �����&�������", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("boxplot.default", container=TRUE))
obj <- gbutton("�������� ���������", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("plot", container=TRUE))
obj <- gbutton("�������� ���������� �� ������������", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("qqnorm", container=TRUE))
obj <- gbutton("����������� ���������", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("barplot.default", container=TRUE))
obj <- gbutton("t-test", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("t.test", container=TRUE))
obj <- gbutton("���������� �������/�������/��������", encoding="UTF-8", container=group,
handler = function(h,...) ggenericwidget("cor", container=TRUE))
## block closing of window
addHandlerUnrealize(w, handler = function(h,...) {
val <- gconfirm("�� ������������� ������ �������?", parent=h$obj)
if(as.logical(val))
return(FALSE) # destroy
else
return(TRUE) # don't destroy
})








