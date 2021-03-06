USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAART84]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGAART84] 
as
begin
set nocount on 
 select
  'nombre'  = isnull(clnombre,'')  ,
  'patrimonio' = isnull(patrimonio,0)  ,
  'porcentaje' = isnull(porcentaje,0.0) ,
  'gara'  = usa_garantias   ,
  'garantias' = isnull(garantias,0.0)  ,
  'rut'  = rut    ,
  'codigo' = codigo   ,
  'montoocup' = monto_ocupado          ,
  'tipocliente' = cltipcli      ,
  'rut_completo'  = rtrim(convert(char(10),rut)) + '-' + cldv
 from 
  MD_ART84 ,
  VIEW_CLIENTE 
 where 
  clrut    = rut
 and clcodigo = codigo
  
      
end
                                                                                                   
-- select * from MD_ART84
--  patrimonio               porcentaje               monto_ocupado            garantias                
                                  
-- execute sp_datcliart84 97006000,1
                                                                                                                     
                                                                                                                                       

GO
