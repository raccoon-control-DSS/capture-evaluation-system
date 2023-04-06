#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/

# library
library(shiny)
library(ggplot2)
library(ggsci)

shinyServer(function(input, output) {
  
  #CPUEの算出
  CPUE <- reactive({
    return(input$capture / input$effort * 100)})
  
  #齢別の個体数割合
  y1 <- reactive({
    return(1-input$y2)})
  y2 <- reactive({
    return(input$y2)})
  
  #推定個体数(初期生息数)
  POPU <- reactive({
    return(input$area * {(CPUE() + 0.6924) / 1.6045})})
  
  #推定個体数-捕獲数（捕獲後生息数）
  POP2 <- reactive({
    return(POPU() - input$capture)})

  #繁殖数・生存率
  f1 <- reactive({
    return(input$P1*input$Y1*input$f)}) #１歳繁殖数
  f2 <- reactive({
    return(input$P2*input$Y2*input$f)}) #２歳以上繁殖数
  p0 <- reactive({
    return((1-input$Mi)*(1-input$Mj))}) #<１歳生存率
  p1 <- reactive({
    return(1-input$Mj)}) #１歳生存率
  p2 <- reactive({
    return(1-input$M2)}) #>２歳生存率
  
  #捕獲なしの場合
  #N0
  N1y0 <- reactive({return(POPU() * y1())})
  N2y0 <- reactive({return(POPU() * y2())})
  N0 <- reactive({return(POPU())})
  #N1
  N1y1 <- reactive({return(p0()*(f1()*N1y0() + f2()*N2y0()))})
  N2y1 <- reactive({return(p1()*N1y0() + p2()*N2y0())})
  N1 <- reactive({return(N1y1() + N2y1())})
  #N2
  N1y2 <- reactive({return(p0()*(f1()*N1y1() + f2()*N2y1()))})
  N2y2 <- reactive({return(p1()*N1y1() + p2()*N2y1())})
  N2 <- reactive({return(N1y2() + N2y2())})
  #N3
  N1y3 <- reactive({return(p0()*(f1()*N1y2() + f2()*N2y2()))})
  N2y3 <- reactive({return(p1()*N1y2() + p2()*N2y2())})
  N3 <- reactive({return(N1y3() + N2y3())})
  #N4
  N1y4 <- reactive({return(p0()*(f1()*N1y3() + f2()*N2y3()))})
  N2y4 <- reactive({return(p1()*N1y3() + p2()*N2y3())})
  N4 <- reactive({return(N1y4() + N2y4())})
  #N5
  N1y5 <- reactive({return(p0()*(f1()*N1y4() + f2()*N2y4()))})
  N2y5 <- reactive({return(p1()*N1y4() + p2()*N2y4())})
  N5 <- reactive({return(N1y5() + N2y5())})
  #N6
  N1y6 <- reactive({return(p0()*(f1()*N1y5() + f2()*N2y5()))})
  N2y6 <- reactive({return(p1()*N1y5() + p2()*N2y5())})
  N6 <- reactive({return(N1y6() + N2y6())})
  #N7
  N1y7 <- reactive({return(p0()*(f1()*N1y6() + f2()*N2y6()))})
  N2y7 <- reactive({return(p1()*N1y6() + p2()*N2y6())})
  N7 <-reactive({return( N1y7() + N2y7())})
  #N8
  N1y8 <- reactive({return(p0()*(f1()*N1y7() + f2()*N2y7()))})
  N2y8 <- reactive({return(p1()*N1y7() + p2()*N2y7())})
  N8 <- reactive({return(N1y8() + N2y8())})
  #N9
  N1y9 <- reactive({return(p0()*(f1()*N1y8() + f2()*N2y8()))})
  N2y9 <- reactive({return(p1()*N1y8() + p2()*N2y8())})
  N9 <- reactive({return(N1y9() + N2y9())})
  #N10
  N1y10 <- reactive({return(p0()*(f1()*N1y9() + f2()*N2y9()))})
  N2y10 <- reactive({return(p1()*N1y9() + p2()*N2y9())})
  N10 <- reactive({return(N1y10() + N2y10())})
  #N11
  N1y11 <- reactive({return(p0()*(f1()*N1y10() + f2()*N2y10()))})
  N2y11 <- reactive({return(p1()*N1y10() + p2()*N2y10())})
  N11 <- reactive({return(N1y11() + N2y11())})
  #N12
  N1y12 <- reactive({return(p0()*(f1()*N1y11() + f2()*N2y11()))})
  N2y12 <- reactive({return(p1()*N1y11() + p2()*N2y11())})
  N12 <- reactive({return(N1y12() + N2y12())})
  
  #捕獲ありの場合
  #N0
  nN1y0 <- reactive({return(POP2() * y1())})
  nN2y0 <- reactive({return(POP2() * y2())})
  nN0 <- reactive({return(POP2())})
  #nN1
  nN1y1 <- reactive({return(p0()*(f1()*nN1y0() + f2()*nN2y0()))})
  nN2y1 <- reactive({return(p1()*nN1y0() + p2()*nN2y0())})
  nN1 <- reactive({return(nN1y1() + nN2y1())})
  #nN2
  nN1y2 <- reactive({return(p0()*(f1()*nN1y1() + f2()*nN2y1()))})
  nN2y2 <- reactive({return(p1()*nN1y1() + p2()*nN2y1())})
  nN2 <- reactive({return(nN1y2() + nN2y2())})
  #nN3
  nN1y3 <- reactive({return(p0()*(f1()*nN1y2() + f2()*nN2y2()))})
  nN2y3 <- reactive({return(p1()*nN1y2() + p2()*nN2y2())})
  nN3 <- reactive({return(nN1y3() + nN2y3())})
  #nN4
  nN1y4 <- reactive({return(p0()*(f1()*nN1y3() + f2()*nN2y3()))})
  nN2y4 <- reactive({return(p1()*nN1y3() + p2()*nN2y3())})
  nN4 <- reactive({return(nN1y4() + nN2y4())})
  #nN5
  nN1y5 <- reactive({return(p0()*(f1()*nN1y4() + f2()*nN2y4()))})
  nN2y5 <- reactive({return(p1()*nN1y4() + p2()*nN2y4())})
  nN5 <- reactive({return(nN1y5() + nN2y5())})
  #nN6
  nN1y6 <- reactive({return(p0()*(f1()*nN1y5() + f2()*nN2y5()))})
  nN2y6 <- reactive({return(p1()*nN1y5() + p2()*nN2y5())})
  nN6 <- reactive({return(nN1y6() + nN2y6())})
  #nN7
  nN1y7 <- reactive({return(p0()*(f1()*nN1y6() + f2()*nN2y6()))})
  nN2y7 <- reactive({return(p1()*nN1y6() + p2()*nN2y6())})
  nN7 <- reactive({return(nN1y7() + nN2y7())})
  #nN8
  nN1y8 <- reactive({return(p0()*(f1()*nN1y7() + f2()*nN2y7()))})
  nN2y8 <- reactive({return(p1()*nN1y7() + p2()*nN2y7())})
  nN8 <- reactive({return(nN1y8() + nN2y8())})
  #nN9
  nN1y9 <- reactive({return(p0()*(f1()*nN1y8() + f2()*nN2y8()))})
  nN2y9 <- reactive({return(p1()*nN1y8() + p2()*nN2y8())})
  nN9 <- reactive({return(nN1y9() + nN2y9())})
  #nN10
  nN1y10 <- reactive({return(p0()*(f1()*nN1y9() + f2()*nN2y9()))})
  nN2y10 <- reactive({return(p1()*nN1y9() + p2()*nN2y9())})
  nN10 <- reactive({return(nN1y10() + nN2y10())})
  #nN11
  nN1y11 <- reactive({return(p0()*(f1()*nN1y10() + f2()*nN2y10()))})
  nN2y11 <- reactive({return(p1()*nN1y10() + p2()*nN2y10())})
  nN11 <- reactive({return(nN1y11() + nN2y11())})
  #nN12
  nN1y12 <- reactive({return(p0()*(f1()*nN1y11() + f2()*nN2y11()))})
  nN2y12 <- reactive({return(p1()*nN1y11() + p2()*nN2y11())})
  nN12 <- reactive({return(nN1y12() + nN2y12())})
  
  #データフレーム化
  dat <- reactive(
    {return(data.frame(year = c(0,1,2,3,4,5,6,7,8,9,10),
                       N1 = c(N0(), N1(), N2(), N3() , N4() , N5() , N6(),
                              N7(), N8(), N9(), N10()),
                       N2 = c(nN0(), nN1(), nN2(), nN3() , nN4() , nN5() , nN6(), 
                              nN7(), nN8(), nN9(), nN10())))})
  
  #output_text
  output$text <- renderText({
    paste("【計算結果】",
          '\n',
          "地域CPUE値:", format(round(CPUE(), 2), nsmall = 2),
          '\n',
          "対象地域の推定生息頭数:", format(round(POPU(), 2), nsmall = 2),"頭",
          '\n',
          "対象地域の捕獲後の推定残存頭数:", format(round(POP2(), 2), nsmall = 2),"頭",
          '\n',
          "捕獲なしの10年後推定生息頭数:", format(round(N10(), 2), nsmall = 2),"頭",
          '\n',
          "捕獲ありの10年後推定生息頭数:", format(round(nN10(), 2), nsmall = 2),"頭"
          )
  })

  
  #output_graph
  output$plot <- renderPlot({
    g <- ggplot(dat(), aes(year))
    g <- g + geom_line(aes(y = N1, colour = "捕獲なし")) 
    g <- g + geom_line(aes(y = N2, colour = "捕獲あり")) 
    g <- g + scale_x_continuous(breaks =seq(0, 12, 1) ,expand = c(0,NA))
    g <- g + scale_y_continuous(labels = label_number(scale = 1/1000, suffix = 'k'),
                                expand = c(0,NA), limits = c(0, NA)) 
    g <- g + labs(title = "捕獲有無別の個体数変化予測",
                  x = "経過年数", y ="推定個体数（千頭）",
                  colour = "捕獲の有無")
    plot(g)
    })
})