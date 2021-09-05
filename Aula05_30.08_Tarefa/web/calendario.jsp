<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.time.YearMonth"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
     int m, a;
     String error = null;
     if (request.getParameter("mes") == null || request.getParameter("ano") == null) {
         error = "Não foram informados os dois parâmetros necessários 'mês' e 'ano'";
     }
     else {
         try {              
            m  = Integer.parseInt(request.getParameter("mes"));              
            if (m < 1 || m > 12) {            
            error = "O valor informado para mês deve estar entre 1 e 12";                
            }            
     }
     catch (Exception e) { 
            error = "O valor informado como parâmetro 'mês' (" 
                    + request.getParameter("mes") + ") não é um número válido";         
            }    
     
      try {            
            a  = Integer.parseInt(request.getParameter("ano"));          
          }
      catch (Exception e) {               
         
             error = "O valor informado como parâmetro 'ano' (" 
                    + request.getParameter("ano") + ") não é um número válido";         
            }          
     }
%>
<!DOCTYPE html>
<html>
    <head>
       <title>Calendário</title> 
       <link rel='shortcut icon' href='https://icons.iconarchive.com/icons/marcus-roberto/google-play/256/Google-Calendar-icon.png'/>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">
        
    </head>
    <body class="flex flex-col items-center justify-center min-h-screen gap-5">
        <div class="box flex flex-col items-center justify-center">
            <div class="flex flex-col items-center justify-center text-center gap-7">
            <% 
                try {           
                    Integer ano = Integer.parseInt(request.getParameter("ano"));
                    Integer mes = Integer.parseInt(request.getParameter("mes"));
                    Integer dia = YearMonth.of(ano,mes).atEndOfMonth().getDayOfMonth();
                    Integer weekOne = YearMonth.of(ano, mes).atDay(1).getDayOfWeek().getValue();
                    boolean dayOne = true;
                    List<String> meses = 
                    Arrays.asList("JANEIRO", "FEVEREIRO", "MARÇO", "ABRIL", "MAIO",
                    "JUNHO", "JULHO", "AGOSTO", "SETEMBRO", "OUTUBRO", "NOVEMBRO", "DEZEMBRO");
                    out.print("<h1 class='font-bold text-3xl'>"+ meses.get(mes-1) + " " + ano + "</h1>");
                    out.print("<div class='flex flex-col gap-3'>");
                    out.print("<div class='flex'>");
                    out.print("<div class='size'>SEG</div>");
                    out.print("<div class='size'>TER</div>");
                    out.print("<div class='size'>QUA</div>");
                    out.print("<div class='size'>QUI</div>");
                    out.print("<div class='size'>SEX</div>");
                    out.print("<div class='size'>SAB</div>");
                    out.print("<div class='size'>DOM</div>");
                    out.print("</div>");
                    Integer d = 1;
                    while(d <= dia){
                        out.print("<div class='flex text-700'>");
                            Integer week = 1;
                            for(; week <= 7; week++){
                                if(dayOne){
                                    if(week == weekOne) {
                                        dayOne = false;
                                        if (d<10) {
                                        out.print("<div class='text-center size'> 0"+d+"</div>");
                                        }
                                        else {
                                        out.print("<div class='text-center size'>"+d+"</div>");
                                        }
                                        d++;
                                        continue;
                                    }
                                    out.print("<div class='size'></div>");
                                    continue;
                                }
                                if(d > dia) {
                                    out.print("<div class='size'></div>");
                                    continue;
                                }
                                if (d<10) {
                                out.print("<div class='text-center size'> 0"+d+"</div>");
                                }
                                else {
                                out.print("<div class='text-center size'>"+d+"</div>");
                                }
                                d++;
                            }
                        out.print("</div>");
                    }
                    out.print("</div>");
                    out.print("</div>");                   
                } catch (Exception e) {
                       out.print("<p>Ocorreu um erro: <br>" + error + "</p>");
                }
            %>
            <button class="btn">               
              <a href="index.html"> 
               <img src="https://icons.iconarchive.com/icons/icons8/ios7/256/Arrows-Left-3-icon.png" title="Voltar"/>
              </a>
            </button>
        </div>
    </body>
</html>
<style>
* {
color: #F8F8FF;
}
.size {
width: 50px;
border-style: solid;
border-width: 1px;
}
.btn img {
margin-top: 30px; 
width: 40px;
height: 40px;
}
.box {
width: 500px;
height: 500px;
background: #6A5ACD;
}
</style>
