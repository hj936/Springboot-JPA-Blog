<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<%@ include file="layout/header.jsp"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }
    function setUpbitData(){
      $.ajax({
        url: "https://api.upbit.com/v1/market/all",
        dataType: "json"
      }).done(function(markets){
        //$("#tmp").html( JSON.stringify(markets) );
        let arr_krw_markets = "";
        let arr_korean_name = [];
        for(var i = 0; i < markets.length;i++){
          if( markets[i].market.indexOf("KRW") > -1 ){
            arr_krw_markets += markets[i].market+(",");
            arr_korean_name.push(markets[i].korean_name.replace("코인",""));
          }
        }
        arr_krw_markets = arr_krw_markets.substring(0, arr_krw_markets.length-1);
        //$("#tmp").html( arr_krw_markets );
        $.ajax({
          url: "https://api.upbit.com/v1/ticker?markets=" +arr_krw_markets,
          dataType: "json"
        }).done(function(tickers){
          $("#table_ticker > tbody > tr").remove();
          //alert($("#table_ticker > tbody > tr").length);
          //$("#table_ticker").fadeOut("slow");
          for(let i = 0;i < tickers.length;i++){
            let rowHtml = "<tr><td>"+arr_korean_name[i]+"</td>";
            rowHtml += "<td>" + arr_korean_name[i] +"</td>"
            rowHtml += "<td>" + comma(tickers[i].trade_price)+"</td>"
            rowHtml += "<td>" + comma((tickers[i].signed_change_rate*100).toFixed(2))+"</td>"
            rowHtml += "<td>" + comma((tickers[i].acc_trade_price_24h>1000000 ? ( tickers[i].acc_trade_price_24h / 1000000 ) : tickers[i].acc_trade_price_24h ).toFixed(0)) + (tickers[i].acc_trade_price_24h>1000000 ? "백만" : "") + "</td>"
            rowHtml += "</tr>";
            $("#table_ticker > tbody:last").append(rowHtml);
            //markets[i].korean_name
          } // end for...
          //$("#table_ticker").fadeIn("slow");
        })  //done(function(tickers){
      }) // end done(function(markets){
      .fail(function(){
        //alert("업비트 API 접근 중 에러.")}
        $("#tmp").text( "API 접근 중 에러." );
      })
      setTimeout(setUpbitData, 13000);
    }
    $(function() {
      setUpbitData();
    });
    </script>
  </head>
  <body>
    <div id='tmp' style="color:pink;">
    </div>
    <br /><br />
    <table id="table_ticker" class="table table-hover text-center">
      <thead>
      <tr>
        <td>NO</td>
        <td>한글명</td>
        <td>현재가</td>
        <td>전일대비</td>
        <td>거래대금</td>
      </tr>
      </thead>
      <tbody>
      </tbody>
    </table>
    <br /><br /><br />
    <div id='tmp2'>

    </div>


  </body>


<%@ include file="layout/footer.jsp"%>