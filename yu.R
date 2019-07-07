data=read.table('C:/Users/Administrator/Desktop/���Ѵ�������/���Ѵ�������.csv',sep=',',header = T)
summary(data$��������)
data$��������[data$��������==0]=1
mydata=data
summary(mydata)


###############�ִ���������
wz=paste(mydata$��������,collapse = '')
summary(wz)
library(jiebaR)
cutter=worker()
segment=cutter[wz]
worfre=freq(segment)
#head(worfre)


###########��ȡ��Ƶ��
library(wordcloud2)
#wordcloud2(worfre)
newword=subset(worfre,nchar(worfre$char)!=1)
#wordcloud2(newword)
head(newword[order(newword$freq,decreasing = T),],40)
aa=head(newword[order(newword$freq,decreasing = T),],100)
wordcloud2(aa)


#################�����
newdata=data.frame(mydata$��˾����)
newdata$��������=log(mydata$��������)


#################�Ա������������5��
newdata$����[grep('����|����|��',mydata$��������)]=1
newdata$����[is.na(newdata$����)]=0
newdata$����[1046]=0
newdata$����[grep('����|��ˮ|����|����',mydata$��������)]=1
newdata$����[is.na(newdata$����)]=0
newdata$�Ʋ�[grep('����|��',mydata$��������)]=1
newdata$�Ʋ�[is.na(newdata$�Ʋ�)]=0
newdata$����[grep('����|����',mydata$��������)]=1
newdata$����[is.na(newdata$����)]=0
newdata$�籣[1046]=0
newdata$�籣[grep('�籣|������|����|����',mydata$��������)]=1
newdata$�籣[is.na(newdata$�籣)]=0


#############�Ա�������������
#�Ա���������
summary(mydata$����)
newdata$һ��[mydata$����%in%c("����","�Ϻ�","����","����")]=1
newdata$һ��[is.na(newdata$һ��)]=0
newdata$����[mydata$����%in%c("�ɶ�","����","����","���","����")]=1
newdata$����[is.na(newdata$����)]=0


#�Ա������¹�����
testdata<-data.frame(mydata$�¹���������)
�·�=lapply(testdata, function(x) as.numeric(sub("%", "", x))/100)
newdata$�·�=�·�$mydata.�¹���������

#�Ա�����������ͷ�Χ��������߷�Χ
tapply(mydata$��������,mydata$������ͷ�Χ,mean)
newdata$lowtim1[mydata$������ͷ�Χ%in%c(1,3)]=1
newdata$lowtim1[is.na(newdata$lowtim1)]=0
newdata$lowtim2[mydata$������ͷ�Χ==6]=1
newdata$lowtim2[mydata$������ͷ�Χ!=6]=0

tapply(mydata$��������,mydata$������߷�Χ,mean)
summary(mydata$������߷�Χ)
summary(as.factor(mydata$������߷�Χ))

newdata$hightim1[mydata$������߷�Χ<=24]=1
newdata$hightim1[is.na(newdata$hightim1)]=0
newdata$hightim2[mydata$������߷�Χ>24&mydata$������߷�Χ<=36]=1
newdata$hightim2[is.na(newdata$hightim2)]=0

#�Ա��������ʽ

tapply(mydata$��������,mydata$���ʽ,mean)
newdata$repay1[mydata$���ʽ=="���ڻ���"]=1
newdata$repay1[mydata$���ʽ!="���ڻ���"]=0
newdata$repay2[mydata$���ʽ=="���ڻ���"]=1
newdata$repay2[mydata$���ʽ!="���ڻ���"]=0

#�Ա������ſ����ڡ�����ʱ��


tapply(mydata$��������,mydata$�ſ�����,mean)
summary(mydata$�ſ�����)
summary(as.factor(mydata$�ſ�����))


newdata$loantim1[mydata$�ſ�����%in%c(0:3)]=1
newdata$loantim1[is.na(newdata$loantim1)]=0
newdata$loantim2[mydata$�ſ�����%in%c(4:7)]=1
newdata$loantim2[is.na(newdata$loantim2)]=0

tapply(mydata$��������,mydata$����ʱ��,mean)
summary(mydata$����ʱ��)
summary(as.factor(mydata$����ʱ��))

newdata$examtim1[mydata$����ʱ��%in%c(0:3)]=1
newdata$examtim1[is.na(newdata$examtim1)]=0


#�Ա�����������ʽ

tapply(mydata$��������,mydata$������ʽ,mean)
b=as.data.frame(a)

newdata$guar1[mydata$������ʽ=="���ô�"]=1
newdata$guar1[is.na(newdata$guar1)]=0
newdata$guar2[mydata$������ʽ=="������"]=1
newdata$guar2[is.na(newdata$guar2)]=0
newdata$guar3[mydata$������ʽ=="��Ѻ��"]=1
newdata$guar3[is.na(newdata$guar3)]=0


#############���Իع�
#��Ԫ����
fit=lm(��������~.-1-mydata.��˾����,data=newdata)
summary(fit)
par(mfrow=c(2,2))
plot(fit)
#��
tstep<-step(fit)
summary(tstep)
par(mfrow=c(2,2))
plot(tstep)


#############������ͳ��

library(ggplot2)
require(gridExtra)
#�����
par(mfrow=c(2,2))
ggplot(data=mydata) + geom_histogram(aes(x=��������),bins=30,fill="lightblue")



#�Ա���������
mydata=subset(mydata,mydata$��������<750)
pcity1=ggplot(mydata,aes(y=��������, x=����)) + geom_boxplot(fill="lightblue")
����������ֵ=tapply(mydata$��������,mydata$����,mean)
b=as.data.frame(����������ֵ)
pcity2=ggplot(data = b, mapping = aes( x=row.names(b),y=����������ֵ)) + geom_bar(stat = 'identity',fill="lightblue")
grid.arrange(pcity1,pcity2, ncol=1, nrow=2)


#�Ա������Ŵ�ģʽ

mydata1=subset(mydata,mydata$��������<750)
repay1=ggplot(mydata1,aes(y=��������, x=���ʽ)) + geom_boxplot(fill="lightblue")
����������ֵ=tapply(mydata$��������,mydata$���ʽ,mean)
b=as.data.frame(����������ֵ)
repay2=ggplot(data = b, mapping = aes( x=row.names(b),y=����������ֵ)) + geom_bar(stat = 'identity',fill="lightblue")

gur1=ggplot(mydata1,aes(y=��������, x=������ʽ)) + geom_boxplot(fill="lightblue")
����������ֵ=tapply(mydata$��������,mydata$������ʽ,mean)
d=as.data.frame(����������ֵ)
gur2=ggplot(data = d, mapping = aes( x=row.names(d),y=����������ֵ)) + geom_bar(stat = 'identity',fill="lightblue")

grid.arrange(repay1,repay2, gur1,gur2,ncol=2, nrow=2)



