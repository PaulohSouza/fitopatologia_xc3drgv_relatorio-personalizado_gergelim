library(shiny)
library(shinydashboard)

ALTURA_0808 <- read_xlsx("08_08_conferencia.xlsx")
ALTURA_1608 <- read_xlsx("16_08.xlsx")

shinyUI(
  dashboardPage(skin = "green",
    dashboardHeader(title="Relatório SEBRA",dropdownMenuOutput("msgOut")
     
    ),
    dashboardSidebar(
      
      sidebarMenu(
        menuItem("Altura de plantas",tabName = "dashboard"),
        menuSubItem("Data: 08/08",tabName = "DevOps"),
        menuSubItem("Data: 16/08",tabName = "Blockchain"),
        menuItem("Vagens",tabName = "MENU_VAGENS"),
        menuSubItem("Número de vagens",tabName = "TAB_VAGENS"),
        menuItem("Massa de Plantas",tabName = "MENU_VAGENS"),
        menuSubItem("Massa fresca de plantas",tabName = "Revenue"),
        menuSubItem("Massa seca de plantas",tabName = "Expenditure"))
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
        tabItem(tabName = "TAB_VAGENS",h1("Vagens")),
        tabItem(tabName = "Revenue", h1("A inserir")),
        tabItem(tabName = "Expenditure",h1("A inserir"))
      )
    )
  )
)