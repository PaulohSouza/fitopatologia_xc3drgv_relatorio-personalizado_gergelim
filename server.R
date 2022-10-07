
library(shiny)
library(shinydashboard)
library(AgroR)
library(ggpubr)
library(readxl)

ALTURA_0808 <- read_xlsx("08_08_conferencia.xlsx")
ALTURA_1608 <- read_xlsx("16_08.xlsx")
CAPSULAS <- read_xlsx("N_vagens.xlsx")
MFPA <- read_xlsx("Massa_Fresca_parte aerea.xlsx")

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
  ######################################
  ################## Capsulas  #########
  ######################################
  
  
  output$OUT_CAPSULAS_CULTIVARES <- renderPlot({
    CAPSULAS$Variedades <- as.factor(CAPSULAS$Variedades)
    CAPSULAS$Tratamento <- as.factor(CAPSULAS$Tratamento)
    CAPSULAS$Repetição <- NULL
    
    
    BRS_ANAHÍ <- data.frame(Tratamento = c("TESTEMUNHA", "VITAVAX", "TRICHOPLUS",
                                           "BACILLUS SUBTILIS", "MAXIM"), 
                       Vagens = c(13,11,10,10,14), Variedades = "BRS ANAHÍ", label = c("ab", "ab", "b", "b", "a"))
    SEDA <- data.frame(Tratamento = c("TESTEMUNHA", "VITAVAX", "TRICHOPLUS",
                                      "BACILLUS SUBTILIS", "MAXIM"), 
                       Vagens = c(12,10,10,11,11), Variedades = "BRS SEDA", label = c("a", "b", "ab", "ab", "ab"))
    
    K3 <- data.frame(Tratamento = c("TESTEMUNHA", "VITAVAX", "TRICHOPLUS",
                                    "BACILLUS SUBTILIS", "MAXIM"), 
                     Vagens = c(18,15,11,14,15), Variedades = "K3", label = c("a","a", "b", "ab", "ab"))
    
    CAPSULAS_LETRAS <- rbind(BRS_ANAHÍ, SEDA, K3)
    
    p <- ggerrorplot(CAPSULAS, x = "Tratamento", y = "Vagens",
                     color = "Variedades", palette = "Paired",
                     error.plot = "pointrange",
                     position = position_dodge(0.5), facet.by = 
                       "Variedades", xlab = "Tratamentos", ylab = "Número de cápsulas")
    
    p
    g <- p + geom_text(data = CAPSULAS_LETRAS,label = CAPSULAS_LETRAS$label)
    
    g <- g + scale_x_discrete("Tratamentos", limits = c("TESTEMUNHA", "BACILLUS SUBTILIS", "MAXIM", "TRICHOPLUS", "VITAVAX"),
                              labels = c("TESTEMUNHA" = "Controle", "BACILLUS SUBTILIS" = substitute(paste(italic('BACILLUS SUBTILIS'))),"MAXIM" = "MAXIM","TRICHOPLUS" = "TRICHOPLUS","VITAVAX" = "VITAVAX")) 
    g + rotate_x_text(90)
    
    
  })
  
  
  
  output$OUT_CAPSULAS_TRATAMENTOS <-  renderPlot({
    CAPSULAS$Variedades <- as.factor(CAPSULAS$Variedades)
    CAPSULAS$Tratamento <- as.factor(CAPSULAS$Tratamento)
    CAPSULAS$Repetição <- NULL
    
    
    TESTEMUNHA <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "TESTEMUNHA",
                             Vagens = c(13,13,17), label = c("B", "A", "A"))
    
    BACILLUS <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "BACILLUS SUBTILIS",
                           Vagens = c(10,13,14), label = c("B", "AB", "A"))
    
    MAXIM <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "MAXIM",
                        Vagens = c(14,12,15), label = c("A", "A", "A"))
    
    VITAVAX <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "VITAVAX",
                          Vagens = c(12,10,15), label = c("B", "B", "A"))
    
    TRICHOPLUS <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"), Tratamento = "TRICHOPLUS",
                             Vagens = c(10,11,11), label = c("A", "A", "A"))
    
    CAPSULAS_LETRAS <- rbind(TESTEMUNHA, BACILLUS, MAXIM, VITAVAX, TRICHOPLUS)
    
    g <- ggerrorplot(CAPSULAS, x = "Variedades", y = "Vagens",
                     color = "Tratamento", palette = "Paired",
                     error.plot = "pointrange", 
                     position = position_dodge(0.5), facet.by = 
                       "Tratamento", xlab = "Cultivares", ylab = "Número de cápsulas")
    
    g <- g + geom_text(data = CAPSULAS_LETRAS,label = CAPSULAS_LETRAS$label)
    g <- g + rotate_x_text(90)
    g
  
  })
  
  #############################################
  ################# PARTE AEREA ###############
  #############################################
  
  output$OUT_MFPA_CULTIVARES <- renderPlot({
    MFPA$Variedades <- as.factor(MFPA$Variedades)
    MFPA$Tratamento <- as.factor(MFPA$Tratamento)
    MFPA$Repetição <- NULL
    
  
    MFPA_CULTIVARES <- data.frame(Variedades = c("BRS ANAHÍ", "BRS SEDA","K3"),
                                  Massa_fresca_planta = c(25,25,23), label = c("a", "a", "b"))
    
  #  ggerrorplot(MFPA, x = "Variedades", y = "Massa_fresca_planta",
  #              palette = "Paired",
  #              desc_stat = "mean_ci", ci = 0.95, color = "black",
  #              add = "jitter", add.params = list(color = "darkgray"),
   #             position = position_dodge(0.5))
    
    p <- ggboxplot(MFPA, x = "Variedades", y = "Massa_fresca_planta",
                   color = "Variedades", palette =c("#00AFBB", "#E7B800", "#FC4E07"),
                   add = "jitter", shape = "Variedades", xlab = "Cultivares",
                   ylab = "Massa fresca de parte aérea (g)")
    p <- p + geom_text(data = MFPA_CULTIVARES,label = MFPA_CULTIVARES$label, nudge_x = 0.2, size = 6)
    
    p
   # g <- p + geom_text(data = CAPSULAS_LETRAS,label = CAPSULAS_LETRAS$label)
    
    #p + rotate_x_text(90)
    
    
  })
  
  output$OUT_MFPA_TRATAMENTOS <- renderPlot({
    MFPA$Variedades <- as.factor(MFPA$Variedades)
    MFPA$Tratamento <- as.factor(MFPA$Tratamento)
    MFPA$Repetição <- NULL
 
    
    MFPA_CULTIVARES <- data.frame(Tratamento = c("TESTEMUNHA", "VITAVAX", "TRICHOPLUS",
                                                 "BACILLUS SUBTILIS", "MAXIM"),
                                  Massa_fresca_planta = c(29,27,23,27,32), label = c("a", "ab", "b", "ab", "a"))
    MFPA_CULTIVARES
    #  ggerrorplot(MFPA, x = "Variedades", y = "Massa_fresca_planta",
    #              palette = "Paired",
    #              desc_stat = "mean_ci", ci = 0.95, color = "black",
    #              add = "jitter", add.params = list(color = "darkgray"),
    #             position = position_dodge(0.5))
    
    p <- ggboxplot(MFPA, x = "Tratamento", y = "Massa_fresca_planta",
                   color = "Tratamento",
                   add = "jitter", shape = "Tratamento", xlab = "Tratamentos",
                   ylab = "Massa fresca de parte aérea (g)")
    p
    p <- p + geom_text(data = MFPA_CULTIVARES,label = MFPA_CULTIVARES$label, nudge_x = 0.2, size = 6)
    
    p <- p + scale_x_discrete("Tratamentos", limits = c("TESTEMUNHA", "BACILLUS SUBTILIS", "MAXIM", "TRICHOPLUS", "VITAVAX"),
                              labels = c("TESTEMUNHA" = "Controle", "BACILLUS SUBTILIS" = substitute(paste(italic('BACILLUS SUBTILIS'))),"MAXIM" = "MAXIM","TRICHOPLUS" = "TRICHOPLUS","VITAVAX" = "VITAVAX")) 
    
    p
    # g <- p + geom_text(data = CAPSULAS_LETRAS,label = CAPSULAS_LETRAS$label)
    
    #p + rotate_x_text(90)
    
    
  })
  
  output$msgOut <- renderMenu({

  })
  
})
