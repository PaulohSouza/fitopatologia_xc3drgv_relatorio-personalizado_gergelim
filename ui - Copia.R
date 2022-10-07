library(shiny)
library(shinydashboard)


shinyUI(
  dashboardPage(skin = "green",
    dashboardHeader(title="Relatório SEBRA",dropdownMenuOutput("msgOut")
     
    ),
    dashboardSidebar(
      
      sidebarMenu(
        menuItem("Altura de plantas",tabName = "dashboard"),
        menuSubItem("Data: 08/08",tabName = "DevOps"),
        menuSubItem("Data: 16/08",tabName = "Blockchain"),
        menuSubItem("AWS",tabName = "AWS"),
        menuItem("Finance Dashboard",tabName = "Finance"),
        menuSubItem("Revenue Generated",tabName = "Revenue"),
        menuSubItem("Company Expenditure",tabName = "Expenditure"))
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
        tabItem(tabName = "AWS",h1("AWS Courses sold")),
        tabItem(tabName = "Finance",h1("Financial Growth")),
        tabItem(tabName = "Revenue", h1("Revenue Generated")),
        tabItem(tabName = "Expenditure",h1("Company Expenditures"))
      )
    )
  )
)