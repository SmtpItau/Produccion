USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTIENESERIESDEFILTROS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_OBTIENESERIESDEFILTROS]  
(  
  @FechaProceso datetime,  
  @Codigo_CarteraSuper char(1),  
  @Tipo_Cartera_Financiera char(2),  
  @Cadena_Familias varchar(255),  
  @Cadena_Monedas varchar(255),  
  @Id_Libro char(10),  
  @modo char(1)  
)  
AS  
BEGIN  
--- Autor   : Jorge Bravo H.  
--- Fecha   : 22-Octubre-2009  
--- Objetivo: Retorna la lista de Series como resultado del proceso de filtrado  
---  
IF @modo = 'N'  
BEGIN  
 SELECT    
   ISNULL(car.id_instrum , ' '),  
   ISNULL(car.cod_familia, 0),  
   ISNULL(car.cpmonemi, 0),   
   1  
 FROM Bacbonosextsuda.dbo.text_ctr_inv car  
 WHERE car.cpfecneg    <= @FechaProceso  
 AND  car.codigo_carterasuper   = @codigo_carterasuper  
 AND  car.tipo_cartera_financiera  = @tipo_cartera_financiera  
 AND  car.Id_Libro     = @id_libro  
 AND  CHARINDEX(RTRIM(LTRIM(CONVERT(char(5),car.cod_familia))),@Cadena_Familias) > 0  
 AND   ( CHARINDEX(RTRIM(LTRIM(CONVERT(char(5),car.cpmonemi))), @Cadena_Monedas) > 0 OR @Cadena_Monedas = '' )  
 AND  car.cpnominal    > 0  
 AND  car.cpnomi_vta    < car.cpnominal  
 AND  car.cpfecven    >= @FechaProceso  
 GROUP BY car.id_instrum, car.cod_familia, car.cpmonemi  
END  
  
IF @modo = 'I'  
BEGIN  
 SELECT    
  ISNULL(car.id_instrum , ' '),  
  ISNULL(car.cod_familia, 0),  
  ISNULL(car.cpmonemi, 0),   
  1  
 FROM Bacbonosextsuda.dbo.CAR_ticketbonext car  
 WHERE   
  car.cpfecneg <= @FechaProceso  
 AND car.codigo_carterasuper = @codigo_carterasuper  
 AND car.tipo_cartera_financiera = @tipo_cartera_financiera  
 AND car.Id_Libro = @id_libro  
 AND CHARINDEX(RTRIM(LTRIM(CONVERT(char(5),car.cod_familia))),@Cadena_Familias) > 0  
 AND ( CHARINDEX(RTRIM(LTRIM(CONVERT(char(5),car.cpmonemi))), @Cadena_Monedas) > 0 OR @Cadena_Monedas = '' )  
 AND car.cpnominal > 0  
 AND car.cpnomi_vta < car.cpnominal  
 AND  car.cpfecven >= @FechaProceso  
 GROUP BY car.id_instrum, car.cod_familia, car.cpmonemi  
END  
  
END  

GO
