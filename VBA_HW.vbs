Attribute VB_Name = "Module1"
Sub hard_stock()
For Each ws In Worksheets

'find last row and flast columns
      LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
      LastColumn = ws.Cells(1, Columns.Count).End(xlToLeft).Column
      
'assign headers to columns
      ws.Cells(1, LastColumn + 1).Value = "Ticker"
      ws.Cells(1, LastColumn + 2).Value = "Yearly Change"
      ws.Cells(1, LastColumn + 3).Value = "Percentage Change"
      ws.Cells(1, LastColumn + 4).Value = "Total Stock Volume"
      ws.Cells(1, LastColumn + 8).Value = "Ticker"
      ws.Cells(1, LastColumn + 9).Value = "Value"
      ws.Cells(2, LastColumn + 7).Value = "Greatest % Increase"
      ws.Cells(3, LastColumn + 7).Value = "Greatest % Decrease"
      ws.Cells(4, LastColumn + 7).Value = "Greatest Total Volume"
      
'declare variables
    Dim ticker As String
    Dim Total As Double
    Dim Summary As Integer
    Dim ychange As Double
    Dim pchange As Double
    Dim offset As Double
    Dim Max_total_volume As Double
    Dim greatest_percent_increase As Double
    Dim greatest_percent_decrease As Double
    Dim greatest_increase As Double
    Dim greatest_decrease As Double
    
'set variable value
    offset = 2
    Total = 0
    Summary = 2
    
'find unique ticker values and calculate yearly change and percentage change and total volume and assign color according to positive and negative yearly change
  For i = 2 To LastRow
    If ws.Cells(i, 1).Value <> ws.Cells(i + 1, 1).Value Then
      ticker = ws.Cells(i, 1).Value
     Total = Total + ws.Cells(i, LastColumn).Value
     ychange = ws.Cells(i, 6).Value - ws.Cells(offset, 3).Value
    If ws.Cells(offset, 3).Value = 0 Then
    pchange = 0
    Else
     pchange = ((ws.Cells(i, 6).Value - ws.Cells(offset, 3).Value) / ws.Cells(offset, 3).Value) * 100
     End If
      ws.Cells(Summary, LastColumn + 1).Value = ticker
      ws.Cells(Summary, LastColumn + 2).Value = ychange
      ws.Cells(Summary, LastColumn + 3).Value = (pchange & "%")
      ws.Cells(Summary, LastColumn + 4).Value = Total
      If ychange > 0 Then
      ws.Cells(Summary, LastColumn + 2).Interior.ColorIndex = 10
      Else
        ws.Cells(Summary, LastColumn + 2).Interior.ColorIndex = 3
        End If
    Summary = Summary + 1
    Total = 0
    offset = offset + (i - offset) + 1
    Else
    Total = Total + ws.Cells(i, LastColumn).Value
    End If
  Next i
  
  'find greatest percent increase, find the matching row for the greatest increase and get the ticker value for the respective value
  greatest_percent_increase = WorksheetFunction.Max(ws.Range("J2:J" & LastRow))
  match_row_greatest_percent_increase = WorksheetFunction.Match(greatest_percent_increase, ws.Range("J2:J" & LastRow), 0)
  greatest_increase = greatest_percent_increase * 100
  ws.Cells(2, LastColumn + 9).Value = (greatest_increase & "%")
  ws.Cells(2, LastColumn + 8).Value = ws.Cells(match_row_greatest_percent_increase + 1, 8).Value
  
  'find greatest percent decrease, find the matching row for the greatest decrease and get the ticker value for the respective value
  greatest_percent_decrease = WorksheetFunction.Min(ws.Range("J2:J" & LastRow))
  match_row_greatest_percent_decrease = WorksheetFunction.Match(greatest_percent_decrease, ws.Range("J2:J" & LastRow), 0)
  greatest_decrease = greatest_percent_decrease * 100
  ws.Cells(3, LastColumn + 9).Value = (greatest_decrease & "%")
  ws.Cells(3, LastColumn + 8).Value = ws.Cells(match_row_greatest_percent_decrease + 1, 8).Value
  
'find maximum total volume, find the matching row for the maximum total volume and get the ticker value for the respective value
  Max_total_volume = WorksheetFunction.Max(ws.Range("K2:K" & LastRow))
  match_row_greatest_total_volume = WorksheetFunction.Match(Max_total_volume, ws.Range("K2:K" & LastRow), 0)
  ws.Cells(4, LastColumn + 9).Value = Max_total_volume
  ws.Cells(4, LastColumn + 8).Value = ws.Cells(match_row_greatest_total_volume + 1, 8).Value
  
'autofit columns
  ws.Columns("A:Q").AutoFit
  
    Next ws
End Sub




