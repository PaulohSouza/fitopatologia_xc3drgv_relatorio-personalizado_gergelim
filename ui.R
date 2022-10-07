library(shiny)
library(shinydashboard)
library(rsconnect)
library(readxl)

shinyUI(
  dashboardPage(skin = "green",
    dashboardHeader(title="Relatório SEBRA",dropdownMenuOutput("msgOut")
     
    ),
    dashboardSidebar(
      
      sidebarMenu(
        menuItem("FITOPATOLOGIA - FMT",tabName = "REL"),
        menuItem("Altura de plantas",tabName = "dashboard"),
        menuSubItem("Data: 08/08",tabName = "DevOps"),
        menuSubItem("Data: 16/08",tabName = "Blockchain"),
        menuItem("Vagens",tabName = "MENU_VAGENS"),
        menuSubItem("Número de cápsulas",tabName = "MENUSUB_CAPSULAS"),
        menuItem("Massa de parte aérea",tabName = "MENU_PARTE AEREA"),
        menuSubItem("Massa fresca - Parte aérea",tabName = "MENUSUB_MASSAFRESCA_AEREA")
       # menuSubItem("Massa seca - Parte aérea",tabName = "MENUSUB_MASSAFRESCA_AEREA"))
      )
    ),
    dashboardBody(
      tabItems(

        tabItem(tabName = "DevOps",h5("Altura de plantas (cm) - Comparativo de tratamentos para cada cultivar"),
                                      fluidRow(
                                        box(plotOutput("OUT_ALTURA_CULTIVARES08"), width = "100%"),
                                      h6("*letras diferentes nas linhas para cada cultivar, diferem pelo teste Tukey p < 0.05)"),
                                      h6("**Ordem de visualização por ordem alfabética dos tratamentos (Exceto Controle)"
                                      )),
                                   h5("Altura de plantas (cm) - Comparativo de cultivares em relação a cada Tratamento"),
                                        fluidRow(
                                        box(plotOutput("OUT_ALTURA_TRATAMENTOS08"), width = "100%"),
                                        h6("*letras diferentes nas linhas para cada cultivar, diferem pelo teste Tukey p < 0.05)"),
                                        h6("*Ordem de visualização por ordem alfabética das cultivares"))
        ),
        tabItem(tabName = "Blockchain",h5("Altura de plantas (cm) - Comparativo de tratamentos para cada cultivar"),
                fluidRow(
                  box(plotOutput("OUT_ALTURA_CULTIVARES16"), width = "100%"),
                  h6("*letras diferentes nas linhas para cada cultivar, diferem pelo teste Tukey p < 0.05)"),
                  h6("**Ordem de visualização por ordem alfabética dos tratamentos (Exceto Controle)"
                  )),
                h5("Altura de plantas (cm) - Comparativo de cultivares em relação a cada Tratamento"),
                fluidRow(
                  box(plotOutput("OUT_ALTURA_TRATAMENTOS16"), width = "100%"),
                  h6("*letras diferentes nas linhas para cada cultivar, diferem pelo teste Tukey p < 0.05)"),
                  h6("*Ordem de visualização por ordem alfabética das cultivares"))
        ),
        tabItem(tabName = "MENUSUB_CAPSULAS",h5("Média do número de cápsulas por planta [Comparativo tratamentos entre as cultivares]"),
                fluidRow(
                  box(plotOutput("OUT_CAPSULAS_CULTIVARES"), width = "100%"),
                  h6("*letras diferentes nas linhas para cada cultivar, diferem pelo teste Tukey p < 0.05)"),
                  h6("**Ordem de visualização por ordem alfabética dos tratamentos (Exceto Controle)"
                  )),
                h5("Média do número de cápsulas por planta [Comparativo de cultivares em cada tratamento]"),
                fluidRow(
                  box(plotOutput("OUT_CAPSULAS_TRATAMENTOS"), width = "100%"),
                  h6("*letras diferentes nas linhas para cada cultivar, diferem pelo teste Tukey p < 0.05)"),
                  h6("*Ordem de visualização por ordem alfabética das cultivares"))),
        tabItem(tabName = "MENUSUB_MASSAFRESCA_AEREA",  fluidRow(
                          box(plotOutput("OUT_MFPA_CULTIVARES"), width = "100%"),
                              h6("*letras diferentes nas linhas para cada cultivar, diferem pelo teste Tukey p < 0.05)"),
                             h6("**Ordem de visualização por ordem alfabética dos tratamentos (Exceto Controle)"
                             )),
                               h5("Massa fresca de parte aérea [Comparativo de cultivares em cada tratamento]"),
                          fluidRow(
                            box(plotOutput("OUT_MFPA_TRATAMENTOS"), width = "100%"),
                            h6("*letras diferentes nas linhas para cada cultivar, diferem pelo teste Tukey p < 0.05)"),
                            h6("*Ordem de visualização por ordem alfabética das cultivares"))),
        tabItem(tabName = "MENUSUB_MASSASECA_AEREA",h1("A inserir"),
                fluidRow(
                  box(plotOutput("OUT_MSPA_CULTIVARES"), width = "100%"),
                  h6("*letras diferentes nas linhas para cada cultivar, diferem pelo teste Tukey p < 0.05)"),
                  h6("**Ordem de visualização por ordem alfabética dos tratamentos (Exceto Controle)"
                  )),
                h5("Massa fresca de parte aérea [Comparativo de cultivares em cada tratamento]"),
                fluidRow(
                  box(plotOutput("OUT_MSPA_TRATAMENTOS"), width = "100%"),
                  h6("*letras diferentes nas linhas para cada cultivar, diferem pelo teste Tukey p < 0.05)"),
                  h6("*Ordem de visualização por ordem alfabética das cultivares")))
      )
    )
  )
)