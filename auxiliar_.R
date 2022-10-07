library(readxl)
library(ggpubr)
##### Altura

expr <- read.delim("https://raw.githubusercontent.com/kassambara/data/master/expr_tcga.txt",
                   stringsAsFactors = FALSE)

expr
dados <- read_xlsx("08_08_conferencia.xlsx")

str(dados)
dados$Variedades <- as.factor(dados$Variedades)
dados$Tratamento <- as.factor(dados$Tratamento)
dados$Repetição <- NULL

library(AgroR)

with(dados,
     FAT2DIC(Variedades, Tratamento, Altura, ylab="Altura (cm)", legend = ""))




g <- ggerrorplot(dados, x = "Tratamento", y = "Altura",
            color = "Variedades", palette = "Paired",
            error.plot = "pointrange",
            position = position_dodge(0.5), facet.by = 
              "Variedades", label = c("a"))

g
g <- g + geom_text(ALT_0808_LETRAS, mapping = aes(Tratamento = Tratamento, Altura = Altura), label = ALT_0808_LETRAS$label)

ggerrorplot(dados, x = "Variedades", y = "Altura",
            palette = "Paired",
            desc_stat = "mean_ci", ci = 0.95, color = "black",
            add = "jitter", add.params = list(color = "darkgray"),
            position = position_dodge(0.5), facet.by = 
              "Tratamento")




dev.new()
levels(dados$Variedades)
levels(dados$Tratamento)
ALT_0808_LETRAS <- data.frame(Tratamento = c("BACILLUS SUBTILIS"), Altura = c(35), Variedades = c("BRS SEDA"), label = c("a"))

### modelo 1
p <- ggerrorplot(dados, x = "Tratamento", y = "Altura", facet.by = "Variedades", ylab = "Proportion of germinated urediniospores",
                 desc_stat = "mean_sd", color = "black",
                 add = "jitter", add.params = list(color = "darkgray"),
                 xlab = "Treatments")

p <- ggerrorplot(dados, x = "Tratamento", y = "Altura",
                 color = "Variedades", palette = "Paired",
                 error.plot = "pointrange",
                 position = position_dodge(0.5), facet.by = 
                   "Variedades", xlab = "Tratamentos", ylab = "Altura (cm)")


p
g <- p + geom_text(data = ALT_0808_LETRAS,label = ALT_0808_LETRAS$label)
g



#### versaaao 2

TESTEMUNHA <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "TESTEMUNHA",
                         Altura = c(53,60,57), label = c("B", "A", "A"))

BACILLUS <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "BACILLUS SUBTILIS",
                       Altura = c(43,59,47), label = c("B", "A", "B"))

MAXIM <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "MAXIM",
                    Altura = c(53,65,53), label = c("B", "A", "B"))

VITAVAX <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "VITAVAX",
                      Altura = c(60,63,53), label = c("AB", "A", "B"))

TRICHOPLUS <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "TRICHOPLUS",
                         Altura = c(52,59,43), label = c("AB", "A", "B"))

ALT_0808_LETRAS_CULTIVARES <- rbind(TESTEMUNHA, BACILLUS, MAXIM, VITAVAX, TRICHOPLUS)

g <- ggerrorplot(dados, x = "Variedades", y = "Altura",
                 color = "Tratamento", palette = "Paired",
                 error.plot = "pointrange",
                 position = position_dodge(0.5), facet.by = 
                   "Tratamento", xlab = "Cultivares", ylab = "Altura (cm)")

g <- g + geom_text(data = ALT_0808_LETRAS_CULTIVARES,label = ALT_0808_LETRAS_CULTIVARES$label)
g <- g + rotate_x_text(90)
g


ea2(dados, design = 1, list = TRUE)

### Modelo linear

str(dados)

model <- lm(rank(Massa_fresca_raízes) ~ Variedades * Tratamento, data = dados)

ea2(dados, design = 1, list = TRUE)

shapiro.test(residuals(model)) 
bartlett.test(residuals(model), dados$Tratamento)

dev.new()
boxplot(dados$Massa_fresca_raízes ~ dados$Variedades)
boxplot(dados$Massa_fresca_raízes~ dados$Tratamento)

######################################################
######################################################

model_normal <- glm(Massa_fresca_raízes ~ Variedades * Tratamento, data = dados)
model_poisson <- glm( Massa_fresca_raízes ~ Variedades * Tratamento, family = "poisson", data = dados)
model_qpoisson <- glm (Massa_fresca_raízes ~ Variedades * Tratamento, family = "quasipoisson", data = dados)
model_binomial <- glm(URE ~ Tratamentos, family = "binomial", data = BASE_ANL)
model_qbinomial <-glm(URE ~ Tratamentos, family = "quasibinomial", data = BASE_ANL) 

require(MASS)
require(hnp)

model_binomialNegativa<-glm.nb( Massa_fresca_raízes ~ Variedades * Tratamento, data=dados)
###Exibindo novo quadro
dev.new()
par(mfrow=c(3,2))
hnp(model_normal, print.on="T", main="Normal")
hnp(model_poisson, print.on="T", main="Poisson")
hnp(model_qpoisson, print.on="T", main="QuasePoisson")
hnp(model_binomial, print.on="T", main="BN")
hnp(model_qbinomial, print.on="T", main="Quasibinomial")
hnp(model_binomialNegativa, print.on="T", main="Binomail negativa")

#### ANOVA
anova(model_qbinomial, test="F") 
##ou
anova(model_poisson, test="Chisq") ##3 Se for model_poisson test - Chisq
boxplot(BASE_ANL$URE ~ BASE_ANL$Tratamentos)

#### Comparativo de testes
library(lsmeans)
#### Comparativo de medias (PODE SER COM A ANOVA TAMB�M)
MEDIA <- emmeans(model_qbinomial, "Tratamentos") ### Cria as comparações do modelo
MEDFIN<-regrid(MEDIA) ## Retorna a media original

cld(MEDFIN, alpha=0.05, reversed = TRUE, Letters=letters, adjust="tukey") ## Transforma em letras o Teste Tukey






View(dados)
str(dados)

dados$Repetição <- NULL


library(easyanova)


View(dados)
ea2(dados, design = 1, list = TRUE)

?ea2


library(AgroR)
