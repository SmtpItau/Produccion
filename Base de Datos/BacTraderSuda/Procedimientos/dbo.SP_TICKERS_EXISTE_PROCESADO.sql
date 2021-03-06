USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TICKERS_EXISTE_PROCESADO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_TICKERS_EXISTE_PROCESADO]    
(      
 @folio      as numeric, --Numero Operacion      
 @nemotecnico    as char(10) --Codigo Instrumento      
)      
as      
BEGIN
 select max(codigo_bac) from tbl_tickers_bolsa      
 where folio = @folio      
 and  nemotecnico = @nemotecnico      
END
GO
