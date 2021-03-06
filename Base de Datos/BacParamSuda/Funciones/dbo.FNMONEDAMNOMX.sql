USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FNMONEDAMNOMX]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FNMONEDAMNOMX](@codmon		varchar(5)                                       
                                       ) returns varchar(2)
as
Begin
   Declare @Tipo varchar(1)
   set @Tipo  = ''
   select @Tipo = mnmx from BacParamSuda..moneda where mnnemo = @codmon
   return  case when @Tipo = 'C' then 'MX' else 'MN' end 	
end --termina funcion

GO
