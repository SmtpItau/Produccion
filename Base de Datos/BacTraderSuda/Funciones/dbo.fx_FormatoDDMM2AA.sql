USE [BacTraderSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_FormatoDDMM2AA]    Script Date: 13-05-2022 11:19:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fx_FormatoDDMM2AA]
(	
   @fecha datetime
)
RETURNS varchar(7) 
AS
Begin
   declare @STRAux Varchar(7)
   /* Checar si puede recibir la tabla como parametros
      para no hacer tantas funciones */
  select @STRAux = case when day(@fecha) > 9 then convert(varchar(2), day(@fecha) ) 
                                             else '0' + convert(varchar(1), day(@fecha) ) end
                +  case when month(@fecha) > 9 then convert(varchar(2), month(@fecha) ) 
                                             else '0' + convert(varchar(1), month(@fecha) ) end
				+ '2'
				+  substring( convert( varchar(4), year(@fecha)) , 3, 2 ) 
  return @STRAux 
End
GO
