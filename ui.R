#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# library
library(shiny)
library(ggplot2)
library(ggsci)


# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("アライグマ防除事業の評価"),
  
  # Inputbox
  sidebarLayout(
    sidebarPanel(
      fluidRow(
        
          h4("【対象地域の捕獲実績】"),
        numericInput("effort",
                     label = "わな日（対象地域に設置したわな基数 × 設置日数）",
                     min = 0, value = 10000),
        helpText("※わな日が正確に把握されていない場合、
                       このシステムでは必要な予算を正しく計算することができません"),
        numericInput("capture",
                     label = "対象地域で捕獲されたアライグマ頭数（頭）",
                     min = 0, value = 452),
        numericInput("area",
                     label = "対象地域の面積（km2）",
                     min = 0, value = 747.6),
        
        br(),
        
        h4("【仮定したパラメータ値】"),
        helpText("先行文献を参考に初期パラメータ値を設定（Gehrt & Fritzell, 1999; Asano et al., 2003; 兵庫県森林動物研究センター, 2009"),
        numericInput("y2",
                     label = "初期の２歳以上生息数割合",
                     min = 0, max = 1, value = 0.6),
        numericInput("f",
                     label = "初期のメス生息数割合",
                     min = 0, max = 1, value = 0.5),
        numericInput("P2",
                     label = "2歳以上メスの妊娠率",
                     min = 0, max = 1, value = 0.95),
        numericInput("P1",
                     label = "1歳メスの妊娠率",
                     min = 0, max = 1, value = 0.66),
        numericInput("Y2",
                     label = "2歳以上メスの産仔数",
                     min = 0, value = 3.9),
        numericInput("Y1",
                     label = "1歳メスの産仔数",
                     min = 0, value = 3.6),
        numericInput("M2",
                     label = "2歳以上の自然死亡率",
                     min = 0, value = 0.15),
        numericInput("Mj",
                     label = "巣立ち前の個体の自然死亡率",
                     min = 0, max = 1, value = 0.35),
        numericInput("Mi",
                     label = "巣立ち～１歳の個体の自然死亡率",
                     min = 0, max = 1, value = 0.3)
        )),
    
    #outputpanel
    mainPanel(
      verbatimTextOutput("text"),
      plotOutput("plot")
    ),
    position = "left", fluid =TRUE)
    ))
