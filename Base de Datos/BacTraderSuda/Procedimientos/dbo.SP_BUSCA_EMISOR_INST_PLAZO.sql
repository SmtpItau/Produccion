USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_EMISOR_INST_PLAZO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_EMISOR_INST_PLAZO]( @rut   numeric(10)  ,
     @instrumento char(06) )
as
begin
 select  instrumento ,
         plazo_ini ,
  plazo_fin ,
  isnull(monto_asignado,0) ,
  isnull(monto_ocupado,0)            
 from 
  MD_EMISOR_INST_PLAZO 
 where  
  rut = @rut and
  instrumento = @instrumento
 order by plazo_ini
end   /* fin procedimiento */
-- delete from    MD_EMISOR_INST_PLAZO 


GO
