USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEMONEDA2]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_LEEMONEDA2]
as
begin
 select codigo_numerico,codigo_caracter,glosa 
 from BACPARAMsuda..TBCODIGOSOMA 
 order by codigo_numerico
end

GO
