USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TICKERS_ACTUALIZA_ESTADO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TICKERS_ACTUALIZA_ESTADO]   
(    
 @folio   as numeric,  --Número Operacion    
 @nemotecnico as char(10), --Codigo Instrumento    
 @codigo_bac  as numeric,  --Número entregado por BAC para la operación  
 @estado  as numeric --  
)    
as 
BEGIN
 update tbl_tickers_bolsa     
 set	estado  = @estado    
 where  folio = @folio

 update tbl_tickers_bolsa     
 set	estado  = @estado,    
		codigo_bac = 0    
 where  codigo_bac = @codigo_bac
END
GO
