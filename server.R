
library(shiny)
library(shinydashboard)
library(AgroR)
library(ggpubr)

ALTURA_0808 <- read_xlsx("08_08_conferencia.xlsx")
ALTURA_1608 <- read_xlsx("16_08.xlsx")

unique(ALTURA_0808$Tratamento)
unique(ALTURA_0808$Variedades)

shinyServer(function(input,output){
  
  #### Comparativo de tratamentos para cada cultivar
  
  output$OUT_ALTURA_CULTIVARES08 <- renderPlot({
    ALTURA_0808$Variedades <- as.factor(ALTURA_0808$Variedades)
    ALTURA_0808$Tratamento <- as.factor(ALTURA_0808$Tratamento)
    ALTURA_0808$Repetição <- NULL
    
    print(unique(ALTURA_0808$Tratamento))
    BRS_ANAHÍ <- data.frame(Tratamento = c("TESTEMUNHA", "VITAVAX", "TRICHOPLUS",
                                           "BACILLUS SUBTILIS", "MAXIM"), 
                            Altura = c(52,59,50,45,53), Variedades = "BRS ANAHÍ", label = c("ab", "a", "ab","b", "ab"))
    SEDA <- data.frame(Tratamento = c("TESTEMUNHA", "VITAVAX", "TRICHOPLUS",
                                      "BACILLUS SUBTILIS", "MAXIM"), 
                       Altura = c(60, 64, 59, 63, 65), Variedades = "BRS SEDA", label = c("a", "a", "a", "a", "a"))
    
    K3 <- data.frame(Tratamento = c("TESTEMUNHA", "VITAVAX", "TRICHOPLUS",
                                    "BACILLUS SUBTILIS", "MAXIM"), 
                     Altura = c(56,52,42,50,52), Variedades = "K3", label = c("a", "a", "b", "ab", "a"))
    
    ALT_0808_LETRAS <- rbind(BRS_ANAHÍ, SEDA, K3)
    
    p <- ggerrorplot(ALTURA_0808, x = "Tratamento", y = "Altura",
                     color = "Variedades", palette = "Paired",
                     error.plot = "pointrange",
                     position = position_dodge(0.5), facet.by = 
                       "Variedades", xlab = "Tratamentos", ylab = "Altura (cm)")
    
    p
    g <- p + geom_text(data = ALT_0808_LETRAS,label = ALT_0808_LETRAS$label)
 
    g <- g + scale_x_discrete("Tratamentos", limits = c("TESTEMUNHA", "BACILLUS SUBTILIS", "MAXIM", "TRICHOPLUS", "VITAVAX"),
                     labels = c("TESTEMUNHA" = "Controle", "BACILLUS SUBTILIS" = substitute(paste(italic('BACILLUS SUBTILIS'))),"MAXIM" = "MAXIM","TRICHOPLUS" = "TRICHOPLUS","VITAVAX" = "VITAVAX")) 
    g + rotate_x_text(90)
    
  })
  
  ### Comparando-se os tratamentos em cada cultivar
  
  output$OUT_ALTURA_TRATAMENTOS08 <- renderPlot({
    ALTURA_0808$Variedades <- as.factor(ALTURA_0808$Variedades)
    ALTURA_0808$Tratamento <- as.factor(ALTURA_0808$Tratamento)
    ALTURA_0808$Repetição <- NULL

    
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
    
    g <- ggerrorplot(ALTURA_0808, x = "Variedades", y = "Altura",
                     color = "Tratamento", palette = "Paired",
                     error.plot = "pointrange",
                     position = position_dodge(0.5), facet.by = 
                       "Tratamento", xlab = "Cultivares", ylab = "Altura (cm)")
    
    g <- g + geom_text(data = ALT_0808_LETRAS_CULTIVARES,label = ALT_0808_LETRAS_CULTIVARES$label)
    g <- g + rotate_x_text(90)
    g
    
  })
  ############ 16/08
  
  
  output$OUT_ALTURA_CULTIVARES16 <- renderPlot({
    ALTURA_1608$Variedades <- as.factor(ALTURA_1608$Variedades)
    ALTURA_1608$Tratamento <- as.factor(ALTURA_1608$Tratamento)
    ALTURA_1608$Repetição <- NULL
    

    BRS_ANAHÍ <- data.frame(Tratamento = c("TESTEMUNHA", "VITAVAX", "TRICHOPLUS",
                                           "BACILLUS SUBTILIS", "MAXIM"), 
                            Altura = c(55,60,52,43,53), Variedades = "BRS ANAHÍ", label = c("ab", "a", "ab", "b", "ab"))
    SEDA <- data.frame(Tratamento = c("TESTEMUNHA", "VITAVAX", "TRICHOPLUS",
                                      "BACILLUS SUBTILIS", "MAXIM"), 
                       Altura = c(61,66,57,72,70), Variedades = "BRS SEDA", label = c("ab", "ab", "b", "a", "ab"))
    
    K3 <- data.frame(Tratamento = c("TESTEMUNHA", "VITAVAX", "TRICHOPLUS",
                                    "BACILLUS SUBTILIS", "MAXIM"), 
                     Altura = c(57,53,43,52,53), Variedades = "K3", label = c("a", "a", "b", "ab", "a"))
    
    ALT_1608_LETRAS <- rbind(BRS_ANAHÍ, SEDA, K3)
    
    p <- ggerrorplot(ALTURA_1608, x = "Tratamento", y = "Altura",
                     color = "Variedades", palette = "Paired",
                     error.plot = "pointrange",
                     position = position_dodge(0.5), facet.by = 
                       "Variedades", xlab = "Tratamentos", ylab = "Altura (cm)")
    
    p
    g <- p + geom_text(data = ALT_1608_LETRAS,label = ALT_1608_LETRAS$label)
    
    g <- g + scale_x_discrete("Tratamentos", limits = c("TESTEMUNHA", "BACILLUS SUBTILIS", "MAXIM", "TRICHOPLUS", "VITAVAX"),
                              labels = c("TESTEMUNHA" = "Controle", "BACILLUS SUBTILIS" = substitute(paste(italic('BACILLUS SUBTILIS'))),"MAXIM" = "MAXIM","TRICHOPLUS" = "TRICHOPLUS","VITAVAX" = "VITAVAX")) 
    g + rotate_x_text(90)
    
  })
  
  ### Comparando-se os tratamentos em cada cultivar
  
  output$OUT_ALTURA_TRATAMENTOS16 <- renderPlot({
    ALTURA_1608$Variedades <- as.factor(ALTURA_1608$Variedades)
    ALTURA_1608$Tratamento <- as.factor(ALTURA_1608$Tratamento)
    ALTURA_1608$Repetição <- NULL
    
    
    TESTEMUNHA <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "TESTEMUNHA",
                             Altura = c(55,61,57), label = c("A", "A", "A"))
    
    BACILLUS <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "BACILLUS SUBTILIS",
                           Altura = c(43,73,52), label = c("B", "A", "B"))
    
    MAXIM <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "MAXIM",
                        Altura = c(53,70,53), label = c("B", "A", "B"))
    
    VITAVAX <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "VITAVAX",
                          Altura = c(60,65,53), label = c("AB", "A", "B"))
    
    TRICHOPLUS <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "TRICHOPLUS",
                             Altura = c(52,57,43), label = c("AB", "A", "B"))
    
    ALT_1608_LETRAS_CULTIVARES <- rbind(TESTEMUNHA, BACILLUS, MAXIM, VITAVAX, TRICHOPLUS)
    
    g <- ggerrorplot(ALTURA_1608, x = "Variedades", y = "Altura",
                     color = "Tratamento", palette = "Paired",
                     error.plot = "pointrange", 
                     position = position_dodge(0.5), facet.by = 
                       "Tratamento", xlab = "Cultivares", ylab = "Altura (cm)")
    
    g <- g + geom_text(data = ALT_1608_LETRAS_CULTIVARES,label = ALT_1608_LETRAS_CULTIVARES$label)
    g <- g + rotate_x_text(90)
    g
    
  })
  
  
  output$msgOut <- renderMenu({

  })
  
})
